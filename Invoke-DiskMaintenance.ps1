# Invoke-DiskMaintenance.ps1
# Purpose: Clears temporary system files to improve performance and free up space.

$TempFolders = @("$env:TEMP\*", "C:\Windows\Temp\*")
$InitialSpace = (Get-Volume -DriveLetter C).SizeRemaining

Write-Host "--- Starting Disk Maintenance ---" -ForegroundColor Cyan

foreach ($Folder in $TempFolders) {
	Write-Host "Cleaning: $Folder" -ForegroundColor Gray
	Remove-Item -Path $Folder -Recurse -Force -ErrorAction SilentlyContinue
}

$FinalSpace = (Get-Volume -DriveLetter C).SizeRemaining
$SpaceSaved = [math]::Round(($FinalSpace - $InitialSpace) / 1MB, 2)

Write-Host "Maintenance Complete!" -ForegroundColor Green
Write-Host "Space Recovered: $SpaceSaved MB" -ForegroundColor Yellow
