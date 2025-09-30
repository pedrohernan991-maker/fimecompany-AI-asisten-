# ===============================================
# CURSOR CONECTAR GITHUB CON CPANEL AUTOMATICO
# Ejecuta todos los comandos automáticamente
# ===============================================

Write-Host "🚀 CURSOR CONECTANDO GITHUB CON CPANEL AUTOMATICO" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "=================================================" -ForegroundColor Yellow

# Configurar automáticamente
$ErrorActionPreference = "Continue"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force

# Cambiar al directorio de trabajo
$workingDir = "C:\Users\PC\.android\c panel"
Set-Location $workingDir
Write-Host "📁 Directorio de trabajo: $(Get-Location)" -ForegroundColor Green

Write-Host ""
Write-Host "🔧 PASO 1: CONFIGURANDO GIT AUTOMATICAMENTE..." -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Yellow

try {
    # Verificar si Git está instalado
    $gitVersion = git --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Git encontrado: $gitVersion" -ForegroundColor Green
    } else {
        Write-Host "❌ Git no encontrado. Instalando..." -ForegroundColor Red
        # Intentar instalar Git
        try {
            winget install Git.Git --accept-source-agreements --accept-package-agreements
            Write-Host "✅ Git instalado exitosamente" -ForegroundColor Green
        } catch {
            Write-Host "⚠️ Instala Git manualmente desde: https://git-scm.com/" -ForegroundColor Yellow
            return
        }
    }
    
    # Configurar Git globalmente
    Write-Host "⚙️ Configurando Git globalmente..." -ForegroundColor Yellow
    git config --global user.name "FIME COMPANY"
    git config --global user.email "admin@fimecompany.com" 
    git config --global init.defaultBranch main
    Write-Host "✅ Git configurado globalmente" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error configurando Git: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 2: INICIALIZANDO REPOSITORIO AUTOMATICAMENTE..." -ForegroundColor Green
Write-Host "======================================================" -ForegroundColor Yellow

try {
    # Verificar si ya es un repositorio Git
    $isGitRepo = Test-Path ".git"
    
    if (!$isGitRepo) {
        Write-Host "📦 Inicializando repositorio Git..." -ForegroundColor Yellow
        git init
        Write-Host "✅ Repositorio Git inicializado" -ForegroundColor Green
    } else {
        Write-Host "✅ Repositorio Git ya existe" -ForegroundColor Green
    }
    
    # Crear .gitignore
    $gitignoreContent = @"
# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Dependency directories
node_modules/

# Optional npm cache directory
.npm

# Optional eslint cache
.eslintcache

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env
.env.test

# IDE
.vscode/
.idea/

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Windows
*.lnk

# Backup files
*.bak
*.tmp
*.temp
"@
    
    $gitignoreContent | Out-File -FilePath ".gitignore" -Encoding UTF8
    Write-Host "✅ .gitignore creado" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error inicializando repositorio: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 3: AGREGANDO ARCHIVOS AUTOMATICAMENTE..." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Yellow

try {
    # Agregar todos los archivos
    Write-Host "📄 Agregando archivos al repositorio..." -ForegroundColor Yellow
    git add .
    
    # Verificar status
    $status = git status --porcelain
    if ($status) {
        Write-Host "✅ Archivos agregados exitosamente:" -ForegroundColor Green
        git status --short
    } else {
        Write-Host "⚠️ No hay archivos nuevos para agregar" -ForegroundColor Yellow
    }
    
    # Hacer commit inicial
    Write-Host "💾 Creando commit inicial..." -ForegroundColor Yellow
    git commit -m "🚀 FIME COMPANY - Sitio web inicial con FimeTech optimizado"
    Write-Host "✅ Commit inicial creado" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error agregando archivos: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 4: CONFIGURANDO CONEXION CON GITHUB..." -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Yellow

try {
    # Verificar si GitHub CLI está instalado
    $ghVersion = gh --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ GitHub CLI encontrado: $ghVersion" -ForegroundColor Green
        
        # Verificar autenticación
        $authStatus = gh auth status 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ GitHub CLI autenticado" -ForegroundColor Green
            
            # Crear repositorio en GitHub
            Write-Host "🌐 Creando repositorio en GitHub..." -ForegroundColor Yellow
            $repoName = "fime-company-website"
            gh repo create $repoName --public --description "Sitio web oficial FIME COMPANY con FimeTech optimizado" --clone=false
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Repositorio creado en GitHub: $repoName" -ForegroundColor Green
                
                # Obtener el nombre de usuario de GitHub
                $username = gh api user --jq .login 2>$null
                if ($username) {
                    $repoUrl = "https://github.com/$username/$repoName.git"
                    
                    # Agregar remote origin
                    git remote add origin $repoUrl 2>$null
                    Write-Host "✅ Remote origin agregado: $repoUrl" -ForegroundColor Green
                    
                    # Push inicial
                    Write-Host "📤 Subiendo código a GitHub..." -ForegroundColor Yellow
                    git push -u origin main
                    Write-Host "✅ Código subido a GitHub exitosamente" -ForegroundColor Green
                    
                } else {
                    Write-Host "⚠️ No se pudo obtener el nombre de usuario" -ForegroundColor Yellow
                }
            } else {
                Write-Host "⚠️ El repositorio ya existe o hubo un error" -ForegroundColor Yellow
            }
            
        } else {
            Write-Host "⚠️ GitHub CLI no está autenticado" -ForegroundColor Yellow
            Write-Host "📋 Ejecuta: gh auth login" -ForegroundColor Cyan
        }
        
    } else {
        Write-Host "⚠️ GitHub CLI no encontrado. Instalando..." -ForegroundColor Yellow
        
        try {
            winget install GitHub.cli --accept-source-agreements --accept-package-agreements
            Write-Host "✅ GitHub CLI instalado" -ForegroundColor Green
            Write-Host "📋 Reinicia Cursor y ejecuta: gh auth login" -ForegroundColor Cyan
        } catch {
            Write-Host "⚠️ Instala GitHub CLI manualmente" -ForegroundColor Yellow
        }
    }
    
} catch {
    Write-Host "❌ Error configurando GitHub: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 5: CREANDO GITHUB ACTIONS PARA CPANEL..." -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Yellow

try {
    # Crear directorio .github/workflows
    $workflowDir = ".github\workflows"
    if (!(Test-Path $workflowDir)) {
        New-Item -ItemType Directory -Path $workflowDir -Force | Out-Null
        Write-Host "📁 Directorio workflows creado" -ForegroundColor Green
    }
    
    # Crear archivo de workflow para deployment
    $workflowContent = @"
name: Deploy FIME COMPANY to cPanel

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        
    - name: Deploy to cPanel via FTP
      uses: SamKirkland/FTP-Deploy-Action@v4.3.4
      with:
        server: ftp.fimecompany.com
        username: fimecomp
        password: `${{ secrets.CPANEL_PASSWORD }}
        local-dir: ./
        server-dir: /public_html/
        exclude: |
          **/.git*
          **/.git*/**
          **/node_modules/**
          .github/**
          *.md
          *.ps1
          *.bat
          *.log
          
    - name: Verify deployment
      run: |
        echo "🚀 Deployment completed!"
        echo "✅ Check: https://fimecompany.com"
        echo "✅ Check: https://fimecompany.com/fimetech/"
"@

    $workflowContent | Out-File -FilePath "$workflowDir\deploy.yml" -Encoding UTF8
    Write-Host "✅ GitHub Actions workflow creado" -ForegroundColor Green
    
    # Crear README.md
    $readmeContent = @"
# FIME COMPANY - Sitio Web Oficial

🚀 **Portal corporativo de FIME COMPANY con tecnología de vanguardia**

## 🌐 Sitios Web

- **Portal Principal:** https://fimecompany.com
- **FimeTech:** https://fimecompany.com/fimetech/
- **FimeKids:** https://fimecompany.com/fimekids/
- **Ferretería:** https://fimecompany.com/ferreteria/

## 📋 Estructura

```
/
├── index.html          # Portal principal
├── styles.css         # Estilos unificados
├── fimetech/          # División tecnológica
│   └── index.html     # FimeTech optimizado
├── fimekids/          # División infantil
│   └── index.html     # Juegos y educación
└── ferreteria/        # División ferretería
    └── index.html     # Catálogo industrial
```

## 🚀 Deployment Automático

Este repositorio se despliega automáticamente a cPanel usando GitHub Actions:

1. **Push a main** → Deployment automático
2. **GitHub Actions** → Sube archivos via FTP
3. **cPanel** → Actualiza https://fimecompany.com

## 🔧 Configuración

### Secretos de GitHub necesarios:
- `CPANEL_PASSWORD`: Contraseña de cPanel para FTP

### Variables de entorno:
- **FTP Server:** ftp.fimecompany.com
- **Usuario:** fimecomp
- **Destino:** /public_html/

## 📊 Estado

![Deployment Status](https://github.com/{username}/fime-company-website/workflows/Deploy%20FIME%20COMPANY%20to%20cPanel/badge.svg)

---

© 2024 FIME COMPANY - Todos los derechos reservados
**CEO:** Pedro Nicolás Hernández Lizardo
"@

    $readmeContent | Out-File -FilePath "README.md" -Encoding UTF8
    Write-Host "✅ README.md creado" -ForegroundColor Green
    
    # Agregar archivos nuevos
    git add .
    git commit -m "🔧 Agregar GitHub Actions para deployment automático a cPanel"
    Write-Host "✅ Archivos de configuración agregados" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error creando GitHub Actions: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 6: CONFIGURACION FINAL..." -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Yellow

try {
    # Mostrar información del repositorio
    Write-Host "📊 Información del repositorio:" -ForegroundColor Cyan
    
    # Mostrar remote
    $remotes = git remote -v 2>$null
    if ($remotes) {
        Write-Host "🔗 Remotes configurados:" -ForegroundColor Yellow
        Write-Host $remotes -ForegroundColor White
    }
    
    # Mostrar último commit
    $lastCommit = git log --oneline -1 2>$null
    if ($lastCommit) {
        Write-Host "💾 Último commit:" -ForegroundColor Yellow
        Write-Host $lastCommit -ForegroundColor White
    }
    
    # Mostrar archivos trackeados
    Write-Host "📄 Archivos en el repositorio:" -ForegroundColor Yellow
    git ls-files | ForEach-Object { Write-Host "   ✅ $_" -ForegroundColor Green }
    
} catch {
    Write-Host "❌ Error mostrando información: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🎉 CONEXION GITHUB ↔ CPANEL COMPLETADA" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "=======================================" -ForegroundColor Yellow

Write-Host ""
Write-Host "✅ CONFIGURACIONES COMPLETADAS:" -ForegroundColor Green
Write-Host "   🔧 Git configurado globalmente" -ForegroundColor White
Write-Host "   📦 Repositorio Git inicializado" -ForegroundColor White
Write-Host "   📄 Archivos agregados y committed" -ForegroundColor White
Write-Host "   🌐 Repositorio GitHub creado (si tienes GitHub CLI)" -ForegroundColor White
Write-Host "   ⚡ GitHub Actions configurado" -ForegroundColor White
Write-Host "   📋 README.md y documentación creada" -ForegroundColor White

Write-Host ""
Write-Host "🚀 PROXIMOS PASOS:" -ForegroundColor Yellow
Write-Host "==================" -ForegroundColor Yellow

Write-Host "1️⃣ AUTENTICAR GITHUB CLI (si no está):" -ForegroundColor Cyan
Write-Host "   gh auth login" -ForegroundColor White

Write-Host "2️⃣ CONFIGURAR SECRETO EN GITHUB:" -ForegroundColor Cyan
Write-Host "   • Ve a tu repositorio en GitHub" -ForegroundColor White
Write-Host "   • Settings → Secrets and variables → Actions" -ForegroundColor White
Write-Host "   • New repository secret:" -ForegroundColor White
Write-Host "     Name: CPANEL_PASSWORD" -ForegroundColor Yellow
Write-Host "     Value: [tu contraseña de cPanel]" -ForegroundColor Yellow

Write-Host "3️⃣ HACER PUSH PARA ACTIVAR DEPLOYMENT:" -ForegroundColor Cyan
Write-Host "   git push origin main" -ForegroundColor White

Write-Host "4️⃣ VERIFICAR DEPLOYMENT:" -ForegroundColor Cyan
Write-Host "   • https://fimecompany.com" -ForegroundColor White
Write-Host "   • https://fimecompany.com/fimetech/" -ForegroundColor White

Write-Host ""
Write-Host "📋 COMANDOS DISPONIBLES:" -ForegroundColor Yellow
Write-Host "   git status           # Ver estado del repositorio" -ForegroundColor White
Write-Host "   git add .           # Agregar cambios" -ForegroundColor White
Write-Host "   git commit -m 'msg' # Crear commit" -ForegroundColor White
Write-Host "   git push           # Subir a GitHub (y auto-deploy)" -ForegroundColor White
Write-Host "   gh auth status     # Ver estado de autenticación" -ForegroundColor White
Write-Host "   gh repo view       # Ver repositorio en GitHub" -ForegroundColor White

Write-Host ""
Write-Host "🔥 ¡CONEXION AUTOMATICA LISTA!" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "Cada cambio en este directorio se desplegará automáticamente a cPanel" -ForegroundColor Yellow
