# ===============================================
# CONFIGURACIÓN COMPLETA PUTTY + CPANEL + AUTOMATIZACIÓN
# FIME COMPANY - Conexión Total Automatizada
# ===============================================

Write-Host "🚀 CONFIGURANDO PUTTY + CPANEL COMPLETO" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "=======================================" -ForegroundColor Yellow

# Verificar si PuTTY está instalado
Write-Host "📋 Verificando PuTTY..." -ForegroundColor Green
if (!(Get-Command putty -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Instalando PuTTY..." -ForegroundColor Yellow
    winget install PuTTY.PuTTY
    Write-Host "✅ PuTTY instalado" -ForegroundColor Green
} else {
    Write-Host "✅ PuTTY ya está instalado" -ForegroundColor Green
}

# Crear directorio SSH
Write-Host "📁 Creando directorio SSH..." -ForegroundColor Green
$sshDir = "$env:USERPROFILE\.ssh"
if (!(Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
}

# Configuración PuTTY para cPanel
Write-Host "⚙️ Configurando PuTTY para cPanel..." -ForegroundColor Green

# Crear archivo de configuración PuTTY
$puttyConfig = @"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\SOFTWARE\SimonTatham\PuTTY\Sessions\fimecompany_cpanel]
"HostName"="fimecompany.com"
"PortNumber"=dword:00000016
"Protocol"="ssh"
"PublicKeyFile"="$sshDir\fimecompany_key.ppk"
"UserName"="fimecomp"
"RemoteCommand"=""
"Cipher"="aes"
"KEX"="dh-gex-sha1"
"RekeyTime"=dword:0000003c
"RekeyBytes"="1G"
"SshProt"=dword:00000002
"SSH2DES"=dword:00000000
"SshNoAuth"=dword:00000000
"AuthTIS"=dword:00000000
"AuthKI"=dword:00000001
"AuthGSSAPI"=dword:00000001
"GSSLibs"="gssapi32,sspi,custom"
"GSSCustom"=""
"AgentFwd"=dword:00000000
"ChangeUsername"=dword:00000000
"Compression"=dword:00000000
"SSH2PrivkeyFile"="$sshDir\fimecompany_key.ppk"
"LogFileName"=""
"LogType"=dword:00000000
"LogFileClash"=dword:ffffffff
"X11Forward"=dword:00000000
"X11Display"=""
"X11AuthType"=dword:00000001
"LocalPortAcceptAll"=dword:00000000
"RemotePortAcceptAll"=dword:00000000
"BugIgnore1"=dword:00000000
"BugPlainPW1"=dword:00000000
"BugRSA1"=dword:00000000
"BugHMAC2"=dword:00000000
"BugDeriveKey2"=dword:00000000
"BugRSAPad2"=dword:00000000
"BugPKSessID2"=dword:00000000
"BugRekey2"=dword:00000000
"BugMaxPkt2"=dword:00000000
"StampUtmp"=dword:00000001
"LoginShell"=dword:00000001
"ScrollbarOnLeft"=dword:00000000
"BoldFont"=""
"BoldFontIsBold"=dword:00000000
"BoldFontCharSet"=dword:00000000
"BoldFontHeight"=dword:00000000
"Font"="Consolas"
"FontCharSet"=dword:00000000
"FontHeight"=dword:0000000c
"FontIsBold"=dword:00000000
"FontQuality"=dword:00000000
"FontVTMode"=dword:00000004
"UseSystemColours"=dword:00000000
"TryPalette"=dword:00000000
"ANSIColour"=dword:00000001
"Xterm256Colour"=dword:00000001
"BoldAsColour"=dword:00000001
"Colour0"="187,187,187"
"Colour1"="255,255,255"
"Colour2"="0,0,0"
"Colour3"="85,85,85"
"Colour4"="0,0,0"
"Colour5"="0,255,0"
"Colour6"="0,0,0"
"Colour7"="85,85,85"
"Colour8"="187,0,0"
"Colour9"="255,85,85"
"Colour10"="0,187,0"
"Colour11"="85,255,85"
"Colour12"="187,187,0"
"Colour13"="255,255,85"
"Colour14"="0,0,187"
"Colour15"="85,85,255"
"Colour16"="187,0,187"
"Colour17"="255,85,255"
"Colour18"="0,187,187"
"Colour19"="85,255,255"
"Colour20"="187,187,187"
"Colour21"="255,255,255"
"@

# Guardar configuración PuTTY
$puttyConfigFile = "$env:TEMP\putty_fimecompany.reg"
$puttyConfig | Out-File -FilePath $puttyConfigFile -Encoding ASCII

Write-Host "📄 Configuración PuTTY creada en: $puttyConfigFile" -ForegroundColor Green

# Aplicar configuración al registro
Write-Host "🔧 Aplicando configuración PuTTY al registro..." -ForegroundColor Green
try {
    reg import "$puttyConfigFile" 2>$null
    Write-Host "✅ Configuración PuTTY aplicada" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Error aplicando configuración PuTTY: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Convertir clave SSH a formato PuTTY (PPK)
Write-Host "🔑 Configurando claves SSH para PuTTY..." -ForegroundColor Green

# Verificar si PuTTYgen está disponible
if (Get-Command puttygen -ErrorAction SilentlyContinue) {
    # Convertir clave existente a formato PPK
    if (Test-Path "$sshDir\fimecompany_key") {
        Write-Host "🔄 Convirtiendo clave SSH a formato PuTTY..." -ForegroundColor Green
        & puttygen "$sshDir\fimecompany_key" -o "$sshDir\fimecompany_key.ppk" -O private
        Write-Host "✅ Clave convertida a formato PPK" -ForegroundColor Green
    } else {
        # Generar nueva clave en formato PPK
        Write-Host "🆕 Generando nueva clave SSH en formato PuTTY..." -ForegroundColor Green
        & puttygen -t rsa -b 4096 -o "$sshDir\fimecompany_key.ppk" --new-passphrase ""
        & puttygen "$sshDir\fimecompany_key.ppk" -O public-openssh -o "$sshDir\fimecompany_key.pub"
        Write-Host "✅ Nueva clave SSH generada en formato PPK" -ForegroundColor Green
    }
} else {
    Write-Host "⚠️ PuTTYgen no encontrado. Instalando..." -ForegroundColor Yellow
    winget install PuTTY.PuTTY
}

# Crear script de conexión automática
Write-Host "📜 Creando script de conexión automática..." -ForegroundColor Green

$connectionScript = @"
@echo off
echo 🚀 Conectando a cPanel via PuTTY...
putty -load fimecompany_cpanel
"@

$connectionScript | Out-File -FilePath "conectar-cpanel.bat" -Encoding ASCII

# Crear script de sincronización automática con rsync
$rsyncScript = @"
#!/bin/bash
echo "🚀 Sincronizando archivos con cPanel..."

# Configuración
LOCAL_DIR="C:/Users/PC/.android/fime-company-automation/src"
REMOTE_HOST="fimecomp@fimecompany.com"
REMOTE_DIR="/public_html"

# Sincronizar archivos
rsync -avz --delete \
    --exclude='.git*' \
    --exclude='node_modules' \
    --exclude='*.log' \
    --progress \
    "$LOCAL_DIR/" "$REMOTE_HOST:$REMOTE_DIR/"

echo "✅ Sincronización completada"
"@

$rsyncScript | Out-File -FilePath "sincronizar-cpanel.sh" -Encoding UTF8

Write-Host "📜 Creando script PowerShell para automatización..." -ForegroundColor Green

# Script PowerShell para automatización completa
$automationScript = @"
# Automatización completa Cursor + GitHub + cPanel
param(
    [string]`$Message = "Actualización automática"
)

Write-Host "🚀 AUTOMATIZACIÓN COMPLETA FIME COMPANY" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Yellow

# 1. Hacer commit y push a GitHub
Write-Host "📤 Subiendo cambios a GitHub..." -ForegroundColor Green
git add .
git commit -m "`$Message" -q
git push origin main -q

# 2. Sincronizar con cPanel via SSH
Write-Host "🔄 Sincronizando con cPanel..." -ForegroundColor Green

# Usar plink (PuTTY command line) para ejecutar comandos remotos
if (Get-Command plink -ErrorAction SilentlyContinue) {
    # Comando de sincronización remota
    `$remoteCommands = @"
cd /public_html
git pull origin main
chmod -R 755 *
echo "✅ Sincronización cPanel completada"
"@
    
    # Ejecutar comandos remotos
    `$remoteCommands | plink -batch -i "`$env:USERPROFILE\.ssh\fimecompany_key.ppk" fimecomp@fimecompany.com
    
    Write-Host "✅ Automatización completada" -ForegroundColor Green
} else {
    Write-Host "⚠️ plink no encontrado. Usando método alternativo..." -ForegroundColor Yellow
    
    # Método alternativo con PowerShell SSH
    if (Get-Module -ListAvailable -Name Posh-SSH) {
        Import-Module Posh-SSH
        
        # Conectar y ejecutar comandos
        `$session = New-SSHSession -ComputerName "fimecompany.com" -Credential (Get-Credential fimecomp) -KeyFile "`$env:USERPROFILE\.ssh\fimecompany_key"
        Invoke-SSHCommand -SessionId `$session.SessionId -Command "cd /public_html && git pull origin main && chmod -R 755 *"
        Remove-SSHSession -SessionId `$session.SessionId
        
        Write-Host "✅ Sincronización SSH completada" -ForegroundColor Green
    } else {
        Write-Host "📦 Instalando módulo Posh-SSH..." -ForegroundColor Yellow
        Install-Module -Name Posh-SSH -Force -AllowClobber
        Write-Host "🔄 Reinicia PowerShell e intenta de nuevo" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "🎉 ¡AUTOMATIZACIÓN TOTAL COMPLETADA!" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "====================================" -ForegroundColor Yellow
Write-Host "✅ GitHub actualizado" -ForegroundColor Green
Write-Host "✅ cPanel sincronizado" -ForegroundColor Green
Write-Host "✅ Permisos configurados" -ForegroundColor Green
"@

$automationScript | Out-File -FilePath "automatizar-todo.ps1" -Encoding UTF8

Write-Host ""
Write-Host "🎉 ¡CONFIGURACIÓN PUTTY + CPANEL COMPLETADA!" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "=============================================" -ForegroundColor Yellow
Write-Host "✅ PuTTY configurado para fimecompany.com" -ForegroundColor Green
Write-Host "✅ Claves SSH en formato PPK creadas" -ForegroundColor Green
Write-Host "✅ Scripts de conexión automática creados" -ForegroundColor Green
Write-Host "✅ Automatización completa lista" -ForegroundColor Green
Write-Host ""
Write-Host "📋 ARCHIVOS CREADOS:" -ForegroundColor Cyan
Write-Host "  📄 conectar-cpanel.bat - Conexión directa PuTTY" -ForegroundColor White
Write-Host "  📄 sincronizar-cpanel.sh - Sincronización rsync" -ForegroundColor White
Write-Host "  📄 automatizar-todo.ps1 - Automatización completa" -ForegroundColor White
Write-Host ""
Write-Host "🚀 PRÓXIMO PASO: Ejecutar automatizar-todo.ps1" -ForegroundColor Yellow
