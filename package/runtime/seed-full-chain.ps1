param(
    [string]$BaseUrl = "http://127.0.0.1:18085"
)

$ErrorActionPreference = "Stop"

function Invoke-Api {
    param(
        [string]$Method,
        [string]$Path,
        [string]$Token,
        [object]$Body
    )
    $parameters = @{
        Method = $Method
        Uri = $BaseUrl + $Path
        ContentType = "application/json; charset=utf-8"
    }
    if ($Token) {
        $parameters.Headers = @{ Authorization = "Bearer $Token" }
    }
    if ($null -ne $Body) {
        $parameters.Body = [Text.Encoding]::UTF8.GetBytes(($Body | ConvertTo-Json -Depth 12))
    }
    Invoke-RestMethod @parameters
}

function Login {
    param([string]$Phone)
    $result = Invoke-Api Post "/api/auth/login" $null @{
        username = $Phone
        password = "12345678"
    }
    return $result.token
}

function Submit-Event {
    param(
        [string]$Token,
        [string]$BatchId,
        [string]$EventType,
        [string]$BusinessTime,
        [string]$Location,
        [hashtable]$ProcessData,
        [long]$TargetOrgId = 0,
        [long]$CarrierOrgId = 0
    )
    $result = Invoke-Api Post "/api/batches/$BatchId/events" $Token @{
        eventType = $EventType
        businessTime = $BusinessTime
        locationCode = $Location
        processData = $ProcessData
        evidenceIds = @()
        requestId = [guid]::NewGuid().ToString()
        targetOrgId = if ($TargetOrgId -gt 0) { $TargetOrgId } else { $null }
        carrierOrgId = if ($CarrierOrgId -gt 0) { $CarrierOrgId } else { $null }
        discrepancyCode = $ProcessData["discrepancyCode"]
        correctionOf = $null
    }
    Write-Host "Submitted $EventType -> $($result.id)"
    return $result
}

function Approve-Event {
    param([string]$Token, [string]$EventId, [string]$Comment)
    $result = Invoke-Api Post "/api/reviews/$EventId/approve" $Token @{ comment = $Comment }
    Write-Host "Approved $EventId -> $($result.chainStatus), tx=$($result.txId)"
    return $result
}

$supplierAdmin = Login "13910000001"
$supplierBreeder = Login "13910000002"
$supplierQa = Login "13910000003"
$supplierShipper = Login "13910000004"
$supplierOperator = Login "13910000005"
$processorAdmin = Login "13920000001"
$processorOperator = Login "13920000002"
$processorQa = Login "13920000003"
$processorWarehouse = Login "13920000004"
$logisticsAdmin = Login "13930000001"
$logisticsDispatcher = Login "13930000002"
$logisticsDriver = Login "13930000003"
$retailerAdmin = Login "13940000001"
$retailerReceiver = Login "13940000002"
$retailerSales = Login "13940000003"

$organizations = Invoke-Api Get "/api/directory/organizations" $supplierOperator
$processorOrg = $organizations | Where-Object { $_.org_code -eq "PRO001" } | Select-Object -First 1
$logisticsOrg = $organizations | Where-Object { $_.org_code -eq "LOG001" } | Select-Object -First 1
$retailerOrg = $organizations | Where-Object { $_.org_code -eq "RET001" } | Select-Object -First 1
if (-not $processorOrg -or -not $logisticsOrg -or -not $retailerOrg) {
    throw "Required downstream organizations were not found"
}

$raw = Invoke-Api Post "/api/batches" $supplierOperator @{
    batchType = "RAW_DUCK"
    productName = "常德麻鸭"
    spec = "活鸭，约2.5kg/只"
    quantity = 100
    unit = "只"
    productionDate = "2026-11-08"
    expiryDate = $null
    parentBatchIds = @()
    relationType = "MERGE"
}
Write-Host "Created raw batch $($raw.batchNo), tx=$($raw.txId)"

$breeding = Submit-Event $supplierBreeder $raw.id "BREEDING_RECORD" `
    "2026-11-08T08:00:00" "常德市鼎城区1号麻鸭养殖场" @{
        breedingBatchNo = "YZ-20261108-01"
        feedBatchNo = "SL-20261106-02"
        vaccineRecord = "YM-20261020-01"
        medicationRecord = "YY-20261101-03"
        withdrawalPeriodEnd = "2026-11-06"
        stockQuantity = "100"
        healthStatus = "正常"
        remark = "养殖周期120天，鸭群健康，休药期已结束"
    }

$supplierQuality = Submit-Event $supplierQa $raw.id "QUALITY_CHECK" `
    "2026-11-08T08:30:00" "供应商内部质检室" @{
        sampleNo = "SUP-QC-20261108-01"
        inspectionType = "工序抽检"
        moisture = "68.5"
        microbialResult = "PASS"
        overallResult = "PASS"
        remark = "感官正常，微生物指标符合要求"
    }

$quarantine = Submit-Event $supplierOperator $raw.id "QUARANTINE" `
    "2026-11-08T09:00:00" "常德市动物检疫申报点" @{
        quarantineCertNo = "JY-430700-20261108-001"
        quarantineResult = "PASS"
        quarantineDate = "2026-11-08"
        issuerOrg = "常德市动物疫病预防控制中心"
    }

$supplierBatchReview = Invoke-Api Post "/api/reviews/batch-approve" $supplierAdmin @{
    eventIds = @($breeding.id, $supplierQuality.id, $quarantine.id)
    comment = "供应商三类记录统一审核通过"
}
Write-Host "Supplier batch review: $($supplierBatchReview.succeeded)/$($supplierBatchReview.requested)"

$dispatch = Submit-Event $supplierShipper $raw.id "DISPATCH" `
    "2026-11-08T09:30:00" "供应商发货区" @{
        vehicleRef = "湘JB1688"
        destination = "常德酱板鸭食品有限公司原料仓库"
        temperature = "4"
        sealNo = "SEAL-SUP-20261108-001"
    } $processorOrg.id $logisticsOrg.id
$dispatch = Approve-Event $supplierAdmin $dispatch.id "供应商发货审核通过"

$receiveRaw = Submit-Event $processorOperator $raw.id "RECEIVE" `
    "2026-11-08T10:00:00" "加工企业原料收货区" @{
        quantityReceived = "100"
        temperature = "4"
        packageIntact = "是"
        discrepancyCode = ""
    }
$receiveRaw = Approve-Event $processorAdmin $receiveRaw.id "加工企业收货审核通过"

$finished = $raw
Write-Host "Continue processing in the same batch $($finished.batchNo)"

$slaughter = Submit-Event $processorOperator $finished.id "SLAUGHTER" `
    "2026-11-08T10:30:00" "常德酱板鸭食品有限公司屠宰车间" @{
        slaughterhouseId = "CZDY-SL-01"
        liveWeight = "250"
        carcassWeight = "180"
        preSlaughterQuarantineResult = "PASS"
        marinadeStartAt = "2026-11-08T11:00:00"
        marinadeEndAt = "2026-11-08T15:00:00"
        marinadeDurationMin = "240"
        brineTemperature = "4"
        saltBatchNo = "SY-20261106-01"
    }
$slaughter = Approve-Event $processorAdmin $slaughter.id "屠宰记录审核通过"

$marinate = Submit-Event $processorOperator $finished.id "MARINATE" `
    "2026-11-08T15:00:00" "一号腌制车间" @{
        startAt = "2026-11-08T11:00:00"
        endAt = "2026-11-08T15:00:00"
        durationMin = "240"
        temperature = "4"
        saltBatchNo = "SY-20261106-01"
        equipmentId = "YAN-01"
        sensorFileHash = ""
    }
$marinate = Approve-Event $processorAdmin $marinate.id "腌制记录审核通过"

$sauce = Submit-Event $processorOperator $finished.id "SAUCE" `
    "2026-11-08T16:50:00" "一号酱卤车间" @{
        formulaVersion = "CDJBY-FORMULA-V3"
        startAt = "2026-11-08T15:20:00"
        endAt = "2026-11-08T16:50:00"
        durationMin = "90"
        setTemperature = "95"
        actualTemperature = "94.5"
        pressureKPa = "101"
        pH = "6.2"
        salinity = "3.5"
        ccpResult = "PASS"
        equipmentId = "LU-02"
    }
$sauce = Approve-Event $processorAdmin $sauce.id "酱卤记录审核通过"

$roast = Submit-Event $processorOperator $finished.id "ROAST" `
    "2026-11-08T18:30:00" "烘烤一车间" @{
        processType = "烘烤"
        equipmentId = "HK-01"
        startAt = "2026-11-08T17:00:00"
        endAt = "2026-11-08T18:30:00"
        setTemperature = "180"
        coreTemperature = "78"
        humidity = "35"
        ccpCompliant = "PASS"
        exceptionCode = ""
    }
$roast = Approve-Event $processorAdmin $roast.id "烘烤记录审核通过"

$processorQuality = Submit-Event $processorQa $finished.id "QUALITY_CHECK" `
    "2026-11-08T19:00:00" "加工企业质检室" @{
        sampleNo = "PRO-QA-20261108-01"
        inspectionType = "微生物检测"
        moisture = "45.2"
        microbialResult = "PASS"
        overallResult = "PASS"
        remark = "菌落总数和大肠菌群均符合企业标准"
    }
$processorQuality = Approve-Event $processorAdmin $processorQuality.id "加工质检审核通过"

$package = Submit-Event $processorOperator $finished.id "PACKAGE" `
    "2026-11-08T20:00:00" "真空包装一车间" @{
        productName = "常德酱板鸭"
        productCode = "CDJBY-600"
        spec = "600g/袋"
        netWeight = "600"
        packageQuantity = "100"
        packageMaterialBatchNo = "BZ-20261107-01"
        vacuumDegree = "-0.095MPa"
        sealTemperature = "145"
        productionLineNo = "PACK-LINE-01"
        qaResult = "PASS"
        expiryDate = "2027-05-08"
    }
$package = Approve-Event $processorAdmin $package.id "包装记录审核通过"
$finished = (Invoke-Api Get "/api/batches/$($raw.id)" $processorAdmin).batch
Write-Host "Batch converted to finished product, trace=$($finished.traceCode)"

$warehouse = Submit-Event $processorWarehouse $finished.id "WAREHOUSE_IN" `
    "2026-11-08T20:30:00" "成品冷库一号库" @{
        warehouseId = "CZDY-WH-01"
        binNo = "A-01-03"
        quantity = "100"
        temperature = "4"
        coldChainStatus = "NORMAL"
    }
$warehouse = Approve-Event $processorAdmin $warehouse.id "成品入库审核通过"

$processorDispatch = Submit-Event $processorOperator $finished.id "DISPATCH" `
    "2026-11-08T21:00:00" "成品冷库发货区" @{
        vehicleRef = "湘J-LOG-03"
        destination = "常德老街特产店"
        temperature = "4"
        sealNo = "SEAL-PRO-20261108-001"
    } $retailerOrg.id $logisticsOrg.id
$processorDispatch = Approve-Event $processorAdmin $processorDispatch.id "加工发货审核通过"

$transport = Submit-Event $logisticsDispatcher $finished.id "TRANSPORT" `
    "2026-11-08T21:20:00" "沅水冷链物流运输节点" @{
        vehicleRef = "湘J-LOG-03"
        sealNo = "SEAL-PRO-20261108-001"
        fromPlace = "常德酱板鸭食品有限公司"
        toPlace = "常德老街特产店"
        temperature = "4"
        alarmCount = "0"
        coldChainCompliant = "PASS"
    }
$transport = Approve-Event $logisticsAdmin $transport.id "运输登记审核通过"

$deliver = Submit-Event $logisticsDriver $finished.id "DELIVER" `
    "2026-11-08T22:00:00" "常德老街特产店收货区" @{
        deliveredAt = "2026-11-08T22:00:00"
        receiptResult = "正常"
        temperature = "4"
        discrepancyCode = ""
    }
$deliver = Approve-Event $logisticsAdmin $deliver.id "交付记录审核通过"

$retailReceive = Submit-Event $retailerReceiver $finished.id "RECEIVE" `
    "2026-11-08T22:10:00" "常德老街特产店" @{
        quantityReceived = "100"
        temperature = "4"
        packageIntact = "是"
        discrepancyCode = ""
    }
$retailReceive = Approve-Event $retailerAdmin $retailReceive.id "门店收货审核通过"

$sale = Submit-Event $retailerSales $finished.id "SALE" `
    "2026-11-08T23:00:00" "常德老街特产店" @{
        quantitySold = "100"
        remainingQuantity = "0"
        salesChannel = "门店"
        saleOrderHash = "SALE-20261108-001"
        storageTemperature = "4"
    }
$sale = Approve-Event $retailerAdmin $sale.id "终端销售审核通过"

$publicTrace = Invoke-Api Get ("/api/public/trace/" + [uri]::EscapeDataString($finished.traceCode)) $null
$detail = Invoke-Api Get "/api/batches/$($finished.id)" $processorAdmin

Write-Host ""
Write-Host "FULL_CHAIN_SEED_OK"
Write-Host "Raw batch:      $($raw.batchNo)"
Write-Host "Finished batch: $($finished.batchNo)"
Write-Host "Trace code:     $($finished.traceCode)"
Write-Host "Stage:          $($detail.batch.currentStage)"
Write-Host "Status:         $($detail.batch.status)"
Write-Host "Events:         $($detail.events.Count)"
Write-Host "Public events:  $($publicTrace.events.Count)"
Write-Host "Latest tx:      $($sale.txId)"
