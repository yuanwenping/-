$ErrorActionPreference = "Stop"

$Vmrun = "D:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe"
$VmDirectory = Get-ChildItem -LiteralPath "F:\" -Directory |
    Where-Object { $_.Name -like "yanyuanyuanfabric*" } |
    Select-Object -First 1
$Vmx = if ($VmDirectory) { Join-Path $VmDirectory.FullName "yanyuanyuanfabric.vmx" } else { $null }
$SshKey = "C:\Users\lx\.ssh\codex_yuan_vm_ed25519_v2"

if (-not (Test-Path -LiteralPath $Vmrun)) { throw "vmrun.exe was not found: $Vmrun" }
if (-not (Test-Path -LiteralPath $Vmx)) { throw "Fabric VM was not found: $Vmx" }
if (-not (Test-Path -LiteralPath $SshKey)) { throw "VM SSH key was not found: $SshKey" }

$running = (& $Vmrun -T ws list) -join "`n"
if ($running -notmatch [regex]::Escape($Vmx)) {
    Write-Host "Starting yuanwenping VM..."
    & $Vmrun -T ws start $Vmx nogui
    if ($LASTEXITCODE -ne 0) { throw "Unable to start the Fabric VM" }
}

$guestIp = $null
for ($i = 0; $i -lt 30; $i++) {
    Start-Sleep -Seconds 2
    try {
        $guestIp = (& $Vmrun -T ws getGuestIPAddress $Vmx) 2>$null
        if ($guestIp -match '^\d+\.\d+\.\d+\.\d+$') { break }
    } catch {
        $guestIp = $null
    }
}
if (-not $guestIp) { throw "The Fabric VM did not report a guest IP address" }

$remoteCommand = "docker start trace4-orderer.example.com >/dev/null 2>&1 || true; sleep 5; docker start trace4-peer0.supplier.example.com trace4-peer0.processor.example.com trace4-peer0.logistics.example.com trace4-peer0.retailer.example.com >/dev/null 2>&1 || true; sleep 10; docker start trace4-cli >/dev/null 2>&1 || true; cd /home/yuan/explorer && docker-compose up -d >/dev/null 2>&1 || true; docker ps --filter status=running --format '{{.Names}}'"
$runningContainers = & ssh -o BatchMode=yes -o ConnectTimeout=10 -i $SshKey "yuan@$guestIp" $remoteCommand
if ($LASTEXITCODE -ne 0) { throw "Unable to start Fabric containers" }

foreach ($required in @(
    "trace4-orderer.example.com",
    "trace4-peer0.supplier.example.com",
    "trace4-peer0.processor.example.com",
    "trace4-peer0.logistics.example.com",
    "trace4-peer0.retailer.example.com",
    "trace4-cli"
)) {
    if ($runningContainers -notcontains $required) {
        throw "Fabric container is not running: $required"
    }
}

Write-Host "Four-organization Fabric tracechannel is ready at $guestIp."
