# Test-NetworkHealth.ps1
# Purpose: Sequentially tests network layers to isolate connectivity failures.

Write-Host "--- Starting Network Diagnostic Trinity ---" -ForegroundColor Cyan

# 1. Test Internal Hardware (Loopback)
Write-Host "[1/3] Testing Internal Network Card..." -NoNewline
if (Test-Connection -ComputerName 127.0.0.1 -Count 1 -Quiet) {
    Write-Host " PASS" -ForegroundColor Green
} else {
    Write-Host " FAIL: Hardware issue detected." -ForegroundColor Red
}

# 2. Test Local Connection (Gateway)
# We pull the Gateway IP automatically so the script works anywhere.
$Gateway = (Get-NetRoute -DestinationPrefix 0.0.0.0/0 | Select-Object -First 1).NextHop
Write-Host "[2/3] Testing Router Gateway ($Gateway)..." -NoNewline
if (Test-Connection -ComputerName $Gateway -Count 1 -Quiet) {
    Write-Host " PASS" -ForegroundColor Green
} else {
    Write-Host " FAIL: Local network/router disconnect." -ForegroundColor Red
}

# 3. Test External Connection (Cloudflare DNS)
Write-Host "[3/3] Testing Internet Reachability (1.1.1.1)..." -NoNewline
if (Test-Connection -ComputerName 1.1.1.1 -Count 1 -Quiet) {
    Write-Host " PASS" -ForegroundColor Green
} else {
    Write-Host " FAIL: ISP or Firewall issue." -ForegroundColor Red
}

Write-Host "--- Diagnostic Complete ---" -ForegroundColor Cyan
