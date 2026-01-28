# Get-SystemInfo.ps1
# This script prints basic system info for troubleshooting.
Write-Host "--- SYSTEM INFO ---" -ForegroundColor Cyan
Get-ComputerInfo | Select-Object WindowsProductName, CsProcessors, OsArchitecture | Out-Host
Write-Host "--- NETWORK INFO ---" -ForegroundColor Yellow
Get-NetIPAddress -AddressFamily IPv4 | Where-Object PrefixOrigin -ne "WellKnown" | Select-Object InterfaceAlias, IPAddress | Out-Host
Write-Host "--- DISK SPACE ---" -ForegroundColor Green
Get-Volume -DriveLetter C | Select-Object DriveLetter, FileSystemLabel, @{Name="Free(GB)";Expression={[math]::Round($_.SizeRemaining / 1GB, 2)}} | Out-Host
Write-Host "Audit Complete." -ForegroundColor Green

