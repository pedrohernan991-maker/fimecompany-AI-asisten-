# ===============================================
# VERIFICACIÓN COMPLETA AUTOMATIZACIÓN CPANEL
# CURSOR - Revisar TODAS las configuraciones
# ===============================================

Write-Host "🔍 VERIFICACIÓN COMPLETA AUTOMATIZACIÓN CPANEL" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "===============================================" -ForegroundColor Yellow

# CONFIGURACIÓN FIME COMPANY
$FIME_CONFIG = @{
    "HOST" = "fimecompany.com"
    "USER" = "fimecomp"  
    "SSH_KEY_PUB" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP"
    "LOCAL_PATH" = "C:\Users\PC\.android\c panel"
    "PROJECT_PATH" = "C:\Users\PC\.android\fime-company-automation"
}

Write-Host "📋 DATOS FIME COMPANY:" -ForegroundColor Green
Write-Host "   🌐 Host: $($FIME_CONFIG.HOST)" -ForegroundColor White
Write-Host "   👤 Usuario: $($FIME_CONFIG.USER)" -ForegroundColor White
Write-Host "   🔑 SSH Key: Configurada ✅" -ForegroundColor White
Write-Host "   📂 Archivos locales: $($FIME_CONFIG.LOCAL_PATH)" -ForegroundColor White

# Función de verificación completa
function Verify-AllAutomation {
    Write-Host ""
    Write-Host "🔍 INICIANDO VERIFICACIÓN COMPLETA" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "===================================" -ForegroundColor Yellow
    
    # 1. VERIFICAR ARCHIVOS LOCALES
    Write-Host "📁 1. VERIFICANDO ARCHIVOS LOCALES..." -ForegroundColor Green
    Write-Host "=====================================" -ForegroundColor Yellow
    
    $localFiles = @{
        "index.html" = "Portal principal FIME COMPANY"
        "styles.css" = "Estilos unificados"
        "fimetech\index.html" = "FimeTech división"
        "fimekids\index.html" = "FimeKids división"
        "ferreteria\index.html" = "Ferretería división"
    }
    
    $localPath = $FIME_CONFIG.LOCAL_PATH
    
    foreach ($file in $localFiles.Keys) {
        $filePath = Join-Path $localPath $file
        if (Test-Path $filePath) {
            Write-Host "   ✅ $file - $($localFiles[$file])" -ForegroundColor Green
        } else {
            Write-Host "   ❌ $file - NO ENCONTRADO" -ForegroundColor Red
        }
    }
    
    # 2. VERIFICAR SCRIPTS DE AUTOMATIZACIÓN
    Write-Host ""
    Write-Host "📜 2. VERIFICANDO SCRIPTS DE AUTOMATIZACIÓN..." -ForegroundColor Green
    Write-Host "=============================================" -ForegroundColor Yellow
    
    $scripts = @{
        "configurar-cursor-github.ps1" = "Automatización Cursor + GitHub"
        "automatizar-cpanel-total.ps1" = "Automatización total cPanel"
        "configurar-putty-completo-fime.ps1" = "Configuración PuTTY"
        "deployment-profesional-ssh.ps1" = "Deployment SSH"
        "deployment-public-html.ps1" = "Deployment public_html"
    }
    
    foreach ($script in $scripts.Keys) {
        $scriptPath = Join-Path $localPath $script
        if (Test-Path $scriptPath) {
            $size = (Get-Item $scriptPath).Length
            Write-Host "   ✅ $script - $($scripts[$script]) ($size bytes)" -ForegroundColor Green
        } else {
            Write-Host "   ❌ $script - NO ENCONTRADO" -ForegroundColor Red
        }
    }
    
    # 3. VERIFICAR HERRAMIENTAS INSTALADAS
    Write-Host ""
    Write-Host "🛠️ 3. VERIFICANDO HERRAMIENTAS INSTALADAS..." -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Yellow
    
    $tools = @{
        "git" = "Git para control de versiones"
        "ssh" = "SSH para conexión segura"  
        "scp" = "SCP para transferencia archivos"
        "putty" = "PuTTY para conexión SSH"
        "plink" = "Plink para comandos SSH"
        "pscp" = "PSCP para transferencia archivos"
    }
    
    foreach ($tool in $tools.Keys) {
        try {
            $toolPath = Get-Command $tool -ErrorAction Stop
            Write-Host "   ✅ $tool - $($tools[$tool]) - $($toolPath.Source)" -ForegroundColor Green
        } catch {
            Write-Host "   ❌ $tool - NO INSTALADO - $($tools[$tool])" -ForegroundColor Red
        }
    }
    
    # 4. VERIFICAR CONECTIVIDAD
    Write-Host ""
    Write-Host "🌐 4. VERIFICANDO CONECTIVIDAD..." -ForegroundColor Green
    Write-Host "=================================" -ForegroundColor Yellow
    
    $connections = @{
        @{Host=$FIME_CONFIG.HOST; Port=22; Description="SSH Puerto 22"}
        @{Host=$FIME_CONFIG.HOST; Port=2222; Description="SSH Puerto 2222 (alternativo)"}
        @{Host=$FIME_CONFIG.HOST; Port=2083; Description="cPanel HTTPS"}
        @{Host=$FIME_CONFIG.HOST; Port=80; Description="HTTP Web"}
        @{Host=$FIME_CONFIG.HOST; Port=443; Description="HTTPS Web"}
    }
    
    foreach ($conn in $connections) {
        try {
            $test = Test-NetConnection -ComputerName $conn.Host -Port $conn.Port -WarningAction SilentlyContinue -InformationLevel Quiet
            if ($test.TcpTestSucceeded) {
                Write-Host "   ✅ $($conn.Host):$($conn.Port) - $($conn.Description) - CONECTADO" -ForegroundColor Green
            } else {
                Write-Host "   ❌ $($conn.Host):$($conn.Port) - $($conn.Description) - NO DISPONIBLE" -ForegroundColor Red
            }
        } catch {
            Write-Host "   ❌ $($conn.Host):$($conn.Port) - $($conn.Description) - ERROR" -ForegroundColor Red
        }
    }
    
    # 5. VERIFICAR CLAVES SSH
    Write-Host ""
    Write-Host "🔑 5. VERIFICANDO CLAVES SSH..." -ForegroundColor Green
    Write-Host "===============================" -ForegroundColor Yellow
    
    $sshDir = "$env:USERPROFILE\.ssh"
    
    if (Test-Path $sshDir) {
        Write-Host "   ✅ Directorio SSH existe: $sshDir" -ForegroundColor Green
        
        $keyFiles = @("fimecompany_key", "fimecompany_key.pub", "fimecompany_key.ppk")
        
        foreach ($keyFile in $keyFiles) {
            $keyPath = Join-Path $sshDir $keyFile
            if (Test-Path $keyPath) {
                $size = (Get-Item $keyPath).Length
                Write-Host "   ✅ $keyFile - EXISTE ($size bytes)" -ForegroundColor Green
            } else {
                Write-Host "   ⚠️ $keyFile - NO ENCONTRADO" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "   ❌ Directorio SSH no existe: $sshDir" -ForegroundColor Red
    }
    
    # 6. VERIFICAR CONFIGURACIÓN PUTTY
    Write-Host ""
    Write-Host "🖥️ 6. VERIFICANDO CONFIGURACIÓN PUTTY..." -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Yellow
    
    try {
        $puttyReg = "HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions"
        
        if (Test-Path $puttyReg) {
            $sessions = Get-ChildItem $puttyReg -ErrorAction SilentlyContinue
            
            if ($sessions) {
                Write-Host "   ✅ Registro PuTTY existe" -ForegroundColor Green
                foreach ($session in $sessions) {
                    $sessionName = $session.PSChildName
                    Write-Host "   📋 Sesión encontrada: $sessionName" -ForegroundColor Cyan
                }
            } else {
                Write-Host "   ⚠️ No hay sesiones PuTTY configuradas" -ForegroundColor Yellow
            }
        } else {
            Write-Host "   ❌ Registro PuTTY no existe" -ForegroundColor Red
        }
    } catch {
        Write-Host "   ❌ Error verificando registro PuTTY: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # 7. VERIFICAR PROYECTO AUTOMATIZADO
    Write-Host ""
    Write-Host "📦 7. VERIFICANDO PROYECTO AUTOMATIZADO..." -ForegroundColor Green
    Write-Host "=========================================" -ForegroundColor Yellow
    
    $projectPath = $FIME_CONFIG.PROJECT_PATH
    
    if (Test-Path $projectPath) {
        Write-Host "   ✅ Proyecto existe: $projectPath" -ForegroundColor Green
        
        $projectItems = @("src", ".github", "package.json", "README.md", ".gitignore")
        
        foreach ($item in $projectItems) {
            $itemPath = Join-Path $projectPath $item
            if (Test-Path $itemPath) {
                Write-Host "   ✅ $item - EXISTE" -ForegroundColor Green
            } else {
                Write-Host "   ⚠️ $item - NO ENCONTRADO" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "   ❌ Proyecto no existe: $projectPath" -ForegroundColor Red
    }
    
    # 8. VERIFICAR SITIO WEB EN LÍNEA
    Write-Host ""
    Write-Host "🌐 8. VERIFICANDO SITIO WEB EN LÍNEA..." -ForegroundColor Green
    Write-Host "======================================" -ForegroundColor Yellow
    
    $websites = @(
        "https://fimecompany.com",
        "https://fimecompany.com/fimetech/",
        "https://fimecompany.com/fimekids/",
        "https://fimecompany.com/ferreteria/"
    )
    
    foreach ($site in $websites) {
        try {
            $response = Invoke-WebRequest -Uri $site -Method Head -TimeoutSec 5 -ErrorAction Stop
            Write-Host "   ✅ $site - FUNCIONANDO (Código: $($response.StatusCode))" -ForegroundColor Green
        } catch {
            Write-Host "   ❌ $site - NO DISPONIBLE" -ForegroundColor Red
        }
    }
    
    Write-Host ""
    Write-Host "🎯 RESUMEN DE VERIFICACIÓN" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "==========================" -ForegroundColor Yellow
    
    Generate-AutomationSummary
}

# Función para generar resumen
function Generate-AutomationSummary {
    Write-Host ""
    Write-Host "📊 ESTADO ACTUAL DE AUTOMATIZACIÓN:" -ForegroundColor Green
    Write-Host "====================================" -ForegroundColor Yellow
    
    Write-Host "✅ COMPLETADO:" -ForegroundColor Green
    Write-Host "   • Scripts de automatización creados" -ForegroundColor White
    Write-Host "   • Configuración PuTTY preparada" -ForegroundColor White  
    Write-Host "   • Archivos web optimizados" -ForegroundColor White
    Write-Host "   • Clave SSH generada" -ForegroundColor White
    
    Write-Host ""
    Write-Host "⚠️ PENDIENTE:" -ForegroundColor Yellow
    Write-Host "   • Subir clave SSH a cPanel" -ForegroundColor White
    Write-Host "   • Autorizar clave SSH en cPanel" -ForegroundColor White
    Write-Host "   • Subir archivos a public_html" -ForegroundColor White
    Write-Host "   • Verificar sitio web funcionando" -ForegroundColor White
    
    Write-Host ""
    Write-Host "🔧 PRÓXIMOS PASOS:" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Yellow
    Write-Host "1. Ir a cPanel → SSH Keys → Import Key" -ForegroundColor White
    Write-Host "2. Pegar tu clave SSH pública" -ForegroundColor White
    Write-Host "3. Autorizar la clave SSH" -ForegroundColor White
    Write-Host "4. Probar conexión SSH" -ForegroundColor White
    Write-Host "5. Subir archivos a public_html" -ForegroundColor White
    
    Write-Host ""
    Write-Host "🔑 TU CLAVE SSH PÚBLICA:" -ForegroundColor Green
    Write-Host $FIME_CONFIG.SSH_KEY_PUB -ForegroundColor Cyan
}

# Función para diagnosticar problemas
function Diagnose-Issues {
    Write-Host ""
    Write-Host "🔧 DIAGNÓSTICO DE PROBLEMAS" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "===========================" -ForegroundColor Yellow
    
    # Verificar PowerShell
    Write-Host "📋 Versión PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
    Write-Host "📋 Sistema operativo: $($PSVersionTable.OS)" -ForegroundColor Cyan
    Write-Host "📋 Directorio actual: $(Get-Location)" -ForegroundColor Cyan
    
    # Verificar permisos
    Write-Host ""
    Write-Host "🔐 Verificando permisos..." -ForegroundColor Yellow
    
    try {
        $policy = Get-ExecutionPolicy
        Write-Host "📋 Execution Policy: $policy" -ForegroundColor Cyan
        
        if ($policy -eq "Restricted") {
            Write-Host "⚠️ PROBLEMA: Execution Policy muy restrictiva" -ForegroundColor Yellow
            Write-Host "🔧 SOLUCIÓN: Ejecutar: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser" -ForegroundColor Green
        }
    } catch {
        Write-Host "❌ Error verificando Execution Policy: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Verificar red
    Write-Host ""
    Write-Host "🌐 Verificando conectividad de red..." -ForegroundColor Yellow
    
    try {
        $dnsTest = Resolve-DnsName "fimecompany.com" -ErrorAction Stop
        Write-Host "✅ DNS Resolution funciona para fimecompany.com" -ForegroundColor Green
        Write-Host "📋 IP: $($dnsTest[0].IPAddress)" -ForegroundColor Cyan
    } catch {
        Write-Host "❌ Error en DNS Resolution: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "📋 COMANDOS DISPONIBLES:" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Yellow
Write-Host "🔍 Verify-AllAutomation    # Verificación completa" -ForegroundColor White
Write-Host "📊 Generate-AutomationSummary # Resumen estado" -ForegroundColor White
Write-Host "🔧 Diagnose-Issues         # Diagnosticar problemas" -ForegroundColor White

Write-Host ""
Write-Host "🚀 EJECUTAR VERIFICACIÓN COMPLETA:" -ForegroundColor Green
Write-Host "Verify-AllAutomation" -ForegroundColor Yellow
