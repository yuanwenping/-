package com.changde.trace.trace;

import com.changde.trace.api.ApiException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PreDestroy;
import org.hyperledger.fabric.sdk.BlockEvent;
import org.hyperledger.fabric.sdk.Channel;
import org.hyperledger.fabric.sdk.Enrollment;
import org.hyperledger.fabric.sdk.HFClient;
import org.hyperledger.fabric.sdk.Orderer;
import org.hyperledger.fabric.sdk.Peer;
import org.hyperledger.fabric.sdk.ProposalResponse;
import org.hyperledger.fabric.sdk.QueryByChaincodeRequest;
import org.hyperledger.fabric.sdk.TransactionProposalRequest;
import org.hyperledger.fabric.sdk.User;
import org.hyperledger.fabric.sdk.exception.InvalidArgumentException;
import org.hyperledger.fabric.sdk.security.CryptoSuite;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.PrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.time.Duration;
import java.util.Base64;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class ChainService {
    private static final Logger LOG = LoggerFactory.getLogger(ChainService.class);
    private final boolean enabled;
    private final String channelName;
    private final String chaincodeName;
    private final String ordererEndpoint;
    private final String ordererAuthority;
    private final String supplierMsp;
    private final Map<String, OrgMaterial> material = new HashMap<>();
    private final Map<String, FabricConnection> connections = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper;

    public ChainService(
            @Value("${fabric.enabled:true}") boolean enabled,
            @Value("${fabric.channel}") String channelName,
            @Value("${fabric.chaincode}") String chaincodeName,
            @Value("${fabric.endpoint-supplier}") String supplierEndpoint,
            @Value("${fabric.endpoint-processor}") String processorEndpoint,
            @Value("${fabric.endpoint-logistics}") String logisticsEndpoint,
            @Value("${fabric.endpoint-retailer}") String retailerEndpoint,
            @Value("${fabric.endpoint-orderer}") String ordererEndpoint,
            @Value("${fabric.msp-supplier}") String supplierMsp,
            @Value("${fabric.msp-processor}") String processorMsp,
            @Value("${fabric.msp-logistics}") String logisticsMsp,
            @Value("${fabric.msp-retailer}") String retailerMsp,
            @Value("${fabric.authority-supplier}") String supplierAuthority,
            @Value("${fabric.authority-processor}") String processorAuthority,
            @Value("${fabric.authority-logistics}") String logisticsAuthority,
            @Value("${fabric.authority-retailer}") String retailerAuthority,
            @Value("${fabric.authority-orderer}") String ordererAuthority,
            @Value("${fabric.supplier-cert}") Resource supplierCert,
            @Value("${fabric.supplier-key}") Resource supplierKey,
            @Value("${fabric.supplier-tls}") Resource supplierTls,
            @Value("${fabric.processor-cert}") Resource processorCert,
            @Value("${fabric.processor-key}") Resource processorKey,
            @Value("${fabric.processor-tls}") Resource processorTls,
            @Value("${fabric.logistics-cert}") Resource logisticsCert,
            @Value("${fabric.logistics-key}") Resource logisticsKey,
            @Value("${fabric.logistics-tls}") Resource logisticsTls,
            @Value("${fabric.retailer-cert}") Resource retailerCert,
            @Value("${fabric.retailer-key}") Resource retailerKey,
            @Value("${fabric.retailer-tls}") Resource retailerTls,
            @Value("${fabric.orderer-tls}") Resource ordererTls,
            ObjectMapper objectMapper
    ) {
        this.enabled = enabled;
        this.channelName = channelName;
        this.chaincodeName = chaincodeName;
        this.ordererEndpoint = ordererEndpoint;
        this.ordererAuthority = ordererAuthority;
        this.supplierMsp = supplierMsp;
        this.objectMapper = objectMapper;
        material.put(supplierMsp, new OrgMaterial(
                supplierMsp, supplierEndpoint, supplierAuthority,
                supplierCert, supplierKey, supplierTls));
        material.put(processorMsp, new OrgMaterial(
                processorMsp, processorEndpoint, processorAuthority,
                processorCert, processorKey, processorTls));
        material.put(logisticsMsp, new OrgMaterial(
                logisticsMsp, logisticsEndpoint, logisticsAuthority,
                logisticsCert, logisticsKey, logisticsTls));
        material.put(retailerMsp, new OrgMaterial(
                retailerMsp, retailerEndpoint, retailerAuthority,
                retailerCert, retailerKey, retailerTls));
        material.put("_orderer_tls", new OrgMaterial("_orderer_tls", ordererEndpoint,
                ordererAuthority, null, null, ordererTls));
    }

    public TraceModels.ChainSubmission submit(String mspId, String function, String... args) {
        if (!enabled) {
            return new TraceModels.ChainSubmission("FABRIC_DISABLED", null);
        }
        try {
            FabricConnection connection = connection(mspId);
            TransactionProposalRequest request = connection.client().newTransactionProposalRequest();
            request.setChaincodeName(chaincodeName);
            request.setFcn(function);
            request.setArgs(args);
            request.setProposalWaitTime(20_000);

            Collection<ProposalResponse> responses =
                    connection.channel().sendTransactionProposal(request, Set.of(connection.peer()));
            for (ProposalResponse response : responses) {
                if (!response.isVerified() || response.getStatus() != ProposalResponse.Status.SUCCESS) {
                    throw new IllegalStateException(response.getMessage());
                }
            }
            BlockEvent.TransactionEvent event =
                    connection.channel().sendTransaction(responses).get(30, java.util.concurrent.TimeUnit.SECONDS);
            if (event == null || !event.isValid()) {
                throw new IllegalStateException("transaction was not committed as VALID");
            }
            return new TraceModels.ChainSubmission(
                    event.getTransactionID(),
                    event.getBlockEvent().getBlockNumber()
            );
        } catch (Exception ex) {
            LOG.error("Fabric submit failed for function {}", function, ex);
            throw ApiException.chainError("区块链提交失败：" + rootMessage(ex));
        }
    }

    public JsonNode evaluate(String mspId, String function, String... args) {
        if (!enabled) {
            return objectMapper.createObjectNode().put("fabricEnabled", false);
        }
        try {
            FabricConnection connection = connection(mspId);
            QueryByChaincodeRequest request = connection.client().newQueryProposalRequest();
            request.setChaincodeName(chaincodeName);
            request.setFcn(function);
            request.setArgs(args);
            request.setProposalWaitTime(15_000);
            Collection<ProposalResponse> responses =
                    connection.channel().queryByChaincode(request, Set.of(connection.peer()));
            for (ProposalResponse response : responses) {
                if (response.getStatus() == ProposalResponse.Status.SUCCESS) {
                    return objectMapper.readTree(response.getChaincodeActionResponsePayload());
                }
            }
            String responseMessage = responses.stream()
                    .map(ProposalResponse::getMessage)
                    .filter(message -> message != null && !message.isBlank())
                    .distinct()
                    .collect(java.util.stream.Collectors.joining("; "));
            throw new IllegalStateException(
                    "chaincode query returned no successful response"
                            + (responseMessage.isBlank() ? "" : ": " + responseMessage));
        } catch (Exception ex) {
            LOG.error("Fabric query failed for function {}", function, ex);
            throw ApiException.chainError("区块链查询失败：" + rootMessage(ex));
        }
    }

    public boolean verify(String eventId, String hash) {
        if (!enabled) {
            return false;
        }
        JsonNode result = evaluate(supplierMsp, "VerifyEvent", eventId, hash);
        return result.isBoolean() && result.asBoolean();
    }

    public String status() {
        return status(supplierMsp);
    }

    public Map<String, String> mspStatuses() {
        Map<String, String> statuses = new java.util.LinkedHashMap<>();
        for (String mspId : List.of("SupplierMSP", "ProcessorMSP", "LogisticsMSP", "RetailerMSP")) {
            if (!material.containsKey(mspId)) {
                continue;
            }
            statuses.put(mspId, status(mspId));
        }
        return statuses;
    }

    private String status(String mspId) {
        if (!enabled) {
            return "DISABLED";
        }
        try {
            evaluate(mspId, "GetBatch", "__healthcheck__");
            return "CONNECTED";
        } catch (ApiException ex) {
            String message = ex.getMessage() == null ? "" : ex.getMessage();
            if (message.contains("does not exist")) {
                return "CONNECTED";
            }
            return "ERROR: " + message;
        }
    }

    @PreDestroy
    public void close() {
        connections.values().forEach(FabricConnection::close);
    }

    private FabricConnection connection(String mspId) throws Exception {
        OrgMaterial current = material.get(mspId);
        if (current == null) {
            throw new IllegalArgumentException("unknown MSP: " + mspId);
        }
        return connections.computeIfAbsent(mspId, ignored -> {
            try {
                return createConnection(current);
            } catch (Exception ex) {
                throw new IllegalStateException(ex);
            }
        });
    }

    private FabricConnection createConnection(OrgMaterial current) throws Exception {
        OrgMaterial ordererMaterial = material.get("_orderer_tls");

        HFClient client = HFClient.createNewInstance();
        client.setCryptoSuite(CryptoSuite.Factory.getCryptoSuite());
        client.setUserContext(new FabricUser(
                "User1",
                current.mspId(),
                read(current.cert()),
                privateKey(read(current.key()))
        ));

        Properties ordererProperties = tlsProperties(ordererMaterial.tls(), ordererMaterial.authority());
        Orderer orderer = client.newOrderer(ordererAuthority, ordererEndpoint, ordererProperties);

        Channel channel = client.newChannel(channelName);
        Peer currentPeer = null;
        for (OrgMaterial org : material.values()) {
            if ("_orderer_tls".equals(org.mspId())) {
                continue;
            }
            Peer peer = client.newPeer(org.authority(), org.endpoint(), tlsProperties(org.tls(), org.authority()));
            channel.addPeer(peer);
            if (org.mspId().equals(current.mspId())) {
                currentPeer = peer;
            }
        }
        if (currentPeer == null) {
            throw new IllegalStateException("No peer configured for MSP " + current.mspId());
        }
        channel.addOrderer(orderer);
        channel.initialize();
        return new FabricConnection(client, channel, currentPeer);
    }

    private Properties tlsProperties(Resource tlsResource, String authority) throws IOException {
        Properties properties = new Properties();
        properties.put("pemBytes", readBytes(tlsResource));
        properties.setProperty("hostnameOverride", authority);
        properties.setProperty("sslProvider", "openSSL");
        properties.setProperty("negotiationType", "TLS");
        return properties;
    }

    private String read(Resource resource) throws IOException {
        return new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
    }

    private byte[] readBytes(Resource resource) throws IOException {
        return resource.getInputStream().readAllBytes();
    }

    private PrivateKey privateKey(String pem) throws Exception {
        String normalized = pem
                .replace("-----BEGIN PRIVATE KEY-----", "")
                .replace("-----END PRIVATE KEY-----", "")
                .replaceAll("\\s+", "");
        byte[] encoded = Base64.getDecoder().decode(normalized);
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(encoded);
        for (String algorithm : List.of("EC", "RSA")) {
            try {
                return java.security.KeyFactory.getInstance(algorithm).generatePrivate(keySpec);
            } catch (Exception ignored) {
                // Try the next supported key algorithm.
            }
        }
        throw new IllegalArgumentException("unsupported private key format");
    }

    private String rootMessage(Throwable ex) {
        Throwable current = ex;
        while (current.getCause() != null) {
            current = current.getCause();
        }
        return current.getMessage() == null ? current.getClass().getSimpleName() : current.getMessage();
    }

    private record OrgMaterial(
            String mspId,
            String endpoint,
            String authority,
            Resource cert,
            Resource key,
            Resource tls
    ) {
    }

    private record FabricConnection(
            HFClient client,
            Channel channel,
            Peer peer
    ) {
        private void close() {
            channel.shutdown(true);
        }
    }

    private static final class FabricUser implements User {
        private final String name;
        private final String mspId;
        private final String certificate;
        private final Enrollment enrollment;

        private FabricUser(String name, String mspId, String certificate, PrivateKey privateKey) {
            this.name = name;
            this.mspId = mspId;
            this.certificate = certificate;
            this.enrollment = new Enrollment() {
                @Override
                public PrivateKey getKey() {
                    return privateKey;
                }

                @Override
                public String getCert() {
                    return certificate;
                }
            };
        }

        @Override
        public String getName() {
            return name;
        }

        @Override
        public Set<String> getRoles() {
            return Set.of();
        }

        @Override
        public String getAccount() {
            return name;
        }

        @Override
        public String getAffiliation() {
            return "";
        }

        @Override
        public Enrollment getEnrollment() {
            return enrollment;
        }

        @Override
        public String getMspId() {
            return mspId;
        }
    }
}
