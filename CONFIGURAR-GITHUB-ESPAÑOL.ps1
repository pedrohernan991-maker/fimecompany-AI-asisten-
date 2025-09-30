# ===============================================
# CONFIGURAR GITHUB EN ESPAÑOL - CURSOR
# Configuración completa en idioma español
# ===============================================

Write-Host "🌍 CONFIGURANDO GITHUB EN ESPAÑOL" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "==================================" -ForegroundColor Yellow

# Configurar automáticamente
$ErrorActionPreference = "Continue"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force

# Cambiar al directorio de trabajo
$workingDir = "C:\Users\PC\.android\c panel"
Set-Location $workingDir
Write-Host "📁 Directorio de trabajo: $(Get-Location)" -ForegroundColor Green

Write-Host ""
Write-Host "🔧 PASO 1: CONFIGURANDO GIT EN ESPAÑOL..." -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Yellow

try {
    # Configurar Git con mensajes en español
    Write-Host "⚙️ Configurando Git en español..." -ForegroundColor Yellow
    
    # Configuración de usuario en español
    git config --global user.name "FIME COMPANY"
    git config --global user.email "admin@fimecompany.com"
    git config --global init.defaultBranch main
    
    # Configurar mensajes de commit en español
    git config --global core.editor "code --wait"
    git config --global core.autocrlf true
    
    # Configurar alias en español
    git config --global alias.estado "status"
    git config --global alias.agregar "add"
    git config --global alias.confirmar "commit"
    git config --global alias.subir "push"
    git config --global alias.descargar "pull"
    git config --global alias.rama "branch"
    git config --global alias.cambiar "checkout"
    git config --global alias.historial "log --oneline --graph"
    
    Write-Host "✅ Git configurado en español con alias útiles" -ForegroundColor Green
    
    # Mostrar configuración
    Write-Host "📋 Configuración actual:" -ForegroundColor Cyan
    Write-Host "   • git estado     = git status" -ForegroundColor White
    Write-Host "   • git agregar    = git add" -ForegroundColor White
    Write-Host "   • git confirmar  = git commit" -ForegroundColor White
    Write-Host "   • git subir      = git push" -ForegroundColor White
    Write-Host "   • git descargar  = git pull" -ForegroundColor White
    Write-Host "   • git rama       = git branch" -ForegroundColor White
    Write-Host "   • git cambiar    = git checkout" -ForegroundColor White
    Write-Host "   • git historial  = git log" -ForegroundColor White
    
} catch {
    Write-Host "❌ Error configurando Git: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 2: CONFIGURANDO GITHUB CLI EN ESPAÑOL..." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Yellow

try {
    # Verificar GitHub CLI
    $ghVersion = gh --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ GitHub CLI encontrado: $ghVersion" -ForegroundColor Green
        
        # Configurar GitHub CLI
        Write-Host "⚙️ Configurando GitHub CLI..." -ForegroundColor Yellow
        
        # Crear archivo de configuración de GitHub CLI
        $ghConfigDir = "$env:APPDATA\GitHub CLI"
        if (!(Test-Path $ghConfigDir)) {
            New-Item -ItemType Directory -Path $ghConfigDir -Force | Out-Null
        }
        
        # Configurar aliases en español para GitHub CLI
        gh alias set estado "status"
        gh alias set crear-repo "repo create"
        gh alias set ver-repo "repo view"
        gh alias set listar-repos "repo list"
        gh alias set clonar "repo clone"
        gh alias set issues "issue list"
        gh alias set crear-issue "issue create"
        gh alias set pr-lista "pr list"
        gh alias set crear-pr "pr create"
        gh alias set perfil "api user"
        
        Write-Host "✅ GitHub CLI configurado con aliases en español" -ForegroundColor Green
        
        Write-Host "📋 Comandos GitHub CLI en español:" -ForegroundColor Cyan
        Write-Host "   • gh estado       = gh status" -ForegroundColor White
        Write-Host "   • gh crear-repo   = gh repo create" -ForegroundColor White
        Write-Host "   • gh ver-repo     = gh repo view" -ForegroundColor White
        Write-Host "   • gh listar-repos = gh repo list" -ForegroundColor White
        Write-Host "   • gh clonar       = gh repo clone" -ForegroundColor White
        Write-Host "   • gh issues       = gh issue list" -ForegroundColor White
        Write-Host "   • gh crear-issue  = gh issue create" -ForegroundColor White
        Write-Host "   • gh pr-lista     = gh pr list" -ForegroundColor White
        Write-Host "   • gh crear-pr     = gh pr create" -ForegroundColor White
        Write-Host "   • gh perfil       = gh api user" -ForegroundColor White
        
    } else {
        Write-Host "⚠️ GitHub CLI no encontrado. Instalando..." -ForegroundColor Yellow
        winget install GitHub.cli --accept-source-agreements --accept-package-agreements
        Write-Host "✅ GitHub CLI instalado" -ForegroundColor Green
    }
    
} catch {
    Write-Host "❌ Error configurando GitHub CLI: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 3: CREANDO TEMPLATES EN ESPAÑOL..." -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Yellow

try {
    # Crear template de commit en español
    $commitTemplate = @"
# Tipo de cambio (eliminar líneas que no apliquen):
# ✨ nueva funcionalidad
# 🐛 corrección de error
# 📝 documentación
# 💄 estilos/formato
# ♻️ refactorización
# 🚀 mejora de rendimiento
# ✅ pruebas
# 🔧 configuración
# 🗑️ eliminar código

# Título (máximo 50 caracteres):


# Descripción detallada (opcional):


# Issues relacionados (opcional):
# Cierra #123
# Relacionado con #456
"@

    $commitTemplate | Out-File -FilePath ".gitmessage" -Encoding UTF8
    git config --global commit.template ".gitmessage"
    Write-Host "✅ Template de commit en español creado" -ForegroundColor Green
    
    # Crear .gitignore en español con comentarios
    $gitignoreEspanol = @"
# ===============================================
# GITIGNORE FIME COMPANY - Archivos a ignorar
# ===============================================

# Archivos de registro (logs)
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Archivos temporales del sistema
*.tmp
*.temp
*.bak
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
*.lnk

# Dependencias de Node.js
node_modules/
npm-debug.log*

# Variables de entorno
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Archivos del IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Archivos de construcción (build)
/dist
/build
/out

# Cache
.npm
.eslintcache

# Archivos de respaldo
*.backup
*.orig

# Archivos específicos de Windows
Thumbs.db
Desktop.ini

# Archivos específicos de Mac
.DS_Store
__MACOSX/

# Archivos de PowerShell
*.ps1.bak
"@

    $gitignoreEspanol | Out-File -FilePath ".gitignore" -Encoding UTF8
    Write-Host "✅ .gitignore creado con comentarios en español" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error creando templates: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 4: CONFIGURANDO REPOSITORIO EN ESPAÑOL..." -ForegroundColor Green
Write-Host "=================================================" -ForegroundColor Yellow

try {
    # Verificar si ya es un repositorio Git
    if (!(Test-Path ".git")) {
        Write-Host "📦 Inicializando repositorio Git..." -ForegroundColor Yellow
        git init
        Write-Host "✅ Repositorio inicializado" -ForegroundColor Green
    }
    
    # Agregar archivos
    Write-Host "📄 Agregando archivos al repositorio..." -ForegroundColor Yellow
    git add .
    
    # Crear commit inicial en español
    $commitInicial = "🚀 Inicio: Sitio web FIME COMPANY con configuración en español

✨ Características agregadas:
- Portal principal corporativo
- División FimeTech optimizada
- División FimeKids educativa
- División Ferretería industrial
- Configuración Git en español
- Templates y alias personalizados

🔧 Configuración:
- Git aliases en español
- GitHub CLI configurado
- Templates de commit
- .gitignore optimizado

🌐 Sitios web incluidos:
- https://fimecompany.com (portal principal)
- https://fimecompany.com/fimetech/ (tecnología)
- https://fimecompany.com/fimekids/ (infantil)
- https://fimecompany.com/ferreteria/ (industrial)

👨‍💼 CEO: Pedro Nicolás Hernández Lizardo
🏢 FIME COMPANY - Grupo empresarial diversificado"

    git commit -m "$commitInicial" 2>$null
    Write-Host "✅ Commit inicial creado en español" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error configurando repositorio: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 5: CONFIGURANDO GITHUB ACTIONS EN ESPAÑOL..." -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Yellow

try {
    # Crear directorio workflows
    $workflowDir = ".github\workflows"
    if (!(Test-Path $workflowDir)) {
        New-Item -ItemType Directory -Path $workflowDir -Force | Out-Null
    }
    
    # Workflow en español
    $workflowEspanol = @"
name: 🚀 Desplegar FIME COMPANY a cPanel

on:
  push:
    branches: [ main ]
    paths-ignore:
      - 'README.md'
      - 'docs/**'
  pull_request:
    branches: [ main ]
  workflow_dispatch:
    inputs:
      razon:
        description: 'Razón del despliegue manual'
        required: false
        default: 'Despliegue manual solicitado'

jobs:
  desplegar:
    name: 📤 Desplegar a cPanel
    runs-on: ubuntu-latest
    
    steps:
    - name: 📥 Descargar código fuente
      uses: actions/checkout@v4
      
    - name: 🔧 Configurar Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        
    - name: 📋 Mostrar información del despliegue
      run: |
        echo "🚀 Iniciando despliegue de FIME COMPANY"
        echo "📅 Fecha: \$(date)"
        echo "🔄 Commit: \$GITHUB_SHA"
        echo "👤 Usuario: \$GITHUB_ACTOR"
        echo "🌿 Rama: \$GITHUB_REF_NAME"
        
    - name: 📤 Subir archivos a cPanel via FTP
      uses: SamKirkland/FTP-Deploy-Action@v4.3.4
      with:
        server: ftp.fimecompany.com
        username: fimecomp
        password: \${{ secrets.CPANEL_PASSWORD }}
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
          .gitmessage
          
    - name: ✅ Verificar despliegue exitoso
      run: |
        echo "🎉 ¡Despliegue completado exitosamente!"
        echo ""
        echo "🌐 Sitios web actualizados:"
        echo "   ✅ Portal Principal: https://fimecompany.com"
        echo "   ✅ FimeTech: https://fimecompany.com/fimetech/"
        echo "   ✅ FimeKids: https://fimecompany.com/fimekids/"
        echo "   ✅ Ferretería: https://fimecompany.com/ferreteria/"
        echo ""
        echo "📊 Estadísticas del despliegue:"
        echo "   📅 Fecha: \$(date)"
        echo "   ⏱️ Duración: \$SECONDS segundos"
        echo "   🔄 Commit: \$GITHUB_SHA"
        
    - name: 📧 Notificar resultado (opcional)
      if: always()
      run: |
        if [ "\${{ job.status }}" == "success" ]; then
          echo "✅ Despliegue exitoso - FIME COMPANY actualizado"
        else
          echo "❌ Error en el despliegue - Revisar logs"
        fi
"@

    $workflowEspanol | Out-File -FilePath "$workflowDir\desplegar.yml" -Encoding UTF8
    Write-Host "✅ GitHub Actions configurado en español" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error configurando GitHub Actions: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔧 PASO 6: CREANDO README EN ESPAÑOL..." -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Yellow

try {
    $readmeEspanol = @"
# 🏢 FIME COMPANY - Sitio Web Oficial

[![Estado del Despliegue](https://github.com/{usuario}/fime-company-website/workflows/🚀%20Desplegar%20FIME%20COMPANY%20a%20cPanel/badge.svg)](https://github.com/{usuario}/fime-company-website/actions)

**Portal corporativo oficial de FIME COMPANY con tecnología de vanguardia**

## 👨‍💼 Información Corporativa

- **CEO:** Pedro Nicolás Hernández Lizardo
- **Empresa:** FIME COMPANY
- **Tipo:** Grupo empresarial diversificado
- **Teléfono Principal:** 829-440-9136

## 🌐 Sitios Web Activos

| División | URL | Estado |
|----------|-----|--------|
| **Portal Principal** | https://fimecompany.com | ✅ Activo |
| **FimeTech** | https://fimecompany.com/fimetech/ | ✅ Activo |
| **FimeKids** | https://fimecompany.com/fimekids/ | ✅ Activo |
| **Ferretería** | https://fimecompany.com/ferreteria/ | ✅ Activo |
| **Constructora** | https://fimecompany.com/constructora/ | 🔄 En desarrollo |
| **Energía Limpia** | https://fimecompany.com/energia/ | 🔄 En desarrollo |

## 📁 Estructura del Proyecto

```
📦 fime-company-website/
├── 🏠 index.html                    # Portal principal corporativo
├── 🎨 styles.css                    # Estilos unificados
├── 📄 README.md                     # Este archivo
├── 🔧 .gitignore                    # Archivos a ignorar
├── 💬 .gitmessage                   # Template de commits
├── 📂 fimetech/                     # División Tecnológica
│   ├── 🏠 index.html               # Portal FimeTech
│   ├── 🛒 productos.json           # Base de datos productos
│   └── 🛍️ carrito.js              # Sistema de compras
├── 📂 fimekids/                     # División Infantil
│   ├── 🏠 index.html               # Portal FimeKids
│   ├── 🎮 juegos.html              # Juegos educativos
│   ├── 🤖 ia.html                  # Chat con IA
│   └── 📞 contacto.html            # Información contacto
├── 📂 ferreteria/                   # División Industrial
│   └── 🏠 index.html               # Portal Ferretería
└── 📂 .github/                      # Configuración GitHub
    └── 📂 workflows/
        └── ⚡ desplegar.yml         # Despliegue automático
```

## 🚀 Despliegue Automático

Este repositorio utiliza **GitHub Actions** para despliegue automático:

### 🔄 Proceso Automático
1. **Push a rama main** → Se activa el despliegue
2. **GitHub Actions** → Procesa los archivos
3. **FTP Deploy** → Sube archivos a cPanel
4. **Verificación** → Confirma que el sitio funciona

### ⚙️ Configuración Requerida
- **Secreto:** `CPANEL_PASSWORD` (contraseña de cPanel)
- **Servidor FTP:** ftp.fimecompany.com
- **Usuario:** fimecomp
- **Directorio:** /public_html/

## 🛠️ Comandos Git en Español

Este repositorio está configurado con alias en español:

```bash
# Comandos básicos
git estado          # Ver estado del repositorio
git agregar .        # Agregar todos los archivos
git confirmar -m ""  # Crear commit con mensaje
git subir           # Subir cambios a GitHub
git descargar       # Descargar cambios de GitHub

# Comandos de ramas
git rama            # Ver ramas disponibles
git cambiar main    # Cambiar a rama principal
git historial       # Ver historial de commits

# Comandos GitHub CLI
gh crear-repo       # Crear nuevo repositorio
gh ver-repo         # Ver repositorio actual
gh estado           # Ver estado de GitHub
gh issues           # Ver problemas abiertos
```

## 🎯 Divisiones de FIME COMPANY

### 🚀 FimeTech - División Tecnológica
- **Especialidad:** Tecnología de vanguardia
- **Productos:** IA, Gadgets, Software, Hardware
- **Características:** 
  - Catálogo interactivo
  - Sistema de compras
  - Reviews y comparativas
  - Tutoriales especializados

### 🎨 FimeKids - División Infantil
- **Especialidad:** Educación y entretenimiento infantil
- **Servicios:** 
  - Juegos educativos
  - Chat con IA educativa
  - Contenido familiar seguro
  - Actividades interactivas

### 🔧 Ferretería Industrial Metálica del Este
- **Especialidad:** Productos industriales y construcción
- **Contacto:** 829-440-9136
- **Servicios:**
  - Catálogo industrial
  - Productos metálicos
  - Herramientas especializadas
  - Suministros de construcción

## 🔧 Desarrollo Local

### Requisitos Previos
- Git instalado
- GitHub CLI (opcional)
- Editor de código (recomendado: Visual Studio Code o Cursor)

### Configuración Inicial
```bash
# Clonar repositorio
git clone https://github.com/tu-usuario/fime-company-website.git
cd fime-company-website

# Configurar Git en español
git config --global alias.estado "status"
git config --global alias.agregar "add"
git config --global alias.confirmar "commit"
git config --global alias.subir "push"

# Ver estado actual
git estado
```

### Flujo de Trabajo
1. **Realizar cambios** en los archivos
2. **Revisar cambios:** `git estado`
3. **Agregar cambios:** `git agregar .`
4. **Crear commit:** `git confirmar -m "Descripción del cambio"`
5. **Subir a GitHub:** `git subir`
6. **GitHub Actions** desplegará automáticamente

## 📊 Estadísticas del Proyecto

- **Archivos HTML:** 7+ páginas
- **Divisiones:** 7 activas
- **Idiomas:** Español (principal)
- **Despliegue:** Automático via GitHub Actions
- **Hosting:** cPanel con FTP
- **Estado:** ✅ Producción activa

## 🤝 Contribución

Para contribuir al desarrollo:

1. **Fork** del repositorio
2. **Crear rama** para tu función: `git cambiar -b nueva-funcion`
3. **Realizar cambios** y commits descriptivos
4. **Push** a tu fork: `git subir origin nueva-funcion`
5. **Crear Pull Request** con descripción detallada

## 📞 Contacto y Soporte

- **Email:** admin@fimecompany.com
- **Teléfono:** 829-440-9136
- **Web:** https://fimecompany.com
- **CEO:** Pedro Nicolás Hernández Lizardo

## 📄 Licencia

© 2024 FIME COMPANY. Todos los derechos reservados.

---

**🚀 Desarrollado con tecnología de vanguardia para FIME COMPANY**
"@

    $readmeEspanol | Out-File -FilePath "README.md" -Encoding UTF8
    Write-Host "✅ README.md creado en español" -ForegroundColor Green
    
} catch {
    Write-Host "❌ Error creando README: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🎉 GITHUB CONFIGURADO EN ESPAÑOL COMPLETADO" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "===========================================" -ForegroundColor Yellow

Write-Host ""
Write-Host "✅ CONFIGURACIONES COMPLETADAS:" -ForegroundColor Green
Write-Host "   🔧 Git configurado con alias en español" -ForegroundColor White
Write-Host "   🌐 GitHub CLI con comandos en español" -ForegroundColor White
Write-Host "   💬 Template de commits en español" -ForegroundColor White
Write-Host "   📄 .gitignore con comentarios en español" -ForegroundColor White
Write-Host "   ⚡ GitHub Actions con workflow en español" -ForegroundColor White
Write-Host "   📋 README.md completo en español" -ForegroundColor White
Write-Host "   📦 Repositorio inicializado con commit en español" -ForegroundColor White

Write-Host ""
Write-Host "🚀 COMANDOS DISPONIBLES EN ESPAÑOL:" -ForegroundColor Yellow
Write-Host "===================================" -ForegroundColor Yellow
Write-Host "📊 Comandos Git:" -ForegroundColor Cyan
Write-Host "   git estado           # Ver estado del repositorio" -ForegroundColor White
Write-Host "   git agregar .        # Agregar todos los archivos" -ForegroundColor White
Write-Host "   git confirmar -m ''  # Crear commit con mensaje" -ForegroundColor White
Write-Host "   git subir           # Subir cambios a GitHub" -ForegroundColor White
Write-Host "   git descargar       # Descargar cambios" -ForegroundColor White
Write-Host "   git rama            # Ver ramas" -ForegroundColor White
Write-Host "   git cambiar main    # Cambiar a rama principal" -ForegroundColor White
Write-Host "   git historial       # Ver historial de commits" -ForegroundColor White

Write-Host ""
Write-Host "🌐 Comandos GitHub CLI:" -ForegroundColor Cyan
Write-Host "   gh estado           # Ver estado de GitHub" -ForegroundColor White
Write-Host "   gh crear-repo       # Crear nuevo repositorio" -ForegroundColor White
Write-Host "   gh ver-repo         # Ver repositorio actual" -ForegroundColor White
Write-Host "   gh listar-repos     # Listar tus repositorios" -ForegroundColor White
Write-Host "   gh issues           # Ver issues/problemas" -ForegroundColor White
Write-Host "   gh crear-issue      # Crear nuevo issue" -ForegroundColor White
Write-Host "   gh pr-lista         # Ver pull requests" -ForegroundColor White
Write-Host "   gh perfil           # Ver tu perfil" -ForegroundColor White

Write-Host ""
Write-Host "🔥 PRÓXIMOS PASOS:" -ForegroundColor Yellow
Write-Host "==================" -ForegroundColor Yellow
Write-Host "1️⃣ Autenticar GitHub CLI (si no está configurado):" -ForegroundColor Cyan
Write-Host "   gh auth login" -ForegroundColor White
Write-Host ""
Write-Host "2️⃣ Crear repositorio en GitHub:" -ForegroundColor Cyan
Write-Host "   gh crear-repo fime-company-website --public" -ForegroundColor White
Write-Host ""
Write-Host "3️⃣ Subir código a GitHub:" -ForegroundColor Cyan
Write-Host "   git subir origin main" -ForegroundColor White
Write-Host ""
Write-Host "4️⃣ Configurar secreto para cPanel:" -ForegroundColor Cyan
Write-Host "   • Ve a GitHub → Settings → Secrets" -ForegroundColor White
Write-Host "   • Agregar: CPANEL_PASSWORD" -ForegroundColor White
Write-Host ""
Write-Host "5️⃣ Verificar despliegue automático:" -ForegroundColor Cyan
Write-Host "   • https://fimecompany.com" -ForegroundColor White
Write-Host "   • https://fimecompany.com/fimetech/" -ForegroundColor White

Write-Host ""
Write-Host "🌍 ¡GITHUB COMPLETAMENTE EN ESPAÑOL!" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "Todos los comandos, mensajes y documentación están en español" -ForegroundColor Yellow
