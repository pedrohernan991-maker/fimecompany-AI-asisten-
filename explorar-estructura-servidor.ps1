# Script para explorar la estructura del servidor
Write-Host "EXPLORANDO ESTRUCTURA DEL SERVIDOR..." -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

$ftpHost = "92.205.2.186"
$ftpUser = "cursor_ftp@fimecompany.com"
$ftpPass = "123456789009876543211234567890q"

# Script para explorar directorios
$ftpScript = @"
open $ftpHost
user $ftpUser $ftpPass
passive
binary
pwd
ls -la
cd public_html
pwd
ls -la
cd fimecompany.com
pwd
ls -la
quit
"@

$scriptFile = "explore-server.txt"
$ftpScript | Out-File -FilePath $scriptFile -Encoding ASCII

Write-Host "EXPLORANDO SERVIDOR..." -ForegroundColor Yellow

try {
    $result = ftp -n -s:$scriptFile
    
    Write-Host "ESTRUCTURA DEL SERVIDOR:" -ForegroundColor Green
    $result | ForEach-Object { 
        Write-Host "$_" -ForegroundColor White
    }
    
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}

# Limpiar
if (Test-Path $scriptFile) {
    Remove-Item $scriptFile
}

Write-Host ""
Write-Host "ANALISIS COMPLETADO" -ForegroundColor Green

