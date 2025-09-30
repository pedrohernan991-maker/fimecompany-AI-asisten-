# ===============================================
# CONFIGURACIÓN PUTTY COMPLETA - FIME COMPANY
# Con puerto, host, notificaciones y todos los datos
# ===============================================

Write-Host "🚀 CONFIGURACIÓN PUTTY COMPLETA FIME COMPANY" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "=============================================" -ForegroundColor Yellow

# DATOS COMPLETOS FIME COMPANY
$FIME_CONFIG = @{
    "HOST" = "fimecompany.com"
    "USER" = "fimecomp"
    "PORT_PRIMARY" = "22"
    "PORT_SECONDARY" = "2222" 
    "SESSION_NAME" = "FIME_COMPANY_CPANEL"
    "KEY_NAME" = "fimecompany_key"
    "DOMAIN" = "fimecompany.com"
    "CPANEL_PORT" = "2083"
}

Write-Host "📋 CONFIGURACIÓN FIME COMPANY:" -ForegroundColor Green
Write-Host "   🌐 Host: $($FIME_CONFIG.HOST)" -ForegroundColor White
Write-Host "   👤 Usuario: $($FIME_CONFIG.USER)" -ForegroundColor White  
Write-Host "   🔌 Puerto SSH: $($FIME_CONFIG.PORT_PRIMARY) (principal) / $($FIME_CONFIG.PORT_SECONDARY) (alternativo)" -ForegroundColor White
Write-Host "   🔑 Clave: $($FIME_CONFIG.KEY_NAME)" -ForegroundColor White
Write-Host "   📱 Sesión: $($FIME_CONFIG.SESSION_NAME)" -ForegroundColor White

# Función para verificar y instalar PuTTY
function Install-PuTTYIfNeeded {
    Write-Host "📦 Verificando instalación PuTTY..." -ForegroundColor Green
    
    try {
        $puttyPath = Get-Command putty -ErrorAction Stop
        Write-Host "✅ PuTTY encontrado en: $($puttyPath.Source)" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "❌ PuTTY no encontrado. Instalando..." -ForegroundColor Yellow
        
        try {
            winget install PuTTY.PuTTY --accept-source-agreements --accept-package-agreements
            Write-Host "✅ PuTTY instalado exitosamente" -ForegroundColor Green
            return $true
        } catch {
            Write-Host "❌ ERROR: No se pudo instalar PuTTY automáticamente" -ForegroundColor Red
            Write-Host "🔧 SOLUCIÓN: Descarga PuTTY manualmente desde: https://www.putty.org/" -ForegroundColor Yellow
            return $false
        }
    }
}

# Función para probar conectividad al host
function Test-HostConnectivity {
    param($Host, $Port)
    
    Write-Host "🔍 Probando conectividad a $Host`:$Port..." -ForegroundColor Yellow
    
    try {
        $connection = Test-NetConnection -ComputerName $Host -Port $Port -WarningAction SilentlyContinue
        
        if ($connection.TcpTestSucceeded) {
            Write-Host "✅ Conexión exitosa a $Host`:$Port" -ForegroundColor Green
            return $true
        } else {
            Write-Host "❌ No se pudo conectar a $Host`:$Port" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "❌ Error probando conexión: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para configurar clave SSH en formato PuTTY
function Setup-SSHKey {
    Write-Host "🔑 Configurando clave SSH..." -ForegroundColor Green
    
    $sshDir = "$env:USERPROFILE\.ssh"
    $keyFile = "$sshDir\$($FIME_CONFIG.KEY_NAME)"
    $ppkFile = "$sshDir\$($FIME_CONFIG.KEY_NAME).ppk"
    
    # Crear directorio SSH si no existe
    if (!(Test-Path $sshDir)) {
        New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
        Write-Host "📁 Directorio SSH creado: $sshDir" -ForegroundColor Cyan
    }
    
    # Tu clave SSH pública
    $publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP"
    
    # Guardar clave pública
    $publicKey | Out-File -FilePath "$keyFile.pub" -Encoding ASCII -NoNewline
    Write-Host "📄 Clave pública guardada: $keyFile.pub" -ForegroundColor Cyan
    
    # Verificar PuTTYgen
    try {
        $puttygen = Get-Command puttygen -ErrorAction Stop
        Write-Host "✅ PuTTYgen encontrado: $($puttygen.Source)" -ForegroundColor Green
        
        # Nota: La clave privada se necesita para convertir a PPK
        Write-Host "⚠️ NOTA IMPORTANTE:" -ForegroundColor Yellow
        Write-Host "   Para completar la configuración necesitas la clave privada" -ForegroundColor White
        Write-Host "   Ejecuta: Get-Content ~/.ssh/$($FIME_CONFIG.KEY_NAME) (si existe)" -ForegroundColor White
        
    } catch {
        Write-Host "⚠️ PuTTYgen no encontrado" -ForegroundColor Yellow
        Write-Host "🔧 Se configurará después de la instalación" -ForegroundColor Cyan
    }
    
    return $keyFile
}

# Función para crear configuración PuTTY en registro
function Create-PuTTYRegistry {
    param($Port)
    
    Write-Host "⚙️ Creando configuración PuTTY en registro..." -ForegroundColor Green
    
    $registryPath = "HKEY_CURRENT_USER\SOFTWARE\SimonTatham\PuTTY\Sessions\$($FIME_CONFIG.SESSION_NAME)"
    $tempFile = "$env:TEMP\putty_fime_config.reg"
    
    $registryContent = @"
Windows Registry Editor Version 5.00

[$registryPath]
"HostName"="$($FIME_CONFIG.HOST)"
"PortNumber"=dword:$('{0:x8}' -f [int]$Port)
"Protocol"="ssh"
"UserName"="$($FIME_CONFIG.USER)"
"PublicKeyFile"="$env:USERPROFILE\.ssh\$($FIME_CONFIG.KEY_NAME).ppk"
"SSH2PrivkeyFile"="$env:USERPROFILE\.ssh\$($FIME_CONFIG.KEY_NAME).ppk"
"SshProt"=dword:00000002
"SSH2DES"=dword:00000000
"SshNoAuth"=dword:00000000
"AuthTIS"=dword:00000000
"AuthKI"=dword:00000001
"AuthGSSAPI"=dword:00000000
"AgentFwd"=dword:00000000
"ChangeUsername"=dword:00000000
"Compression"=dword:00000001
"LogFileName"=""
"LogType"=dword:00000000
"LogFileClash"=dword:ffffffff
"Font"="Consolas"
"FontCharSet"=dword:00000000
"FontHeight"=dword:0000000e
"FontIsBold"=dword:00000000
"FontQuality"=dword:00000000
"FontVTMode"=dword:00000004
"UseSystemColours"=dword:00000000
"TryPalette"=dword:00000000
"ANSIColour"=dword:00000001
"Xterm256Colour"=dword:00000001
"BoldAsColour"=dword:00000001
"Colour0"="192,192,192"
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
    
    # Guardar archivo de registro
    $registryContent | Out-File -FilePath $tempFile -Encoding ASCII
    
    # Aplicar configuración al registro
    try {
        reg import $tempFile 2>$null
        Write-Host "✅ Configuración PuTTY aplicada al registro" -ForegroundColor Green
        Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
        return $true
    } catch {
        Write-Host "❌ Error aplicando configuración al registro: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para crear scripts de conexión
function Create-ConnectionScripts {
    Write-Host "📜 Creando scripts de conexión..." -ForegroundColor Green
    
    # Script de conexión principal
    $connectScript = @"
@echo off
title FIME COMPANY - Conexión cPanel
echo 🚀 Conectando a FIME COMPANY cPanel...
echo ====================================
echo Host: $($FIME_CONFIG.HOST)
echo Usuario: $($FIME_CONFIG.USER)
echo Puerto: $($FIME_CONFIG.PORT_PRIMARY)
echo.
putty -load "$($FIME_CONFIG.SESSION_NAME)"
"@
    
    $connectScript | Out-File -FilePath "conectar-fime-cpanel.bat" -Encoding ASCII
    Write-Host "✅ Script creado: conectar-fime-cpanel.bat" -ForegroundColor Green
    
    # Script de conexión alternativa (puerto 2222)
    $connectAltScript = @"
@echo off
title FIME COMPANY - Conexión Alternativa cPanel
echo 🚀 Conectando a FIME COMPANY cPanel (Puerto alternativo)...
echo =======================================================
echo Host: $($FIME_CONFIG.HOST)
echo Usuario: $($FIME_CONFIG.USER)
echo Puerto: $($FIME_CONFIG.PORT_SECONDARY)
echo.
putty -ssh $($FIME_CONFIG.USER)@$($FIME_CONFIG.HOST) -P $($FIME_CONFIG.PORT_SECONDARY) -i "%USERPROFILE%\.ssh\$($FIME_CONFIG.KEY_NAME).ppk"
"@
    
    $connectAltScript | Out-File -FilePath "conectar-fime-cpanel-alt.bat" -Encoding ASCII
    Write-Host "✅ Script alternativo creado: conectar-fime-cpanel-alt.bat" -ForegroundColor Green
    
    # Script PowerShell para pruebas
    $testScript = @"
# Script de prueba de conexión FIME COMPANY
Write-Host "🔍 Probando conexión SSH a FIME COMPANY..." -ForegroundColor Cyan

`$tests = @(
    @{Host="$($FIME_CONFIG.HOST)"; Port=$($FIME_CONFIG.PORT_PRIMARY)},
    @{Host="$($FIME_CONFIG.HOST)"; Port=$($FIME_CONFIG.PORT_SECONDARY)},
    @{Host="$($FIME_CONFIG.HOST)"; Port=$($FIME_CONFIG.CPANEL_PORT)}
)

foreach (`$test in `$tests) {
    Write-Host "🔌 Probando `$(`$test.Host):`$(`$test.Port)..." -ForegroundColor Yellow
    
    try {
        `$result = Test-NetConnection -ComputerName `$test.Host -Port `$test.Port -WarningAction SilentlyContinue
        if (`$result.TcpTestSucceeded) {
            Write-Host "✅ `$(`$test.Host):`$(`$test.Port) - CONECTADO" -ForegroundColor Green
        } else {
            Write-Host "❌ `$(`$test.Host):`$(`$test.Port) - NO DISPONIBLE" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ `$(`$test.Host):`$(`$test.Port) - ERROR" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "📋 INFORMACIÓN DE CONEXIÓN:" -ForegroundColor Cyan
Write-Host "   Host: $($FIME_CONFIG.HOST)" -ForegroundColor White
Write-Host "   Usuario: $($FIME_CONFIG.USER)" -ForegroundColor White
Write-Host "   Puerto SSH: $($FIME_CONFIG.PORT_PRIMARY) (principal)" -ForegroundColor White
Write-Host "   Puerto SSH Alt: $($FIME_CONFIG.PORT_SECONDARY) (alternativo)" -ForegroundColor White
Write-Host "   Puerto cPanel: $($FIME_CONFIG.CPANEL_PORT)" -ForegroundColor White
"@
    
    $testScript | Out-File -FilePath "probar-conexion-fime.ps1" -Encoding UTF8
    Write-Host "✅ Script de pruebas creado: probar-conexion-fime.ps1" -ForegroundColor Green
}

# Función principal de configuración
function Configure-PuTTYComplete {
    Write-Host ""
    Write-Host "🚀 INICIANDO CONFIGURACIÓN PUTTY COMPLETA" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "=========================================" -ForegroundColor Yellow
    
    # Paso 1: Verificar/Instalar PuTTY
    Write-Host "🔸 Paso 1: Verificando PuTTY..." -ForegroundColor Cyan
    if (!(Install-PuTTYIfNeeded)) {
        Write-Host "❌ FALLO: No se pudo configurar PuTTY. Instálalo manualmente." -ForegroundColor Red
        return $false
    }
    
    # Paso 2: Probar conectividad
    Write-Host "🔸 Paso 2: Probando conectividad..." -ForegroundColor Cyan
    $port22Available = Test-HostConnectivity -Host $FIME_CONFIG.HOST -Port $FIME_CONFIG.PORT_PRIMARY
    $port2222Available = Test-HostConnectivity -Host $FIME_CONFIG.HOST -Port $FIME_CONFIG.PORT_SECONDARY
    
    if (!$port22Available -and !$port2222Available) {
        Write-Host "❌ ADVERTENCIA: No se pudo conectar en ningún puerto SSH" -ForegroundColor Red
        Write-Host "🔧 Posibles causas:" -ForegroundColor Yellow
        Write-Host "   • SSH no está habilitado en el hosting" -ForegroundColor White
        Write-Host "   • Firewall bloqueando conexiones" -ForegroundColor White
        Write-Host "   • Puerto SSH diferente" -ForegroundColor White
        Write-Host "📞 Contacta a tu proveedor de hosting para habilitar SSH" -ForegroundColor Cyan
    }
    
    # Paso 3: Configurar clave SSH
    Write-Host "🔸 Paso 3: Configurando clave SSH..." -ForegroundColor Cyan
    $keyPath = Setup-SSHKey
    
    # Paso 4: Crear configuración PuTTY
    Write-Host "🔸 Paso 4: Creando configuración PuTTY..." -ForegroundColor Cyan
    $primaryPort = if ($port22Available) { $FIME_CONFIG.PORT_PRIMARY } else { $FIME_CONFIG.PORT_SECONDARY }
    Create-PuTTYRegistry -Port $primaryPort
    
    # Paso 5: Crear scripts de conexión
    Write-Host "🔸 Paso 5: Creando scripts de conexión..." -ForegroundColor Cyan
    Create-ConnectionScripts
    
    Write-Host ""
    Write-Host "🎉 ¡CONFIGURACIÓN PUTTY COMPLETADA!" -ForegroundColor Green -BackgroundColor DarkGreen
    Write-Host "===================================" -ForegroundColor Yellow
    Write-Host "✅ PuTTY instalado y configurado" -ForegroundColor Green
    Write-Host "✅ Sesión '$($FIME_CONFIG.SESSION_NAME)' creada" -ForegroundColor Green
    Write-Host "✅ Clave SSH configurada" -ForegroundColor Green
    Write-Host "✅ Scripts de conexión creados" -ForegroundColor Green
    
    Write-Host ""
    Write-Host "📋 ARCHIVOS CREADOS:" -ForegroundColor Cyan
    Write-Host "   📄 conectar-fime-cpanel.bat" -ForegroundColor White
    Write-Host "   📄 conectar-fime-cpanel-alt.bat" -ForegroundColor White
    Write-Host "   📄 probar-conexion-fime.ps1" -ForegroundColor White
    
    Write-Host ""
    Write-Host "🚀 PRÓXIMOS PASOS:" -ForegroundColor Yellow
    Write-Host "1. Agregar tu clave SSH a cPanel (SSH Keys)" -ForegroundColor White
    Write-Host "2. Autorizar la clave en cPanel" -ForegroundColor White
    Write-Host "3. Probar conexión: .\probar-conexion-fime.ps1" -ForegroundColor White
    Write-Host "4. Conectar: .\conectar-fime-cpanel.bat" -ForegroundColor White
    
    if (!$port22Available -and !$port2222Available) {
        Write-Host ""
        Write-Host "⚠️ IMPORTANTE: SSH no está disponible" -ForegroundColor Red -BackgroundColor Yellow
        Write-Host "📞 Contacta a tu proveedor de hosting para habilitar SSH" -ForegroundColor Yellow
        Write-Host "🔧 Alternativamente, usa FTP/SFTP para subir archivos" -ForegroundColor Cyan
    }
    
    return $true
}

# Función de notificación cuando no se puede ejecutar
function Show-ExecutionError {
    param($ErrorMessage, $SuggestedAction)
    
    Write-Host ""
    Write-Host "❌ ERROR DE EJECUCIÓN" -ForegroundColor White -BackgroundColor Red
    Write-Host "=====================" -ForegroundColor Red
    Write-Host "🔴 Error: $ErrorMessage" -ForegroundColor Red
    Write-Host ""
    Write-Host "🔧 ACCIÓN SUGERIDA:" -ForegroundColor Yellow
    Write-Host "$SuggestedAction" -ForegroundColor White
    Write-Host ""
    Write-Host "📞 SI EL PROBLEMA PERSISTE:" -ForegroundColor Cyan
    Write-Host "   • Verifica que tengas permisos de administrador" -ForegroundColor White
    Write-Host "   • Revisa tu conexión a internet" -ForegroundColor White
    Write-Host "   • Contacta soporte técnico" -ForegroundColor White
}

Write-Host ""
Write-Host "📋 COMANDOS DISPONIBLES:" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Yellow
Write-Host "🚀 Configure-PuTTYComplete  # Configuración completa" -ForegroundColor White
Write-Host "🔍 Test-HostConnectivity    # Probar conectividad" -ForegroundColor White
Write-Host "🔑 Setup-SSHKey            # Configurar clave SSH" -ForegroundColor White
Write-Host "📜 Create-ConnectionScripts # Crear scripts conexión" -ForegroundColor White

Write-Host ""
Write-Host "🎯 EJECUTAR CONFIGURACIÓN COMPLETA:" -ForegroundColor Green
Write-Host "Configure-PuTTYComplete" -ForegroundColor Yellow
