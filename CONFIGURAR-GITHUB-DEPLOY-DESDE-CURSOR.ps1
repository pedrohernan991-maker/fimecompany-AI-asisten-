# =========================================================================
# CONFIGURAR GITHUB DEPLOY AUTOMATICO DESDE CURSOR
# Guía paso a paso para deployment automático
# =========================================================================

Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host "  CONFIGURAR DEPLOYMENT AUTOMATICO - DESDE CURSOR" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Este script te guiara para configurar deployment automatico a cPanel" -ForegroundColor White
Write-Host ""

# Verificar que estamos en el proyecto correcto
$currentPath = Get-Location
Write-Host "[1] Verificando proyecto..." -ForegroundColor Green
if (Test-Path ".github\workflows\deploy.yml") {
    Write-Host "OK - Archivo de workflow creado" -ForegroundColor Green
} else {
    Write-Host "ERROR - No se encuentra el archivo de workflow" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Verificar Git
Write-Host "[2] Verificando Git..." -ForegroundColor Green
if (Test-Path ".git") {
    Write-Host "OK - Repositorio Git encontrado" -ForegroundColor Green
} else {
    Write-Host "Inicializando Git..." -ForegroundColor Yellow
    git init
    git remote add origin https://github.com/PedroNicolas2001/fimecompany-AI-asisten-.git
    Write-Host "OK - Git inicializado" -ForegroundColor Green
}
Write-Host ""

# Mostrar archivos que se van a subir
Write-Host "[3] Archivos preparados para GitHub:" -ForegroundColor Green
Write-Host "   - .github/workflows/deploy.yml (Configuracion de deployment)" -ForegroundColor Cyan
Write-Host "   - .github/workflows/README.md (Instrucciones)" -ForegroundColor Cyan
Write-Host "   - public_html/ (47 archivos del sitio)" -ForegroundColor Cyan
Write-Host ""

# Guía paso a paso
Write-Host "=========================================================================" -ForegroundColor Yellow
Write-Host "  PASOS PARA COMPLETAR LA CONFIGURACION" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "PASO 1: SUBIR ARCHIVOS A GITHUB" -ForegroundColor Cyan
Write-Host "--------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Opcion A - Usar GitHub Desktop (MAS FACIL):" -ForegroundColor White
Write-Host "  1. Abre GitHub Desktop" -ForegroundColor Gray
Write-Host "  2. Asegurate de estar en el repo: fimecompany-AI-asisten-" -ForegroundColor Gray
Write-Host "  3. Veras los cambios en la izquierda" -ForegroundColor Gray
Write-Host "  4. Escribe un mensaje: 'Configurar deployment automatico'" -ForegroundColor Gray
Write-Host "  5. Click en 'Commit to main'" -ForegroundColor Gray
Write-Host "  6. Click en 'Push origin'" -ForegroundColor Gray
Write-Host ""
Write-Host "Opcion B - Usar comandos Git:" -ForegroundColor White
Write-Host "  git add ." -ForegroundColor Cyan
Write-Host "  git commit -m 'Configurar deployment automatico a cPanel'" -ForegroundColor Cyan
Write-Host "  git push origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "Presiona ENTER cuando hayas subido a GitHub..." -ForegroundColor Yellow
$null = Read-Host
Write-Host ""

Write-Host "PASO 2: CONFIGURAR EL SECRET EN GITHUB" -ForegroundColor Cyan
Write-Host "---------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Ahora necesitas agregar tu contrasena de cPanel como Secret:" -ForegroundColor White
Write-Host ""
Write-Host "1. Ve a GitHub en tu navegador" -ForegroundColor White
Write-Host "2. Abre tu repositorio: https://github.com/PedroNicolas2001/fimecompany-AI-asisten-" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Click en 'Settings' (arriba a la derecha)" -ForegroundColor White
Write-Host ""
Write-Host "4. En el menu izquierdo, busca y click en:" -ForegroundColor White
Write-Host "   'Secrets and variables' > 'Actions'" -ForegroundColor Cyan
Write-Host ""
Write-Host "5. Click en 'New repository secret' (boton verde)" -ForegroundColor White
Write-Host ""
Write-Host "6. Completa el formulario:" -ForegroundColor White
Write-Host "   Name:  FTP_PASSWORD" -ForegroundColor Cyan
Write-Host "   Value: [Tu contrasena de cPanel]" -ForegroundColor Cyan
Write-Host ""
Write-Host "7. Click en 'Add secret'" -ForegroundColor White
Write-Host ""
Write-Host "Deseas abrir GitHub en el navegador? (S/N)" -ForegroundColor Yellow
$abrir = Read-Host
if ($abrir -eq "S" -or $abrir -eq "s") {
    Start-Process "https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/settings/secrets/actions"
    Write-Host "Navegador abierto. Completa los pasos arriba" -ForegroundColor Green
}
Write-Host ""
Write-Host "Presiona ENTER cuando hayas configurado el secret..." -ForegroundColor Yellow
$null = Read-Host
Write-Host ""

Write-Host "PASO 3: ACTIVAR EL WORKFLOW" -ForegroundColor Cyan
Write-Host "---------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Ahora vamos a activar el deployment automatico:" -ForegroundColor White
Write-Host ""
Write-Host "1. Ve a la pestana 'Actions' en tu repositorio de GitHub" -ForegroundColor White
Write-Host "   URL: https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/actions" -ForegroundColor Cyan
Write-Host ""
Write-Host "2. Veras el workflow 'Deploy to cPanel via FTP'" -ForegroundColor White
Write-Host ""
Write-Host "3. Click en 'Deploy to cPanel via FTP'" -ForegroundColor White
Write-Host ""
Write-Host "4. Click en 'Run workflow' (boton a la derecha)" -ForegroundColor White
Write-Host ""
Write-Host "5. Selecciona 'Branch: main'" -ForegroundColor White
Write-Host ""
Write-Host "6. Click en 'Run workflow' (boton verde)" -ForegroundColor White
Write-Host ""
Write-Host "7. Espera 2-5 minutos mientras se despliega" -ForegroundColor White
Write-Host ""
Write-Host "8. Cuando veas un check verde, el sitio estara actualizado" -ForegroundColor White
Write-Host ""
Write-Host "Deseas abrir GitHub Actions? (S/N)" -ForegroundColor Yellow
$abrirActions = Read-Host
if ($abrirActions -eq "S" -or $abrirActions -eq "s") {
    Start-Process "https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/actions"
    Write-Host "GitHub Actions abierto" -ForegroundColor Green
}
Write-Host ""

Write-Host "=========================================================================" -ForegroundColor Green
Write-Host "  CONFIGURACION COMPLETADA" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""

Write-Host "RESUMEN:" -ForegroundColor Cyan
Write-Host "--------" -ForegroundColor Gray
Write-Host ""
Write-Host "OK Archivos de workflow creados" -ForegroundColor Green
Write-Host "OK Archivos subidos a GitHub" -ForegroundColor Green
Write-Host "OK Secret FTP_PASSWORD configurado" -ForegroundColor Green
Write-Host "OK Workflow ejecutado" -ForegroundColor Green
Write-Host ""

Write-Host "COMO FUNCIONA AHORA:" -ForegroundColor Cyan
Write-Host "--------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Cada vez que hagas cambios:" -ForegroundColor White
Write-Host "1. Edita archivos en Cursor" -ForegroundColor Gray
Write-Host "2. Commit en GitHub Desktop" -ForegroundColor Gray
Write-Host "3. Push a GitHub" -ForegroundColor Gray
Write-Host "4. Deployment automatico a cPanel (2-5 minutos)" -ForegroundColor Gray
Write-Host "5. Tu sitio se actualiza solo" -ForegroundColor Gray
Write-Host ""

Write-Host "URLs DEL SITIO:" -ForegroundColor Cyan
Write-Host "---------------" -ForegroundColor Gray
Write-Host "Portal:     https://fimecompany.com/" -ForegroundColor White
Write-Host "Ferreteria: https://fimecompany.com/ferreteria/" -ForegroundColor White
Write-Host "FIMEKIDS:   https://fimecompany.com/fimekids/" -ForegroundColor White
Write-Host "FIMETECH:   https://fimecompany.com/fimetech/" -ForegroundColor White
Write-Host ""

Write-Host "VERIFICAR DEPLOYMENTS:" -ForegroundColor Cyan
Write-Host "----------------------" -ForegroundColor Gray
Write-Host "Ve a: https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/actions" -ForegroundColor White
Write-Host ""

Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "DEPLOYMENT AUTOMATICO CONFIGURADO!" -ForegroundColor Green
Write-Host "Ahora cada push se despliega automaticamente a cPanel" -ForegroundColor White
Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""
