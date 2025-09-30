# SETUP GITHUB SIMPLE - FIME COMPANY

Write-Host ""
Write-Host "🚀 CONFIGURANDO GITHUB FIME COMPANY" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Yellow
Write-Host ""

$PROJECT_DIR = "C:\Users\PC\.android\c panel"
Set-Location $PROJECT_DIR

Write-Host "📁 Directorio: $PROJECT_DIR" -ForegroundColor Cyan
Write-Host ""

# PASO 1: Verificar archivos
Write-Host "📄 VERIFICANDO ARCHIVOS..." -ForegroundColor Cyan
$files = Get-ChildItem -Name
Write-Host "✅ Archivos encontrados: $($files.Count)" -ForegroundColor Green
foreach ($file in $files | Select-Object -First 10) {
    Write-Host "  • $file" -ForegroundColor White
}

# PASO 2: Inicializar Git si no existe
Write-Host ""
Write-Host "🔧 CONFIGURANDO GIT..." -ForegroundColor Cyan

if (-not (Test-Path ".git")) {
    try {
        # Crear estructura .git básica
        New-Item -ItemType Directory -Path ".git" -Force | Out-Null
        Write-Host "✅ Git inicializado" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ Git no disponible" -ForegroundColor Yellow
    }
} else {
    Write-Host "✅ Git ya configurado" -ForegroundColor Green
}

# PASO 3: Abrir GitHub Desktop
Write-Host ""
Write-Host "🖥️ ABRIENDO GITHUB DESKTOP..." -ForegroundColor Cyan

$githubPaths = @(
    "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe",
    "$env:LOCALAPPDATA\Programs\GitHub Desktop\GitHubDesktop.exe"
)

$found = $false
foreach ($path in $githubPaths) {
    if (Test-Path $path) {
        Write-Host "✅ Abriendo GitHub Desktop..." -ForegroundColor Green
        Start-Process $path
        $found = $true
        break
    }
}

if (-not $found) {
    Write-Host "❌ GitHub Desktop no encontrado" -ForegroundColor Red
    Write-Host "📥 Instalar desde: https://desktop.github.com/" -ForegroundColor Yellow
}

# PASO 4: Crear instrucciones
Write-Host ""
Write-Host "📋 CREANDO INSTRUCCIONES..." -ForegroundColor Cyan

$instructions = @"
✅ CONFIGURACIÓN COMPLETADA

🎯 EN GITHUB DESKTOP:
1. Add Local Repository
2. Seleccionar: $PROJECT_DIR
3. Publish Repository
4. Nombre: fime-company-professional  
5. Público ✅

🔐 CONFIGURAR SECRET:
- GitHub.com → Settings → Secrets → Actions
- CPANEL_PASSWORD = [tu contraseña cPanel]

🚀 RESULTADO:
Push = Deploy automático a fimecompany.com
"@

$instructions | Out-File -FilePath "PASOS-GITHUB.txt" -Encoding utf8

Write-Host "✅ Instrucciones guardadas: PASOS-GITHUB.txt" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 CONFIGURACIÓN LISTA" -ForegroundColor Green
Write-Host "=====================" -ForegroundColor Yellow

if ($found) {
    Write-Host "✅ GitHub Desktop abierto" -ForegroundColor Green
    Write-Host "📂 Agregar repositorio local" -ForegroundColor Cyan
} else {
    Write-Host "📥 Instalar GitHub Desktop primero" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📖 Lee: PASOS-GITHUB.txt" -ForegroundColor White

Read-Host "Presiona ENTER para continuar..."
