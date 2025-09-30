# SINCRONIZACION SIMPLE A PUBLIC_HTML
Write-Host "Iniciando sincronizacion..." -ForegroundColor Green

# 1. Sincronizar index.html principal
Write-Host "1. Sincronizando index.html principal..."
Copy-Item "index.html" "public_html\index.html" -Force
Write-Host "OK" -ForegroundColor Green

# 2. Sincronizar styles.css
Write-Host "2. Sincronizando styles.css..."
if (Test-Path "styles.css") {
    Copy-Item "styles.css" "public_html\styles.css" -Force
    Write-Host "OK" -ForegroundColor Green
}

# 3. Sincronizar categorias.json
Write-Host "3. Sincronizando categorias.json..."
if (Test-Path "categorias.json") {
    Copy-Item "categorias.json" "public_html\categorias.json" -Force
    Write-Host "OK" -ForegroundColor Green
}

# 4. Sincronizar ferreteria
Write-Host "4. Sincronizando ferreteria..."
if (Test-Path "ferreteria") {
    Copy-Item "ferreteria\*" "public_html\ferreteria\" -Force -Recurse
    Write-Host "OK" -ForegroundColor Green
}

# 5. Sincronizar fimekids
Write-Host "5. Sincronizando fimekids..."
if (Test-Path "fimekids") {
    Copy-Item "fimekids\*" "public_html\fimekids\" -Force -Recurse
    Write-Host "OK" -ForegroundColor Green
}

# 6. Sincronizar fimetech
Write-Host "6. Sincronizando fimetech..."
if (Test-Path "fimetech") {
    Copy-Item "fimetech\*" "public_html\fimetech\" -Force -Recurse
    Write-Host "OK" -ForegroundColor Green
}

# 7. Sincronizar industria
Write-Host "7. Sincronizando industria..."
if (Test-Path "industria") {
    Copy-Item "industria\*" "public_html\industria\" -Force -Recurse
    Write-Host "OK" -ForegroundColor Green
}

Write-Host ""
Write-Host "SINCRONIZACION COMPLETADA" -ForegroundColor Yellow
Write-Host "Archivos listos en: public_html" -ForegroundColor Cyan

# Contar archivos
$archivos = (Get-ChildItem "public_html" -Recurse -File).Count
Write-Host "Total archivos: $archivos" -ForegroundColor White
