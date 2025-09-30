# Script simple para subir archivos de ferreteria a cPanel
Write-Host "Subiendo archivos de ferreteria a cPanel..." -ForegroundColor Cyan

# Archivos a subir
$archivos = @(
  "ferreteria\index.html",
  "categorias.json"
)

Write-Host "Archivos a subir:" -ForegroundColor Yellow
foreach ($archivo in $archivos) {
  if (Test-Path $archivo) {
    Write-Host "OK $archivo" -ForegroundColor Green
  }
  else {
    Write-Host "ERROR $archivo (no encontrado)" -ForegroundColor Red
  }
}

Write-Host ""
Write-Host "Para subir manualmente:" -ForegroundColor Yellow
Write-Host "1. Ve a tu cPanel" -ForegroundColor White
Write-Host "2. Abre File Manager" -ForegroundColor White
Write-Host "3. Navega a public_html" -ForegroundColor White
Write-Host "4. Crea carpeta 'ferreteria' si no existe" -ForegroundColor White
Write-Host "5. Sube ferreteria\index.html a public_html\ferreteria\" -ForegroundColor White
Write-Host "6. Sube categorias.json a public_html\" -ForegroundColor White
Write-Host ""
Write-Host "URLs finales:" -ForegroundColor Yellow
Write-Host "- https://fimecompany.com/ferreteria/" -ForegroundColor Cyan
Write-Host "- https://fimecompany.com/categorias.json" -ForegroundColor Cyan
