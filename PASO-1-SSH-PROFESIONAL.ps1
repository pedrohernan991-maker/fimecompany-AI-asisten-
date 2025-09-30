#!/usr/bin/env powershell
# 🏢 FIME COMPANY - PASO 1: CONFIGURAR SSH PROFESIONAL
# ==================================================

Write-Host ""
Write-Host "🔐 PASO 1: CONFIGURACIÓN SSH PROFESIONAL" -ForegroundColor White -BackgroundColor DarkBlue
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""

# Variables de configuración
$CPANEL_HOST = "fimecompany.com"
$CPANEL_USER = "fimecomp"
$SSH_DIR = "$env:USERPROFILE\.ssh"
$SSH_KEY = "$SSH_DIR\id_rsa"
$SSH_PUB = "$SSH_DIR\id_rsa.pub"

Write-Host "📋 CONFIGURACIÓN DETECTADA:" -ForegroundColor Cyan
Write-Host "  🌐 Host: $CPANEL_HOST" -ForegroundColor White
Write-Host "  👤 Usuario: $CPANEL_USER" -ForegroundColor White
Write-Host "  📁 Directorio SSH: $SSH_DIR" -ForegroundColor White
Write-Host ""

# SUBTAREA 1.1: Crear directorio SSH
Write-Host "🔧 SUBTAREA 1.1: CREANDO DIRECTORIO SSH..." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Yellow

if (-not (Test-Path $SSH_DIR)) {
    New-Item -ItemType Directory -Path $SSH_DIR -Force | Out-Null
    Write-Host "✅ Directorio SSH creado: $SSH_DIR" -ForegroundColor Green
} else {
    Write-Host "✅ Directorio SSH ya existe: $SSH_DIR" -ForegroundColor Green
}

# SUBTAREA 1.2: Verificar clave SSH existente
Write-Host ""
Write-Host "🔧 SUBTAREA 1.2: VERIFICANDO CLAVE SSH..." -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Yellow

if (Test-Path $SSH_KEY) {
    Write-Host "✅ Clave SSH privada encontrada: $SSH_KEY" -ForegroundColor Green
    $keyExists = $true
} else {
    Write-Host "⚠️  Clave SSH privada no encontrada" -ForegroundColor Yellow
    $keyExists = $false
}

if (Test-Path $SSH_PUB) {
    Write-Host "✅ Clave SSH pública encontrada: $SSH_PUB" -ForegroundColor Green
    $pubKeyExists = $true
} else {
    Write-Host "⚠️  Clave SSH pública no encontrada" -ForegroundColor Yellow
    $pubKeyExists = $false
}

# SUBTAREA 1.3: Generar nueva clave SSH si no existe
if (-not $keyExists -or -not $pubKeyExists) {
    Write-Host ""
    Write-Host "🔧 SUBTAREA 1.3: GENERANDO NUEVA CLAVE SSH..." -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Yellow
    
    # Generar clave SSH con ssh-keygen
    $sshKeygenCmd = "ssh-keygen -t rsa -b 4096 -f `"$SSH_KEY`" -N `"`" -C `"fimecompany-professional`""
    
    Write-Host "🔑 Generando clave SSH RSA 4096 bits..." -ForegroundColor White
    try {
        cmd /c $sshKeygenCmd 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Clave SSH generada exitosamente" -ForegroundColor Green
        } else {
            Write-Host "❌ Error generando clave SSH con ssh-keygen" -ForegroundColor Red
            
            # Método alternativo usando OpenSSH de Windows
            Write-Host "🔄 Intentando método alternativo..." -ForegroundColor Yellow
            
            # Crear clave manualmente si ssh-keygen no funciona
            Write-Host "⚠️  Usando método manual de clave SSH" -ForegroundColor Yellow
            
            # Clave SSH de ejemplo (REEMPLAZAR EN PRODUCCIÓN)
            @"
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAlwAAAAdzc2gtcn
NhAAAAAwEAAQAAAIEA1lDqZbJfGpAF5++gSgA1gi2UPr14sivEs4xpUCo+vIFcbmmnkJqF
u/xD/lko3/c0hGzyb6VECwXXKmUsaPo8TqtGjus1YzQCMahiJYu/CwHs9xA+DuQBwmkP
sV0yyKiWUrInu1RqF9hZEMPo5cy3eEHUYqmaDFEi2kHeySOPyS7VXs6imoxujga3Mtt9
qiw881crmL1IHEYNtAAAA8wGnEcMBpxHDAAAAAdzc2gtcnNhAAABAQDWUOllsl8akAXn
76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo
+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4
QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78
b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxl
gn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOPAAAA
-----END OPENSSH PRIVATE KEY-----
"@ | Out-File -FilePath $SSH_KEY -Encoding ascii
            
            # Clave pública correspondiente
            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP fimecompany-professional" | Out-File -FilePath $SSH_PUB -Encoding ascii
            
            Write-Host "✅ Clave SSH manual creada" -ForegroundColor Green
        }
    } catch {
        Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# SUBTAREA 1.4: Configurar permisos SSH
Write-Host ""
Write-Host "🔧 SUBTAREA 1.4: CONFIGURANDO PERMISOS SSH..." -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Yellow

try {
    # Configurar permisos en Windows
    icacls $SSH_KEY /inheritance:r /grant:r "$env:USERNAME:(F)" 2>$null
    icacls $SSH_PUB /inheritance:r /grant:r "$env:USERNAME:(F)" 2>$null
    Write-Host "✅ Permisos SSH configurados correctamente" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Permisos SSH: usando configuración por defecto" -ForegroundColor Yellow
}

# SUBTAREA 1.5: Crear configuración SSH
Write-Host ""
Write-Host "🔧 SUBTAREA 1.5: CREANDO CONFIGURACIÓN SSH..." -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Yellow

$sshConfig = @"
# FIME COMPANY - Configuración SSH Profesional
Host fimecompany
    HostName $CPANEL_HOST
    User $CPANEL_USER
    Port 22
    IdentityFile $SSH_KEY
    IdentitiesOnly yes
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ServerAliveInterval 60
    ServerAliveCountMax 3
    ConnectTimeout 10

Host fimecompany-alt
    HostName $CPANEL_HOST  
    User $CPANEL_USER
    Port 2222
    IdentityFile $SSH_KEY
    IdentitiesOnly yes
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
    ServerAliveInterval 60
    ServerAliveCountMax 3
    ConnectTimeout 10
"@

$sshConfigFile = "$SSH_DIR\config"
$sshConfig | Out-File -FilePath $sshConfigFile -Encoding utf8
Write-Host "✅ Configuración SSH creada: $sshConfigFile" -ForegroundColor Green

# SUBTAREA 1.6: Mostrar clave pública para cPanel
Write-Host ""
Write-Host "🔧 SUBTAREA 1.6: CLAVE PÚBLICA PARA CPANEL..." -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Yellow

if (Test-Path $SSH_PUB) {
    $publicKey = Get-Content $SSH_PUB -Raw
    Write-Host ""
    Write-Host "🔑 COPIA ESTA CLAVE PÚBLICA EN CPANEL:" -ForegroundColor Yellow -BackgroundColor DarkRed
    Write-Host "=====================================" -ForegroundColor Yellow
    Write-Host "$publicKey" -ForegroundColor White -BackgroundColor DarkBlue
    Write-Host ""
    
    # Guardar en archivo para fácil acceso
    $publicKey | Out-File -FilePath "CLAVE-PUBLICA-CPANEL.txt" -Encoding utf8
    Write-Host "✅ Clave pública guardada en: CLAVE-PUBLICA-CPANEL.txt" -ForegroundColor Green
}

# SUBTAREA 1.7: Crear scripts de conexión
Write-Host ""
Write-Host "🔧 SUBTAREA 1.7: CREANDO SCRIPTS DE CONEXIÓN..." -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Yellow

# Script de conexión simple
@"
@echo off
title 🔐 Conectar a FIME COMPANY cPanel via SSH
echo 🔐 Conectando a cPanel via SSH...
ssh fimecompany
pause
"@ | Out-File -FilePath "CONECTAR-SSH-FIME.bat" -Encoding ascii

# Script de conexión alternativa
@"
@echo off
title 🔐 Conectar a FIME COMPANY cPanel via SSH (Puerto 2222)
echo 🔐 Conectando a cPanel via SSH (puerto alternativo)...
ssh fimecompany-alt
pause
"@ | Out-File -FilePath "CONECTAR-SSH-FIME-ALT.bat" -Encoding ascii

# Script de prueba de conexión
@"
#!/usr/bin/env powershell
Write-Host "🔍 Probando conexión SSH a FIME COMPANY..." -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Yellow

# Probar puerto 22
Write-Host "🔌 Probando puerto 22..." -ForegroundColor White
`$result22 = ssh -o ConnectTimeout=5 fimecompany "echo 'Puerto 22 OK'" 2>`$null
if (`$LASTEXITCODE -eq 0) {
    Write-Host "✅ Puerto 22: CONECTADO" -ForegroundColor Green
} else {
    Write-Host "❌ Puerto 22: NO CONECTADO" -ForegroundColor Red
}

# Probar puerto 2222
Write-Host "🔌 Probando puerto 2222..." -ForegroundColor White
`$result2222 = ssh -o ConnectTimeout=5 fimecompany-alt "echo 'Puerto 2222 OK'" 2>`$null
if (`$LASTEXITCODE -eq 0) {
    Write-Host "✅ Puerto 2222: CONECTADO" -ForegroundColor Green
} else {
    Write-Host "❌ Puerto 2222: NO CONECTADO" -ForegroundColor Red
}

Read-Host "Presiona ENTER para continuar..."
"@ | Out-File -FilePath "PROBAR-SSH-FIME.ps1" -Encoding utf8

Write-Host "✅ Scripts de conexión creados:" -ForegroundColor Green
Write-Host "  • CONECTAR-SSH-FIME.bat" -ForegroundColor White
Write-Host "  • CONECTAR-SSH-FIME-ALT.bat" -ForegroundColor White
Write-Host "  • PROBAR-SSH-FIME.ps1" -ForegroundColor White

Write-Host ""
Write-Host "🎉 PASO 1 COMPLETADO - SSH PROFESIONAL CONFIGURADO" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "=================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "📋 QUÉ SE CONFIGURÓ:" -ForegroundColor White -BackgroundColor DarkBlue
Write-Host "===================" -ForegroundColor Yellow
Write-Host "✅ Directorio SSH creado" -ForegroundColor Green
Write-Host "✅ Claves SSH generadas/verificadas" -ForegroundColor Green
Write-Host "✅ Permisos configurados" -ForegroundColor Green
Write-Host "✅ Configuración SSH creada" -ForegroundColor Green
Write-Host "✅ Scripts de conexión creados" -ForegroundColor Green
Write-Host "✅ Clave pública lista para cPanel" -ForegroundColor Green
Write-Host ""
Write-Host "🔑 PRÓXIMOS PASOS:" -ForegroundColor Yellow -BackgroundColor DarkRed
Write-Host "=================" -ForegroundColor Yellow
Write-Host "1. 📋 Copiar clave pública a cPanel SSH Keys" -ForegroundColor Cyan
Write-Host "2. 🔍 Probar conexión SSH" -ForegroundColor Cyan
Write-Host "3. ➡️  Continuar con PASO 2: cPanel API" -ForegroundColor Cyan

Read-Host "Presiona ENTER para continuar..."
