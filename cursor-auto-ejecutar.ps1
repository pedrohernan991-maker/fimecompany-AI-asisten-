# ===============================================
# CURSOR AUTO-EJECUTAR - AUTOMATIZACIÓN TOTAL
# Hacer que Cursor ejecute TODO automáticamente
# ===============================================

Write-Host "🤖 CURSOR AUTO-EJECUTAR - AUTOMATIZACIÓN TOTAL" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "===============================================" -ForegroundColor Yellow

# Auto-ejecutar verificación completa
Write-Host "🚀 Ejecutando verificación automática..." -ForegroundColor Green
Write-Host ""

# Cambiar al directorio correcto automáticamente
$targetDir = "C:\Users\PC\.android\c panel"
Set-Location $targetDir
Write-Host "📁 Directorio actual: $(Get-Location)" -ForegroundColor Cyan

# Verificar archivos automáticamente
Write-Host ""
Write-Host "📋 1. VERIFICANDO ARCHIVOS AUTOMÁTICAMENTE..." -ForegroundColor Green

$archivos = @{
    "index.html" = "Portal principal"
    "styles.css" = "Estilos"
    "fimetech\index.html" = "FimeTech"
    "fimekids\index.html" = "FimeKids"
    "ferreteria\index.html" = "Ferretería"
}

foreach ($archivo in $archivos.Keys) {
    if (Test-Path $archivo) {
        Write-Host "   ✅ $archivo - $($archivos[$archivo])" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $archivo - FALTA" -ForegroundColor Red
    }
}

# Verificar scripts automáticamente
Write-Host ""
Write-Host "📜 2. VERIFICANDO SCRIPTS AUTOMÁTICAMENTE..." -ForegroundColor Green

$scripts = @(
    "verificar-automatizacion-completa.ps1",
    "deployment-public-html.ps1",
    "configurar-putty-completo-fime.ps1"
)

foreach ($script in $scripts) {
    if (Test-Path $script) {
        Write-Host "   ✅ $script - LISTO" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $script - FALTA" -ForegroundColor Red
    }
}

# Verificar herramientas automáticamente
Write-Host ""
Write-Host "🛠️ 3. VERIFICANDO HERRAMIENTAS AUTOMÁTICAMENTE..." -ForegroundColor Green

$herramientas = @("git", "ssh", "putty", "scp")

foreach ($tool in $herramientas) {
    try {
        $toolPath = Get-Command $tool -ErrorAction Stop
        Write-Host "   ✅ $tool - INSTALADO" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ $tool - NO INSTALADO" -ForegroundColor Red
    }
}

# Verificar conectividad automáticamente
Write-Host ""
Write-Host "🌐 4. VERIFICANDO CONECTIVIDAD AUTOMÁTICAMENTE..." -ForegroundColor Green

$conexiones = @{
    22 = "SSH Puerto 22"
    2222 = "SSH Puerto 2222"
    2083 = "cPanel"
    80 = "Web HTTP"
    443 = "Web HTTPS"
}

foreach ($puerto in $conexiones.Keys) {
    try {
        $test = Test-NetConnection -ComputerName "fimecompany.com" -Port $puerto -WarningAction SilentlyContinue -InformationLevel Quiet
        if ($test.TcpTestSucceeded) {
            Write-Host "   ✅ Puerto $puerto - $($conexiones[$puerto]) - CONECTADO" -ForegroundColor Green
        } else {
            Write-Host "   ❌ Puerto $puerto - $($conexiones[$puerto]) - NO DISPONIBLE" -ForegroundColor Red
        }
    } catch {
        Write-Host "   ❌ Puerto $puerto - $($conexiones[$puerto]) - ERROR" -ForegroundColor Red
    }
}

# Verificar sitio web automáticamente
Write-Host ""
Write-Host "🌐 5. VERIFICANDO SITIO WEB AUTOMÁTICAMENTE..." -ForegroundColor Green

$sitios = @(
    "https://fimecompany.com",
    "https://fimecompany.com/fimetech/",
    "https://fimecompany.com/fimekids/",
    "https://fimecompany.com/ferreteria/"
)

foreach ($sitio in $sitios) {
    try {
        $response = Invoke-WebRequest -Uri $sitio -Method Head -TimeoutSec 5 -ErrorAction Stop
        Write-Host "   ✅ $sitio - FUNCIONANDO" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ $sitio - NO DISPONIBLE" -ForegroundColor Red
    }
}

# RESUMEN AUTOMÁTICO
Write-Host ""
Write-Host "📊 RESUMEN AUTOMÁTICO COMPLETADO" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "================================" -ForegroundColor Yellow

# Auto-detectar qué falta
$faltaSSH = $false
$faltaArchivos = $false
$faltaSitio = $false

# Verificar SSH
try {
    $sshTest = Test-NetConnection -ComputerName "fimecompany.com" -Port 22 -WarningAction SilentlyContinue -InformationLevel Quiet
    if (!$sshTest.TcpTestSucceeded) {
        $faltaSSH = $true
    }
} catch {
    $faltaSSH = $true
}

# Verificar archivos
if (!(Test-Path "index.html") -or !(Test-Path "styles.css")) {
    $faltaArchivos = $true
}

# Verificar sitio
try {
    $siteTest = Invoke-WebRequest -Uri "https://fimecompany.com" -Method Head -TimeoutSec 5 -ErrorAction Stop
    if ($siteTest.StatusCode -ne 200) {
        $faltaSitio = $true
    }
} catch {
    $faltaSitio = $true
}

# Mostrar próximos pasos automáticamente
Write-Host ""
Write-Host "🎯 PRÓXIMOS PASOS AUTOMÁTICOS:" -ForegroundColor Yellow

if ($faltaSSH) {
    Write-Host "1️⃣ CONFIGURAR SSH:" -ForegroundColor Red
    Write-Host "   • Ir a cPanel → SSH Keys" -ForegroundColor White
    Write-Host "   • Importar clave SSH pública" -ForegroundColor White
    Write-Host "   • Autorizar clave SSH" -ForegroundColor White
}

if ($faltaArchivos -or $faltaSitio) {
    Write-Host "2️⃣ SUBIR ARCHIVOS:" -ForegroundColor Red
    Write-Host "   • Usar File Manager de cPanel" -ForegroundColor White
    Write-Host "   • Subir a carpeta public_html/" -ForegroundColor White
    Write-Host "   • Configurar permisos 755/644" -ForegroundColor White
}

if (!$faltaSSH -and !$faltaArchivos -and !$faltaSitio) {
    Write-Host "🎉 ¡TODO ESTÁ FUNCIONANDO PERFECTO!" -ForegroundColor Green -BackgroundColor DarkGreen
    Write-Host "✅ SSH configurado" -ForegroundColor Green
    Write-Host "✅ Archivos subidos" -ForegroundColor Green
    Write-Host "✅ Sitio web funcionando" -ForegroundColor Green
}

Write-Host ""
Write-Host "🔑 TU CLAVE SSH PARA COPIAR:" -ForegroundColor Green
Write-Host "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP" -ForegroundColor Cyan

Write-Host ""
Write-Host "🤖 CURSOR AUTO-EJECUTAR COMPLETADO" -ForegroundColor Green -BackgroundColor DarkGreen
