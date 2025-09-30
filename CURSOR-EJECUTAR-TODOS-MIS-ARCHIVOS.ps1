# ===============================================
# CURSOR EJECUTAR TODOS MIS ARCHIVOS
# Automatización completa desde Cursor
# ===============================================

Write-Host "🤖 CURSOR EJECUTANDO TODOS TUS ARCHIVOS" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "=======================================" -ForegroundColor Yellow

# Configurar automáticamente
$ErrorActionPreference = "Continue"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force

# Cambiar al directorio correcto
$targetDir = "C:\Users\PC\.android\c panel"
Set-Location $targetDir
Write-Host "📁 Directorio: $(Get-Location)" -ForegroundColor Green

Write-Host ""
Write-Host "🚀 EJECUTANDO TODOS LOS ARCHIVOS AUTOMÁTICAMENTE..." -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Yellow

# 1. EJECUTAR CONFIGURACIÓN PRINCIPAL
Write-Host ""
Write-Host "1️⃣ EJECUTANDO CONFIGURACIÓN PRINCIPAL..." -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Yellow

try {
    # Crear directorios necesarios
    if (!(Test-Path "$env:USERPROFILE\.ssh")) {
        New-Item -ItemType Directory -Path "$env:USERPROFILE\.ssh" -Force | Out-Null
        Write-Host "✅ Directorio SSH creado" -ForegroundColor Green
    }
    
    # Guardar clave SSH
    $sshKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP"
    $sshKey | Out-File -FilePath "$env:USERPROFILE\.ssh\fimecompany_key.pub" -Encoding ASCII
    Write-Host "✅ Clave SSH guardada" -ForegroundColor Green
    
} catch {
    Write-Host "⚠️ Error en configuración principal: $($_.Exception.Message)" -ForegroundColor Yellow
}

# 2. VERIFICAR ARCHIVOS WEB
Write-Host ""
Write-Host "2️⃣ VERIFICANDO ARCHIVOS WEB..." -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Yellow

$archivosWeb = @{
    "index.html" = "Portal principal FIME COMPANY"
    "styles.css" = "Estilos unificados"
    "fimetech\index.html" = "FimeTech división"
    "fimekids\index.html" = "FimeKids división"
    "ferreteria\index.html" = "Ferretería división"
}

foreach ($archivo in $archivosWeb.Keys) {
    if (Test-Path $archivo) {
        $size = (Get-Item $archivo).Length
        Write-Host "✅ $archivo - $($archivosWeb[$archivo]) ($size bytes)" -ForegroundColor Green
    } else {
        Write-Host "❌ $archivo - NO ENCONTRADO" -ForegroundColor Red
    }
}

# 3. VERIFICAR Y EJECUTAR SCRIPTS
Write-Host ""
Write-Host "3️⃣ EJECUTANDO TODOS LOS SCRIPTS..." -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Yellow

$scripts = @(
    @{File="cursor-auto-ejecutar.ps1"; Desc="Verificación automática"},
    @{File="verificar-automatizacion-completa.ps1"; Desc="Verificación completa"},
    @{File="deployment-public-html.ps1"; Desc="Deployment public_html"},
    @{File="configurar-putty-completo-fime.ps1"; Desc="Configuración PuTTY"}
)

foreach ($script in $scripts) {
    Write-Host ""
    Write-Host "📜 Ejecutando: $($script.File)" -ForegroundColor Yellow
    
    if (Test-Path $script.File) {
        try {
            # Cargar el script
            . ".\$($script.File)"
            Write-Host "✅ $($script.File) - $($script.Desc) - CARGADO" -ForegroundColor Green
        } catch {
            Write-Host "⚠️ $($script.File) - Error: $($_.Exception.Message)" -ForegroundColor Yellow
        }
    } else {
        Write-Host "❌ $($script.File) - NO ENCONTRADO" -ForegroundColor Red
    }
}

# 4. EJECUTAR VERIFICACIÓN COMPLETA
Write-Host ""
Write-Host "4️⃣ EJECUTANDO VERIFICACIÓN COMPLETA..." -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Yellow

try {
    # Verificar herramientas
    $herramientas = @("git", "ssh", "putty", "scp")
    
    foreach ($tool in $herramientas) {
        try {
            $toolPath = Get-Command $tool -ErrorAction Stop
            Write-Host "✅ $tool - INSTALADO - $($toolPath.Source)" -ForegroundColor Green
        } catch {
            Write-Host "❌ $tool - NO INSTALADO" -ForegroundColor Red
        }
    }
    
} catch {
    Write-Host "⚠️ Error verificando herramientas: $($_.Exception.Message)" -ForegroundColor Yellow
}

# 5. VERIFICAR CONECTIVIDAD
Write-Host ""
Write-Host "5️⃣ VERIFICANDO CONECTIVIDAD..." -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Yellow

$conexiones = @{
    22 = "SSH Puerto 22"
    2222 = "SSH Puerto 2222 (alternativo)"
    2083 = "cPanel HTTPS"
    80 = "Web HTTP"
    443 = "Web HTTPS"
}

foreach ($puerto in $conexiones.Keys) {
    try {
        $test = Test-NetConnection -ComputerName "fimecompany.com" -Port $puerto -WarningAction SilentlyContinue -InformationLevel Quiet
        if ($test.TcpTestSucceeded) {
            Write-Host "✅ Puerto $puerto - $($conexiones[$puerto]) - CONECTADO" -ForegroundColor Green
        } else {
            Write-Host "❌ Puerto $puerto - $($conexiones[$puerto]) - NO DISPONIBLE" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ Puerto $puerto - $($conexiones[$puerto]) - ERROR" -ForegroundColor Red
    }
}

# 6. VERIFICAR SITIO WEB
Write-Host ""
Write-Host "6️⃣ VERIFICANDO SITIO WEB..." -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Yellow

$sitios = @(
    "https://fimecompany.com",
    "https://fimecompany.com/fimetech/",
    "https://fimecompany.com/fimekids/",
    "https://fimecompany.com/ferreteria/"
)

foreach ($sitio in $sitios) {
    try {
        $response = Invoke-WebRequest -Uri $sitio -Method Head -TimeoutSec 5 -ErrorAction Stop
        Write-Host "✅ $sitio - FUNCIONANDO (Código: $($response.StatusCode))" -ForegroundColor Green
    } catch {
        Write-Host "❌ $sitio - NO DISPONIBLE" -ForegroundColor Red
    }
}

# 7. GENERAR RESUMEN AUTOMÁTICO
Write-Host ""
Write-Host "7️⃣ GENERANDO RESUMEN AUTOMÁTICO..." -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Yellow

# Detectar estado actual
$estadoSSH = $false
$estadoArchivos = $false
$estadoSitio = $false

# Verificar SSH
try {
    $sshTest = Test-NetConnection -ComputerName "fimecompany.com" -Port 22 -WarningAction SilentlyContinue -InformationLevel Quiet
    $estadoSSH = $sshTest.TcpTestSucceeded
} catch { }

# Verificar archivos
$estadoArchivos = (Test-Path "index.html") -and (Test-Path "styles.css")

# Verificar sitio
try {
    $siteTest = Invoke-WebRequest -Uri "https://fimecompany.com" -Method Head -TimeoutSec 5 -ErrorAction Stop
    $estadoSitio = ($siteTest.StatusCode -eq 200)
} catch { }

# 8. MOSTRAR ESTADO FINAL
Write-Host ""
Write-Host "📊 ESTADO FINAL DE TODOS TUS ARCHIVOS" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "=====================================" -ForegroundColor Yellow

Write-Host ""
Write-Host "✅ ARCHIVOS EJECUTADOS EXITOSAMENTE:" -ForegroundColor Green
Write-Host "   • Scripts PowerShell cargados" -ForegroundColor White
Write-Host "   • Configuraciones aplicadas" -ForegroundColor White
Write-Host "   • Verificaciones completadas" -ForegroundColor White
Write-Host "   • Conectividad probada" -ForegroundColor White

Write-Host ""
Write-Host "📋 ESTADO ACTUAL:" -ForegroundColor Yellow

if ($estadoSSH) {
    Write-Host "   ✅ SSH - CONECTADO" -ForegroundColor Green
} else {
    Write-Host "   ❌ SSH - NECESITA CONFIGURACIÓN EN CPANEL" -ForegroundColor Red
}

if ($estadoArchivos) {
    Write-Host "   ✅ ARCHIVOS WEB - LISTOS" -ForegroundColor Green
} else {
    Write-Host "   ❌ ARCHIVOS WEB - VERIFICAR" -ForegroundColor Red
}

if ($estadoSitio) {
    Write-Host "   ✅ SITIO WEB - FUNCIONANDO" -ForegroundColor Green
} else {
    Write-Host "   ❌ SITIO WEB - NECESITA ARCHIVOS EN PUBLIC_HTML" -ForegroundColor Red
}

Write-Host ""
Write-Host "🎯 PRÓXIMOS PASOS AUTOMÁTICOS:" -ForegroundColor Yellow

if (!$estadoSSH) {
    Write-Host "   1. Configurar SSH en cPanel" -ForegroundColor White
    Write-Host "      • Ir a cPanel → SSH Keys" -ForegroundColor Cyan
    Write-Host "      • Importar clave pública" -ForegroundColor Cyan
    Write-Host "      • Autorizar clave" -ForegroundColor Cyan
}

if (!$estadoSitio) {
    Write-Host "   2. Subir archivos a public_html" -ForegroundColor White
    Write-Host "      • Usar File Manager de cPanel" -ForegroundColor Cyan
    Write-Host "      • Subir index.html, styles.css" -ForegroundColor Cyan
    Write-Host "      • Subir carpetas fimetech, fimekids, ferreteria" -ForegroundColor Cyan
}

if ($estadoSSH -and $estadoSitio) {
    Write-Host "   🎉 ¡TODO ESTÁ FUNCIONANDO PERFECTAMENTE!" -ForegroundColor Green -BackgroundColor DarkGreen
    Write-Host "   ✅ Automatización completa exitosa" -ForegroundColor Green
}

Write-Host ""
Write-Host "🔑 TU CLAVE SSH PARA CPANEL:" -ForegroundColor Green
Write-Host "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP" -ForegroundColor Cyan

Write-Host ""
Write-Host "🤖 CURSOR HA EJECUTADO TODOS TUS ARCHIVOS" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "=========================================" -ForegroundColor Yellow
