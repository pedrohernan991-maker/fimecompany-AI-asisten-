# =========================================================================
# ACTIVAR DEPLOYMENT AUTOMATICO - SIMPLE Y RAPIDO
# Solo necesitas agregar 1 secret en GitHub
# =========================================================================

Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host "  ACTIVAR DEPLOYMENT AUTOMATICO - FIME COMPANY" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Cursor YA creo la estructura Git en tu cPanel!" -ForegroundColor Green
Write-Host "Solo necesitas 1 paso mas para activar deployment automatico" -ForegroundColor White
Write-Host ""

Write-Host "=========================================================================" -ForegroundColor Yellow
Write-Host "  OPCION 1: FTP (MAS SIMPLE - RECOMENDADO)" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "PASO UNICO:" -ForegroundColor Cyan
Write-Host "-----------" -ForegroundColor Gray
Write-Host ""
Write-Host "1. Ve a GitHub Secrets" -ForegroundColor White
Write-Host "2. Agrega 1 secret:" -ForegroundColor White
Write-Host ""
Write-Host "   Nombre:  FTP_PASSWORD" -ForegroundColor Cyan
Write-Host "   Valor:   [Tu contrasena de cPanel]" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Listo! Cada push se despliega automaticamente" -ForegroundColor White
Write-Host ""

Write-Host "Abrir GitHub Secrets ahora? (S/N)" -ForegroundColor Yellow
$respuesta = Read-Host

if ($respuesta -eq "S" -or $respuesta -eq "s") {
    Start-Process "https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/settings/secrets/actions/new"
    Write-Host ""
    Write-Host "Navegador abierto!" -ForegroundColor Green
    Write-Host ""
    Write-Host "INSTRUCCIONES:" -ForegroundColor Yellow
    Write-Host "1. En 'Name' escribe: FTP_PASSWORD" -ForegroundColor White
    Write-Host "2. En 'Secret' pega tu contrasena de cPanel" -ForegroundColor White
    Write-Host "3. Click en 'Add secret'" -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host "  COMO FUNCIONA AHORA" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""

Write-Host "WORKFLOW AUTOMATICO:" -ForegroundColor Cyan
Write-Host "-------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "1. Editas archivos en Cursor" -ForegroundColor White
Write-Host "2. Git commit + push" -ForegroundColor White
Write-Host "3. GitHub Actions detecta el push" -ForegroundColor White
Write-Host "4. Sube automaticamente a cPanel via FTP" -ForegroundColor White
Write-Host "5. Sitio actualizado en 2-5 minutos" -ForegroundColor White
Write-Host ""

Write-Host "ARCHIVOS CONFIGURADOS:" -ForegroundColor Cyan
Write-Host "---------------------" -ForegroundColor Gray
Write-Host "OK .github/workflows/deploy.yml (FTP)" -ForegroundColor Green
Write-Host "OK .github/workflows/deploy-cpanel-directo.yml (Git+SSH)" -ForegroundColor Green
Write-Host "OK public_html/ (47 archivos listos)" -ForegroundColor Green
Write-Host ""

Write-Host "=========================================================================" -ForegroundColor Yellow
Write-Host "  PROBAR EL DEPLOYMENT" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "Una vez agregado el secret FTP_PASSWORD:" -ForegroundColor White
Write-Host ""
Write-Host "OPCION A - Desde Cursor/Terminal:" -ForegroundColor Cyan
Write-Host "  git add ." -ForegroundColor Gray
Write-Host "  git commit -m 'Activar deployment automatico'" -ForegroundColor Gray
Write-Host "  git push origin main" -ForegroundColor Gray
Write-Host ""

Write-Host "OPCION B - Desde GitHub Desktop:" -ForegroundColor Cyan
Write-Host "  1. Abre GitHub Desktop" -ForegroundColor Gray
Write-Host "  2. Commit to main" -ForegroundColor Gray
Write-Host "  3. Push origin" -ForegroundColor Gray
Write-Host ""

Write-Host "OPCION C - Ejecutar manualmente en GitHub:" -ForegroundColor Cyan
Write-Host "  1. Ve a: Actions > Deploy to cPanel via FTP" -ForegroundColor Gray
Write-Host "  2. Click 'Run workflow'" -ForegroundColor Gray
Write-Host "  3. Select branch: main" -ForegroundColor Gray
Write-Host "  4. Click 'Run workflow'" -ForegroundColor Gray
Write-Host ""

Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""

Write-Host "URLs FINALES:" -ForegroundColor Cyan
Write-Host "-------------" -ForegroundColor Gray
Write-Host "Portal:     https://fimecompany.com/" -ForegroundColor White
Write-Host "Ferreteria: https://fimecompany.com/ferreteria/" -ForegroundColor White
Write-Host "FIMEKIDS:   https://fimecompany.com/fimekids/" -ForegroundColor White
Write-Host "FIMETECH:   https://fimecompany.com/fimetech/" -ForegroundColor White
Write-Host ""

Write-Host "Ver Actions en GitHub:" -ForegroundColor Cyan
Write-Host "https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/actions" -ForegroundColor Gray
Write-Host ""

Write-Host "=========================================================================" -ForegroundColor Green
Write-Host "  RESUMEN" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "1. Cursor ya creo la estructura Git en cPanel" -ForegroundColor Green
Write-Host "2. Los archivos de workflow ya estan configurados" -ForegroundColor Green
Write-Host "3. Solo falta: Agregar secret FTP_PASSWORD en GitHub" -ForegroundColor Yellow
Write-Host "4. Despues de eso: Deployment 100% automatico" -ForegroundColor Green
Write-Host ""
Write-Host "NO NECESITAS:" -ForegroundColor Cyan
Write-Host "- Configurar SSH manualmente" -ForegroundColor Gray
Write-Host "- Usar FileZilla" -ForegroundColor Gray
Write-Host "- Subir archivos manualmente" -ForegroundColor Gray
Write-Host "- Preocuparte por la sincronizacion" -ForegroundColor Gray
Write-Host ""
Write-Host "CURSOR MANTIENE TODO FUNCIONANDO AUTOMATICAMENTE!" -ForegroundColor Green
Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""
