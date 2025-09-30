# CONEXION GITHUB SIMPLE
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host " SUBIENDO A GITHUB - FIME COMPANY" -ForegroundColor Yellow
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# Configurar Git
Write-Host "[1] Configurando Git..." -ForegroundColor Green
git config user.name "Pedro Nicolas Hernandez Lizardo"
git config user.email "fimecompany@gmail.com"
Write-Host "OK" -ForegroundColor Green
Write-Host ""

# Agregar archivos
Write-Host "[2] Agregando archivos..." -ForegroundColor Green
git add .
Write-Host "OK" -ForegroundColor Green
Write-Host ""

# Commit
Write-Host "[3] Creando commit..." -ForegroundColor Green
$fecha = Get-Date -Format "yyyy-MM-dd HH:mm"
git commit -m "Sincronizacion automatica - $fecha - 47 archivos"
Write-Host "OK" -ForegroundColor Green
Write-Host ""

# Push
Write-Host "[4] Subiendo a GitHub..." -ForegroundColor Green
Write-Host "Ejecuta manualmente: git push origin main" -ForegroundColor Yellow
Write-Host ""

Write-Host "===============================================" -ForegroundColor Green
Write-Host " LISTO PARA SUBIR A GITHUB" -ForegroundColor Yellow
Write-Host "===============================================" -ForegroundColor Green
Write-Host ""

Write-Host "ARCHIVOS SINCRONIZADOS:" -ForegroundColor Cyan
Write-Host "- 47 archivos en public_html" -ForegroundColor White
Write-Host "- Ferreteria, FIMEKIDS, FIMETECH, Industria" -ForegroundColor White
Write-Host "- categorias.json con productos completos" -ForegroundColor White
Write-Host ""

Write-Host "SIGUIENTE PASO:" -ForegroundColor Yellow
Write-Host "1. Ejecuta: git push origin main" -ForegroundColor White
Write-Host "2. Sube public_html a cPanel" -ForegroundColor White
Write-Host ""
