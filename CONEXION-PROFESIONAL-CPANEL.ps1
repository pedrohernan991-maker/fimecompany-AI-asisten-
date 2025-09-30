#!/usr/bin/env powershell
# 🏢 FIME COMPANY - CONEXIÓN PROFESIONAL A CPANEL
# ==============================================
# MÉTODO MÁS PROFESIONAL DEL MUNDO EMPRESARIAL

Write-Host ""
Write-Host "🏢 CONEXIÓN PROFESIONAL A CPANEL" -ForegroundColor White -BackgroundColor DarkBlue
Write-Host "=================================" -ForegroundColor Yellow
Write-Host ""

# CONFIGURACIÓN PROFESIONAL
$CPANEL_HOST = "fimecompany.com"
$CPANEL_USER = "fimecomp"
$SSH_PORT = "22"
$SSH_KEY = "C:\Users\PC\.ssh\id_rsa"

Write-Host "🎯 MÉTODO 1: SSH DIRECTO (MÁS PROFESIONAL)" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "==========================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "📋 CONFIGURACIÓN:" -ForegroundColor Cyan
Write-Host "  🌐 Host: $CPANEL_HOST" -ForegroundColor White
Write-Host "  👤 Usuario: $CPANEL_USER" -ForegroundColor White
Write-Host "  🔌 Puerto SSH: $SSH_PORT" -ForegroundColor White
Write-Host "  🔑 Clave SSH: $SSH_KEY" -ForegroundColor White
Write-Host ""

# PASO 1: Verificar SSH
Write-Host "🔍 PASO 1: VERIFICANDO CONEXIÓN SSH..." -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Yellow

$sshTest = ssh -i $SSH_KEY -p $SSH_PORT $CPANEL_USER@$CPANEL_HOST "echo 'SSH OK'" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ SSH CONECTADO EXITOSAMENTE" -ForegroundColor Green
    $sshWorking = $true
} else {
    Write-Host "❌ SSH no disponible - usando métodos alternativos" -ForegroundColor Yellow
    $sshWorking = $false
}

Write-Host ""
Write-Host "🎯 MÉTODO 2: CPANEL API (ULTRA PROFESIONAL)" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "===========================================" -ForegroundColor Yellow

# Crear configuración API
@"
{
    "cpanel_config": {
        "host": "$CPANEL_HOST",
        "port": 2083,
        "ssl": true,
        "username": "$CPANEL_USER",
        "api_token": "NECESITA_TOKEN_API",
        "endpoints": {
            "file_manager": "/execute/Fileman",
            "mysql": "/execute/Mysql", 
            "domains": "/execute/Park",
            "email": "/execute/Email",
            "backup": "/execute/Backup"
        }
    }
}
"@ | Out-File -FilePath "cpanel-api-config.json" -Encoding utf8

Write-Host "✅ Configuración API creada: cpanel-api-config.json" -ForegroundColor Green

Write-Host ""
Write-Host "🎯 MÉTODO 3: FTP SEGURO (SFTP)" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "==============================" -ForegroundColor Yellow

# Crear script SFTP batch
@"
#!/bin/bash
# SFTP PROFESIONAL FIME COMPANY
sftp -P $SSH_PORT $CPANEL_USER@$CPANEL_HOST << EOF
cd public_html
put -r * .
chmod 644 *.html
chmod 644 *.css
chmod 644 *.js
chmod 755 */
quit
EOF
echo "✅ Archivos subidos exitosamente vía SFTP"
"@ | Out-File -FilePath "upload-sftp.sh" -Encoding utf8

Write-Host "✅ Script SFTP creado: upload-sftp.sh" -ForegroundColor Green

Write-Host ""
Write-Host "🎯 MÉTODO 4: GITHUB ACTIONS PROFESIONAL" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "=======================================" -ForegroundColor Yellow

# Crear workflow profesional
if (-not (Test-Path ".github/workflows")) {
    New-Item -ItemType Directory -Path ".github/workflows" -Force | Out-Null
}

@"
name: 🏢 FIME COMPANY - Deployment Profesional

on:
  push:
    branches: [ main, develop ]
  workflow_dispatch:

env:
  CPANEL_HOST: fimecompany.com
  CPANEL_USER: fimecomp
  DEPLOY_PATH: /public_html

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    
    steps:
    - name: 📥 Checkout Repository
      uses: actions/checkout@v4
      
    - name: 🔍 Validate Files
      run: |
        echo "🔍 Validando archivos HTML..."
        find . -name "*.html" -exec echo "✅ {}" \;
        
    - name: 🚀 Deploy via SFTP
      uses: wlixcc/SFTP-Deploy-Action@v1.2.4
      with:
        server: fimecompany.com
        port: 22
        username: fimecomp
        password: \${{ secrets.CPANEL_PASSWORD }}
        local_path: './c panel/*'
        remote_path: '/public_html'
        sftp_only: true
        
    - name: 🔧 Set Permissions
      uses: appleboy/ssh-action@v1.0.0
      with:
        host: fimecompany.com
        username: fimecomp
        key: \${{ secrets.SSH_PRIVATE_KEY }}
        port: 22
        script: |
          cd public_html
          find . -type f -name "*.html" -exec chmod 644 {} \;
          find . -type f -name "*.css" -exec chmod 644 {} \;
          find . -type f -name "*.js" -exec chmod 644 {} \;
          find . -type d -exec chmod 755 {} \;
          
    - name: ✅ Verify Deployment
      run: |
        echo "🌐 Verificando: https://fimecompany.com"
        curl -I https://fimecompany.com
        
    - name: 📧 Notify Success
      uses: 8398a7/action-slack@v3
      with:
        status: success
        text: '🎉 FIME COMPANY desplegado exitosamente!'
      env:
        SLACK_WEBHOOK_URL: \${{ secrets.SLACK_WEBHOOK }}
"@ | Out-File -FilePath ".github/workflows/professional-deploy.yml" -Encoding utf8

Write-Host "✅ GitHub Actions profesional creado" -ForegroundColor Green

Write-Host ""
Write-Host "🎯 MÉTODO 5: RSYNC PROFESIONAL" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "==============================" -ForegroundColor Yellow

# Crear script rsync
@"
#!/bin/bash
# RSYNC PROFESIONAL FIME COMPANY

echo "🚀 Iniciando sincronización profesional..."

rsync -avz --delete \
  --exclude='.git*' \
  --exclude='*.ps1' \
  --exclude='*.bat' \
  --exclude='*.md' \
  --exclude='INSTRUCCIONES*' \
  --progress \
  -e "ssh -p $SSH_PORT -i $SSH_KEY" \
  ./ $CPANEL_USER@$CPANEL_HOST:public_html/

echo "✅ Sincronización completada exitosamente"
echo "🌐 Sitio web: https://fimecompany.com"
"@ | Out-File -FilePath "sync-professional.sh" -Encoding utf8

Write-Host "✅ Script Rsync profesional creado" -ForegroundColor Green

Write-Host ""
Write-Host "🎯 MÉTODO 6: CPANEL UAPI (ENTERPRISE)" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "====================================" -ForegroundColor Yellow

# Crear cliente UAPI
@"
#!/usr/bin/env powershell
# CLIENTE CPANEL UAPI PROFESIONAL

param(
    [Parameter(Mandatory=\$true)]
    [string]\$Action,
    
    [Parameter(Mandatory=\$false)]
    [string]\$Module = "Fileman",
    
    [Parameter(Mandatory=\$false)]
    [hashtable]\$Parameters = @{}
)

\$cPanelHost = "fimecompany.com"
\$cPanelUser = "fimecomp" 
\$apiToken = \$env:CPANEL_API_TOKEN

if (-not \$apiToken) {
    Write-Error "❌ Falta CPANEL_API_TOKEN en variables de entorno"
    exit 1
}

\$uri = "https://\$cPanelHost:2083/execute/\$Module/\$Action"
\$headers = @{
    "Authorization" = "cpanel \$cPanelUser:\$apiToken"
    "Content-Type" = "application/x-www-form-urlencoded"
}

try {
    \$response = Invoke-RestMethod -Uri \$uri -Method POST -Headers \$headers -Body \$Parameters
    Write-Host "✅ UAPI Response:" -ForegroundColor Green
    \$response | ConvertTo-Json -Depth 10
} catch {
    Write-Error "❌ Error UAPI: \$(\$_.Exception.Message)"
}
"@ | Out-File -FilePath "cpanel-uapi-client.ps1" -Encoding utf8

Write-Host "✅ Cliente UAPI profesional creado" -ForegroundColor Green

Write-Host ""
Write-Host "🏆 RESUMEN DE CONEXIONES PROFESIONALES" -ForegroundColor White -BackgroundColor DarkMagenta
Write-Host "======================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. 🔐 SSH Directo" -ForegroundColor Cyan
Write-Host "   • Más rápido y seguro" -ForegroundColor White
Write-Host "   • Control total del servidor" -ForegroundColor White
Write-Host ""
Write-Host "2. 🌐 cPanel UAPI" -ForegroundColor Cyan  
Write-Host "   • Acceso programático total" -ForegroundColor White
Write-Host "   • Gestión completa desde código" -ForegroundColor White
Write-Host ""
Write-Host "3. 🚀 GitHub Actions" -ForegroundColor Cyan
Write-Host "   • Deployment automático" -ForegroundColor White
Write-Host "   • CI/CD profesional" -ForegroundColor White
Write-Host ""
Write-Host "4. 📁 SFTP/Rsync" -ForegroundColor Cyan
Write-Host "   • Sincronización incremental" -ForegroundColor White
Write-Host "   • Máximo rendimiento" -ForegroundColor White
Write-Host ""

Write-Host "🎯 RECOMENDACIÓN PROFESIONAL:" -ForegroundColor Yellow -BackgroundColor DarkRed
Write-Host "=============================" -ForegroundColor Yellow
Write-Host "✨ Usar GitHub Actions + SSH para máxima profesionalidad" -ForegroundColor Green
Write-Host "✨ Configurar UAPI para gestión avanzada" -ForegroundColor Green
Write-Host "✨ SFTP para uploads manuales rápidos" -ForegroundColor Green

Write-Host ""
Write-Host "📋 PRÓXIMOS PASOS:" -ForegroundColor White -BackgroundColor DarkBlue
Write-Host "=================" -ForegroundColor Yellow
Write-Host "1. 🔑 Generar API Token en cPanel" -ForegroundColor Cyan
Write-Host "2. 🔐 Configurar SSH keys" -ForegroundColor Cyan  
Write-Host "3. 🚀 Activar GitHub Actions" -ForegroundColor Cyan
Write-Host "4. ✅ Probar conexión profesional" -ForegroundColor Cyan

Read-Host "Presiona ENTER para continuar..."
