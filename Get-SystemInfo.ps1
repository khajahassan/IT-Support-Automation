# Get-SystemInfo.ps1
# This script gets basic system info for troubleshooting.
Write-Host "Gathering System Information..." -ForegroundColor Cyan
Get-ComputerInfo | Select-Object WindowsProductName, CsProcessors, OsArchitecture
Get-NetIPAddress -AddressFamily IPv4 | Select-Object InterfaceAlias, IPAddress
Write-Host "Audit Complete." -ForegroundColor Green
