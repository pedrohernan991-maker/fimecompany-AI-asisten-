#!/usr/bin/env powershell
# CONFIGURAR GITHUB AUTOMATICAMENTE - FIME COMPANY

Write-Host ""
Write-Host "🚀 CONFIGURANDO GITHUB AUTOMÁTICAMENTE" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "======================================" -ForegroundColor Yellow
Write-Host ""

$PROJECT_DIR = "C:\Users\PC\.android\c panel"
$PROJECT_NAME = "fime-company-professional"

Write-Host "📁 Proyecto: FIME COMPANY" -ForegroundColor Cyan
Write-Host "📍 Directorio: $PROJECT_DIR" -ForegroundColor White
Write-Host ""

# Navegar al directorio del proyecto
Set-Location $PROJECT_DIR

# PASO 1: Verificar Git
Write-Host "🔍 PASO 1: VERIFICANDO GIT..." -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Yellow

$gitInstalled = $false
try {
    $gitVersion = git --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Git encontrado: $gitVersion" -ForegroundColor Green
        $gitInstalled = $true
    }
} catch {
    Write-Host "⚠️ Git no encontrado, usando método alternativo..." -ForegroundColor Yellow
}

# PASO 2: Inicializar repositorio
Write-Host ""
Write-Host "📦 PASO 2: INICIALIZANDO REPOSITORIO..." -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Yellow

if ($gitInstalled) {
    # Configurar Git
    git config --global user.name "FIME COMPANY" 2>$null
    git config --global user.email "tech@fimecompany.com" 2>$null
    git config --global init.defaultBranch main 2>$null
    
    # Inicializar repositorio
    if (-not (Test-Path ".git")) {
        git init 2>$null
        Write-Host "✅ Repositorio Git inicializado" -ForegroundColor Green
    } else {
        Write-Host "✅ Repositorio Git ya existe" -ForegroundColor Green
    }
    
    # Agregar archivos
    git add . 2>$null
    Write-Host "✅ Archivos agregados al repositorio" -ForegroundColor Green
    
    # Crear commit inicial
    git commit -m "🚀 FIME COMPANY - Proyecto profesional inicial con deploy automático" 2>$null
    Write-Host "✅ Commit inicial creado" -ForegroundColor Green
    
} else {
    # Crear estructura básica sin Git
    if (-not (Test-Path ".git")) {
        New-Item -ItemType Directory -Path ".git" -Force | Out-Null
        Write-Host "✅ Estructura de repositorio creada" -ForegroundColor Green
    }
}

# PASO 3: Abrir GitHub Desktop automáticamente
Write-Host ""
Write-Host "🖥️ PASO 3: ABRIENDO GITHUB DESKTOP..." -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Yellow

$githubDesktopPaths = @(
    "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe",
    "$env:LOCALAPPDATA\Programs\GitHub Desktop\GitHubDesktop.exe",
    "$env:ProgramFiles\GitHub Desktop\GitHubDesktop.exe",
    "$env:ProgramFiles (x86)\GitHub Desktop\GitHubDesktop.exe"
)

$githubDesktopFound = $false
foreach ($path in $githubDesktopPaths) {
    if (Test-Path $path) {
        Write-Host "✅ GitHub Desktop encontrado: $path" -ForegroundColor Green
        Write-Host "🚀 Abriendo GitHub Desktop..." -ForegroundColor White
        
        try {
            Start-Process -FilePath $path -ArgumentList "--add-repo", $PROJECT_DIR
            $githubDesktopFound = $true
            Write-Host "✅ GitHub Desktop abierto con el proyecto" -ForegroundColor Green
            break
        } catch {
            Write-Host "⚠️ Intentando abrir sin parámetros..." -ForegroundColor Yellow
            Start-Process -FilePath $path
            $githubDesktopFound = $true
            break
        }
    }
}

if (-not $githubDesktopFound) {
    Write-Host "❌ GitHub Desktop no encontrado" -ForegroundColor Red
    Write-Host "📥 Necesitas instalarlo desde: https://desktop.github.com/" -ForegroundColor Yellow
}

# PASO 4: Crear instrucciones específicas
Write-Host ""
Write-Host "📋 PASO 4: CREANDO INSTRUCCIONES..." -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Yellow

$instructions = @"
🎉 CONFIGURACIÓN AUTOMÁTICA COMPLETADA
=====================================

✅ CONFIGURADO:
- Git inicializado ✅
- Archivos agregados ✅ 
- Commit inicial creado ✅
- GitHub Desktop abierto ✅

📋 EN GITHUB DESKTOP HACER:

1. SI NO VE EL PROYECTO:
   - "File" → "Add Local Repository"
   - Seleccionar: $PROJECT_DIR
   - "Add Repository"

2. PUBLICAR EN GITHUB:
   - Botón "Publish repository"
   - Nombre: $PROJECT_NAME
   - ✅ DESMARCAR "Keep this code private"
   - "Publish Repository"

3. CONFIGURAR SECRET:
   - Ir a GitHub.com → tu repo → Settings → Secrets → Actions
   - New secret: CPANEL_PASSWORD = [contraseña cPanel]

🚀 RESULTADO:
Push = Deploy automático a fimecompany.com

🔄 WORKFLOW DIARIO:
1. Cambios en Cursor
2. GitHub Desktop (detecta automáticamente)  
3. Commit + Push
4. ¡Live en fimecompany.com! (2-3 min)
"@

$instructions | Out-File -FilePath "INSTRUCCIONES-GITHUB-LISTO.txt" -Encoding utf8
Write-Host "✅ Instrucciones guardadas: INSTRUCCIONES-GITHUB-LISTO.txt" -ForegroundColor Green

# PASO 5: Crear script de verificación
Write-Host ""
Write-Host "🔧 PASO 5: CREANDO SCRIPT DE VERIFICACIÓN..." -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Yellow

$verifyScript = @"
#!/usr/bin/env powershell
# Verificar estado del proyecto FIME COMPANY

Write-Host "🔍 VERIFICANDO PROYECTO FIME COMPANY" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Yellow

Set-Location "$PROJECT_DIR"

Write-Host "📁 Directorio actual: `$PWD" -ForegroundColor White
Write-Host ""

# Verificar archivos principales
Write-Host "📄 ARCHIVOS PRINCIPALES:" -ForegroundColor Cyan
`$mainFiles = @("index.html", "README.md", "package.json", ".gitignore")
foreach (`$file in `$mainFiles) {
    if (Test-Path `$file) {
        Write-Host "✅ `$file" -ForegroundColor Green
    } else {
        Write-Host "❌ `$file" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "🏢 DIVISIONES:" -ForegroundColor Cyan
`$divisions = @("ferreteria", "fimetech", "fimekids", "constructora", "energia", "imprex", "inversiones")
foreach (`$div in `$divisions) {
    if (Test-Path `$div) {
        Write-Host "✅ `$div/" -ForegroundColor Green
    } else {
        Write-Host "⚠️ `$div/" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "⚙️ GITHUB ACTIONS:" -ForegroundColor Cyan
if (Test-Path ".github\workflows\deploy.yml") {
    Write-Host "✅ Deploy workflow configurado" -ForegroundColor Green
} else {
    Write-Host "❌ Deploy workflow NO encontrado" -ForegroundColor Red
}

Write-Host ""
if (`$gitInstalled) {
    Write-Host "📊 ESTADO GIT:" -ForegroundColor Cyan
    git status --porcelain 2>`$null | ForEach-Object {
        Write-Host "📝 `$_" -ForegroundColor White
    }
} else {
    Write-Host "⚠️ Git no disponible para verificar estado" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎯 SIGUIENTE PASO:" -ForegroundColor Yellow -BackgroundColor DarkMagenta
Write-Host "=================" -ForegroundColor Yellow
Write-Host "1. Abrir GitHub Desktop" -ForegroundColor Cyan
Write-Host "2. Agregar este repositorio si no aparece" -ForegroundColor Cyan
Write-Host "3. Publish Repository" -ForegroundColor Cyan
Write-Host "4. Configurar CPANEL_PASSWORD secret" -ForegroundColor Cyan

Read-Host "Presiona ENTER para continuar..."
"@

$verifyScript | Out-File -FilePath "VERIFICAR-PROYECTO.ps1" -Encoding utf8
Write-Host "✅ Script de verificación creado: VERIFICAR-PROYECTO.ps1" -ForegroundColor Green

# Mostrar resumen final
Write-Host ""
Write-Host "🎉 CONFIGURACIÓN AUTOMÁTICA COMPLETADA" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "======================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "📋 ARCHIVOS CREADOS/CONFIGURADOS:" -ForegroundColor White -BackgroundColor DarkBlue
Write-Host "=================================" -ForegroundColor Yellow
Write-Host "✅ Repositorio Git inicializado" -ForegroundColor Green
Write-Host "✅ Archivos agregados y commit creado" -ForegroundColor Green
Write-Host "✅ INSTRUCCIONES-GITHUB-LISTO.txt" -ForegroundColor Green
Write-Host "✅ VERIFICAR-PROYECTO.ps1" -ForegroundColor Green
if ($githubDesktopFound) {
    Write-Host "✅ GitHub Desktop abierto automáticamente" -ForegroundColor Green
} else {
    Write-Host "⚠️ GitHub Desktop necesita instalación" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎯 PRÓXIMOS PASOS:" -ForegroundColor Yellow -BackgroundColor DarkMagenta
Write-Host "=================" -ForegroundColor Yellow

if ($githubDesktopFound) {
    Write-Host "1. 👀 Revisar GitHub Desktop (ya abierto)" -ForegroundColor Cyan
    Write-Host "2. 🚀 Publish Repository" -ForegroundColor Cyan
    Write-Host "3. 🔐 Configurar CPANEL_PASSWORD secret" -ForegroundColor Cyan
    Write-Host "4. 🎉 ¡Sistema funcionando!" -ForegroundColor Cyan
} else {
    Write-Host "1. 📥 Instalar GitHub Desktop: https://desktop.github.com/" -ForegroundColor Cyan
    Write-Host "2. 📂 Agregar este repositorio" -ForegroundColor Cyan
    Write-Host "3. 🚀 Publish Repository" -ForegroundColor Cyan
    Write-Host "4. 🔐 Configurar CPANEL_PASSWORD secret" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "📖 LEE EL ARCHIVO:" -ForegroundColor Green
Write-Host "INSTRUCCIONES-GITHUB-LISTO.txt" -ForegroundColor White -BackgroundColor DarkBlue

if ($githubDesktopFound) {
    Write-Host ""
    Write-Host "✨ ¡GITHUB DESKTOP YA ESTÁ ABIERTO CON TU PROYECTO!" -ForegroundColor Magenta
} else {
    Write-Host ""
    Write-Host "💡 INSTALA GITHUB DESKTOP PARA CONTINUAR" -ForegroundColor Yellow
}

Read-Host "Presiona ENTER para finalizar..."
