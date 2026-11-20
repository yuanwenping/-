#!/usr/bin/env bash
set -euo pipefail

CHANNEL="tracechannel"
ORDERER="orderer.example.com:7050"
ORDERER_CA="/work/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
cd /work

for spec in \
  "Supplier supplier 7051" \
  "Processor processor 8051" \
  "Logistics logistics 9051" \
  "Retailer retailer 10051"
do
  set -- $spec
  ORG_NAME="$1"
  ORG_DIR="$2"
  PORT="$3"
  MSP="${ORG_NAME}MSP"
  HOST="peer0.${ORG_DIR}.example.com"
  PREFIX="/work/anchor-${ORG_DIR}"

  export CORE_PEER_TLS_ENABLED=true
  export CORE_PEER_LOCALMSPID="$MSP"
  export CORE_PEER_TLS_ROOTCERT_FILE="/work/organizations/peerOrganizations/${ORG_DIR}.example.com/peers/${HOST}/tls/ca.crt"
  export CORE_PEER_MSPCONFIGPATH="/work/organizations/peerOrganizations/${ORG_DIR}.example.com/users/Admin@${ORG_DIR}.example.com/msp"
  export CORE_PEER_ADDRESS="${HOST}:${PORT}"

  peer channel fetch config "${PREFIX}-block.pb" \
    -o "$ORDERER" --ordererTLSHostnameOverride orderer.example.com \
    -c "$CHANNEL" --tls --cafile "$ORDERER_CA"

  configtxlator proto_decode \
    --input "${PREFIX}-block.pb" \
    --type common.Block \
    --output "${PREFIX}-block.json"
  jq '.data.data[0].payload.data.config' "${PREFIX}-block.json" > "${PREFIX}-config.json"

  jq --arg msp "$MSP" --arg host "$HOST" --argjson port "$PORT" \
    '.channel_group.groups.Application.groups[$msp].values.AnchorPeers =
      {mod_policy:"Admins",value:{anchor_peers:[{host:$host,port:$port}]},version:"0"}' \
    "${PREFIX}-config.json" > "${PREFIX}-modified.json"

  configtxlator proto_encode \
    --input "${PREFIX}-config.json" \
    --type common.Config \
    --output "${PREFIX}-original.pb"
  configtxlator proto_encode \
    --input "${PREFIX}-modified.json" \
    --type common.Config \
    --output "${PREFIX}-modified.pb"
  configtxlator compute_update \
    --channel_id "$CHANNEL" \
    --original "${PREFIX}-original.pb" \
    --updated "${PREFIX}-modified.pb" \
    --output "${PREFIX}-update.pb"
  configtxlator proto_decode \
    --input "${PREFIX}-update.pb" \
    --type common.ConfigUpdate \
    --output "${PREFIX}-update.json"

  jq -n --arg channel "$CHANNEL" --slurpfile update "${PREFIX}-update.json" \
    '{payload:{header:{channel_header:{channel_id:$channel,type:2}},
      data:{config_update:$update[0]}}}' > "${PREFIX}-envelope.json"
  configtxlator proto_encode \
    --input "${PREFIX}-envelope.json" \
    --type common.Envelope \
    --output "${PREFIX}-update.tx"

  peer channel update \
    -o "$ORDERER" --ordererTLSHostnameOverride orderer.example.com \
    -c "$CHANNEL" -f "${PREFIX}-update.tx" \
    --tls --cafile "$ORDERER_CA"
  echo "Anchor peer updated for ${MSP}"
done
