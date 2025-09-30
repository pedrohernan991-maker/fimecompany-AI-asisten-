# =========================================================================
# SUBIDA AUTOMATICA A CPANEL - FIME COMPANY
# Script profesional para deployment directo
# =========================================================================

Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host "  SUBIDA AUTOMATICA A CPANEL - FIME COMPANY" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Cyan
Write-Host ""

# Configuración
$LOCAL_PATH = "$PWD\public_html"
$CPANEL_HOST = "fimecompany.com"
$CPANEL_USER = "fimecomp"
$REMOTE_PATH = "/public_html"

Write-Host "[PASO 1] Verificando archivos locales..." -ForegroundColor Green
if (Test-Path $LOCAL_PATH) {
    $archivos = (Get-ChildItem $LOCAL_PATH -Recurse -File).Count
    Write-Host "OK - $archivos archivos encontrados en public_html" -ForegroundColor Green
} else {
    Write-Host "ERROR - No se encuentra la carpeta public_html" -ForegroundColor Red
    exit 1
}
Write-Host ""

Write-Host "[PASO 2] Opciones de subida disponibles:" -ForegroundColor Green
Write-Host ""
Write-Host "1. FileZilla (Recomendado - Interface grafica)" -ForegroundColor Cyan
Write-Host "2. WinSCP (Windows - Interface grafica)" -ForegroundColor Cyan
Write-Host "3. cPanel File Manager (Web - Manual)" -ForegroundColor Cyan
Write-Host "4. GitHub con deployment automatico (Avanzado)" -ForegroundColor Cyan
Write-Host ""

$opcion = Read-Host "Selecciona una opcion (1-4)"

switch ($opcion) {
    "1" {
        Write-Host ""
        Write-Host "=== OPCION 1: FILEZILLA ===" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "PASOS PARA USAR FILEZILLA:" -ForegroundColor Cyan
        Write-Host "1. Abre FileZilla" -ForegroundColor White
        Write-Host "2. Configuracion:" -ForegroundColor White
        Write-Host "   - Host: ftp.fimecompany.com (o fimecompany.com)" -ForegroundColor Gray
        Write-Host "   - Usuario: fimecomp" -ForegroundColor Gray
        Write-Host "   - Puerto: 21 (FTP) o 22 (SFTP)" -ForegroundColor Gray
        Write-Host "   - Contrasena: [Tu contrasena de cPanel]" -ForegroundColor Gray
        Write-Host ""
        Write-Host "3. Navega en servidor a: /public_html" -ForegroundColor White
        Write-Host "4. Sube todos los archivos desde:" -ForegroundColor White
        Write-Host "   $LOCAL_PATH" -ForegroundColor Cyan
        Write-Host ""
        
        $abrir = Read-Host "Deseas abrir la carpeta local? (S/N)"
        if ($abrir -eq "S" -or $abrir -eq "s") {
            explorer $LOCAL_PATH
            Write-Host "Carpeta abierta. Arrastra los archivos a FileZilla" -ForegroundColor Green
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "=== OPCION 2: WINSCP ===" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "PASOS PARA USAR WINSCP:" -ForegroundColor Cyan
        Write-Host "1. Abre WinSCP" -ForegroundColor White
        Write-Host "2. Nueva conexion:" -ForegroundColor White
        Write-Host "   - Protocolo: FTP o SFTP" -ForegroundColor Gray
        Write-Host "   - Host: fimecompany.com" -ForegroundColor Gray
        Write-Host "   - Usuario: fimecomp" -ForegroundColor Gray
        Write-Host "   - Puerto: 21 (FTP) o 22 (SFTP)" -ForegroundColor Gray
        Write-Host ""
        Write-Host "3. Conecta y navega a: /public_html" -ForegroundColor White
        Write-Host "4. Sincroniza la carpeta local:" -ForegroundColor White
        Write-Host "   $LOCAL_PATH" -ForegroundColor Cyan
        Write-Host ""
        
        explorer $LOCAL_PATH
        Write-Host "Carpeta abierta" -ForegroundColor Green
    }
    
    "3" {
        Write-Host ""
        Write-Host "=== OPCION 3: CPANEL FILE MANAGER ===" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "PASOS MANUAL EN CPANEL:" -ForegroundColor Cyan
        Write-Host "1. Ve a: https://fimecompany.com:2083" -ForegroundColor White
        Write-Host "2. Login con tus credenciales de cPanel" -ForegroundColor White
        Write-Host "3. Busca 'File Manager' y abrelo" -ForegroundColor White
        Write-Host "4. Navega a: public_html" -ForegroundColor White
        Write-Host "5. Haz clic en 'Upload'" -ForegroundColor White
        Write-Host "6. Selecciona TODOS los archivos desde:" -ForegroundColor White
        Write-Host "   $LOCAL_PATH" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "ESTRUCTURA A SUBIR:" -ForegroundColor Yellow
        Write-Host "- index.html" -ForegroundColor Gray
        Write-Host "- styles.css" -ForegroundColor Gray
        Write-Host "- categorias.json" -ForegroundColor Gray
        Write-Host "- ferreteria/ (carpeta completa)" -ForegroundColor Gray
        Write-Host "- fimekids/ (carpeta completa)" -ForegroundColor Gray
        Write-Host "- fimetech/ (carpeta completa)" -ForegroundColor Gray
        Write-Host "- industria/ (carpeta completa)" -ForegroundColor Gray
        Write-Host ""
        
        $abrir = Read-Host "Abrir cPanel en navegador? (S/N)"
        if ($abrir -eq "S" -or $abrir -eq "s") {
            Start-Process "https://fimecompany.com:2083"
        }
        
        explorer $LOCAL_PATH
        Write-Host "Carpeta local abierta" -ForegroundColor Green
    }
    
    "4" {
        Write-Host ""
        Write-Host "=== OPCION 4: GITHUB DEPLOYMENT ===" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "CONFIGURACION DE DEPLOYMENT AUTOMATICO:" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Esta opcion requiere configurar GitHub Actions" -ForegroundColor White
        Write-Host "para que cada push se despliegue automaticamente a cPanel" -ForegroundColor White
        Write-Host ""
        Write-Host "PASOS:" -ForegroundColor Cyan
        Write-Host "1. Sube el codigo a GitHub" -ForegroundColor White
        Write-Host "2. Configura GitHub Actions con FTP Deploy" -ForegroundColor White
        Write-Host "3. Agrega secrets en GitHub:" -ForegroundColor White
        Write-Host "   - FTP_SERVER: ftp.fimecompany.com" -ForegroundColor Gray
        Write-Host "   - FTP_USERNAME: fimecomp" -ForegroundColor Gray
        Write-Host "   - FTP_PASSWORD: [tu contrasena]" -ForegroundColor Gray
        Write-Host ""
        
        Write-Host "Deseas ver el archivo de configuracion de GitHub Actions? (S/N)" -ForegroundColor Yellow
        $ver = Read-Host
        if ($ver -eq "S" -or $ver -eq "s") {
            Write-Host ""
            Write-Host "Crea este archivo: .github/workflows/deploy.yml" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Contenido del archivo guardado en: github-deploy-config.txt" -ForegroundColor Gray
            
            $deployConfig = @"
name: Deploy to cPanel

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: FTP Deploy
      uses: SamKirkland/FTP-Deploy-Action@4.3.0
      with:
        server: ftp.fimecompany.com
        username: fimecomp
        password: secrets.FTP_PASSWORD
        local-dir: ./public_html/
        server-dir: /public_html/
"@
            $deployConfig | Out-File -FilePath "github-deploy-config.txt" -Encoding UTF8
            Write-Host "Archivo creado: github-deploy-config.txt" -ForegroundColor Green
        }
    }
    
    default {
        Write-Host "Opcion no valida" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host "  INFORMACION DE CONEXION" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Host FTP:     ftp.fimecompany.com" -ForegroundColor Cyan
Write-Host "Host SFTP:    fimecompany.com" -ForegroundColor Cyan
Write-Host "Usuario:      fimecomp" -ForegroundColor Cyan
Write-Host "Puerto FTP:   21" -ForegroundColor Cyan
Write-Host "Puerto SFTP:  22" -ForegroundColor Cyan
Write-Host "Carpeta:      /public_html" -ForegroundColor Cyan
Write-Host ""
Write-Host "Archivos:     47 archivos listos" -ForegroundColor Green
Write-Host "Ubicacion:    $LOCAL_PATH" -ForegroundColor Green
Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host "  URLs FINALES ESPERADAS" -ForegroundColor Yellow
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Portal:       https://fimecompany.com/" -ForegroundColor White
Write-Host "Ferreteria:   https://fimecompany.com/ferreteria/" -ForegroundColor White
Write-Host "FIMEKIDS:     https://fimecompany.com/fimekids/" -ForegroundColor White
Write-Host "FIMETECH:     https://fimecompany.com/fimetech/" -ForegroundColor White
Write-Host "Industria:    https://fimecompany.com/industria/" -ForegroundColor White
Write-Host "Categorias:   https://fimecompany.com/categorias.json" -ForegroundColor White
Write-Host ""
Write-Host "=========================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "LISTO PARA SUBIR A PRODUCCION!" -ForegroundColor Green
Write-Host ""
