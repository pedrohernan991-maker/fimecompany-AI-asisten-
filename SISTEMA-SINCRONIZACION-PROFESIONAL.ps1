# =========================================================================
# SISTEMA DE SINCRONIZACIÓN PROFESIONAL FIME COMPANY
# Cursor → GitHub → cPanel public_html
# Automatización Completa y Optimizada
# =========================================================================

$ErrorActionPreference = "Continue"
$Host.UI.RawUI.WindowTitle = "FIME COMPANY - Sistema de Sincronización Profesional"

# COLORES Y FORMATO
function Write-Header {
    param($Text)
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "  $Text" -ForegroundColor Yellow -BackgroundColor DarkBlue
    Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Step {
    param($Number, $Text)
    Write-Host "[PASO $Number]" -ForegroundColor Green -NoNewline
    Write-Host " $Text" -ForegroundColor White
}

function Write-Success {
    param($Text)
    Write-Host "✓ " -ForegroundColor Green -NoNewline
    Write-Host $Text -ForegroundColor White
}

function Write-Info {
    param($Text)
    Write-Host "→ " -ForegroundColor Cyan -NoNewline
    Write-Host $Text -ForegroundColor Gray
}

function Write-Warning {
    param($Text)
    Write-Host "⚠ " -ForegroundColor Yellow -NoNewline
    Write-Host $Text -ForegroundColor Yellow
}

function Write-Error2 {
    param($Text)
    Write-Host "✗ " -ForegroundColor Red -NoNewline
    Write-Host $Text -ForegroundColor Red
}

# CONFIGURACIÓN DEL PROYECTO
$CONFIG = @{
    ProjectName = "fimecompany-AI-asisten-"
    ProjectPath = $PWD.Path
    GitHubRepo = "https://github.com/PedroNicolas2001/fimecompany-AI-asisten-.git"
    GitHubBranch = "main"
    
    # Divisiones del proyecto
    Divisiones = @(
        "ferreteria",
        "fimekids",
        "fimetech",
        "industria"
    )
    
    # Archivos principales
    ArchivosRaiz = @(
        "index.html",
        "styles.css",
        "categorias.json",
        "robots.txt",
        "sitemap.xml"
    )
}

# =========================================================================
# FASE 1: ANÁLISIS Y VERIFICACIÓN
# =========================================================================
Write-Header "FASE 1: ANÁLISIS Y VERIFICACIÓN DEL PROYECTO"

Write-Step 1 "Verificando estructura del proyecto..."
$estructura = @{
    Raiz = Test-Path $CONFIG.ProjectPath
    PublicHTML = Test-Path "$($CONFIG.ProjectPath)\public_html"
    GitHub = Test-Path "$($CONFIG.ProjectPath)\.git"
}

if ($estructura.Raiz) {
    Write-Success "Proyecto encontrado: $($CONFIG.ProjectPath)"
} else {
    Write-Error2 "No se encuentra el directorio del proyecto"
    exit 1
}

Write-Step 2 "Analizando carpetas de divisiones..."
$divisionesEncontradas = @()
foreach ($division in $CONFIG.Divisiones) {
    $path = Join-Path $CONFIG.ProjectPath $division
    if (Test-Path $path) {
        $archivos = (Get-ChildItem $path -File).Count
        Write-Success "$division - $archivos archivos"
        $divisionesEncontradas += $division
    } else {
        Write-Warning "$division - No encontrada"
    }
}

Write-Step 3 "Verificando carpeta public_html..."
if ($estructura.PublicHTML) {
    $archivosPublicHTML = Get-ChildItem "$($CONFIG.ProjectPath)\public_html" -Recurse -File
    Write-Success "public_html encontrado - $($archivosPublicHTML.Count) archivos"
} else {
    Write-Info "Creando carpeta public_html..."
    New-Item -ItemType Directory -Path "$($CONFIG.ProjectPath)\public_html" -Force | Out-Null
    Write-Success "public_html creado"
}

Write-Step 4 "Verificando conexión con GitHub..."
if ($estructura.GitHub) {
    try {
        $gitRemote = git remote -v 2>&1
        if ($gitRemote -match "github.com") {
            Write-Success "Repositorio GitHub conectado"
        } else {
            Write-Warning "Repositorio GitHub no configurado correctamente"
        }
    } catch {
        Write-Warning "Git no está inicializado"
    }
} else {
    Write-Warning "Git no está inicializado en este proyecto"
}

# =========================================================================
# FASE 2: SINCRONIZACIÓN INTELIGENTE
# =========================================================================
Write-Header "FASE 2: SINCRONIZACIÓN INTELIGENTE DE ARCHIVOS"

Write-Step 1 "Sincronizando archivos raíz a public_html..."
$sincronizadosRaiz = 0
foreach ($archivo in $CONFIG.ArchivosRaiz) {
    $origen = Join-Path $CONFIG.ProjectPath $archivo
    $destino = Join-Path "$($CONFIG.ProjectPath)\public_html" $archivo
    
    if (Test-Path $origen) {
        Copy-Item $origen $destino -Force
        Write-Success "Sincronizado: $archivo"
        $sincronizadosRaiz++
    } else {
        Write-Info "Omitido (no existe): $archivo"
    }
}
Write-Info "Total archivos raíz sincronizados: $sincronizadosRaiz"

Write-Step 2 "Sincronizando divisiones a public_html..."
$sincronizadosDivisiones = 0
foreach ($division in $divisionesEncontradas) {
    $origen = Join-Path $CONFIG.ProjectPath $division
    $destino = Join-Path "$($CONFIG.ProjectPath)\public_html" $division
    
    Write-Info "Sincronizando $division..."
    
    # Crear carpeta de destino si no existe
    if (-not (Test-Path $destino)) {
        New-Item -ItemType Directory -Path $destino -Force | Out-Null
    }
    
    # Copiar todos los archivos
    $archivos = Get-ChildItem $origen -File
    foreach ($archivo in $archivos) {
        Copy-Item $archivo.FullName "$destino\$($archivo.Name)" -Force
        $sincronizadosDivisiones++
    }
    
    Write-Success "$division - $($archivos.Count) archivos sincronizados"
}
Write-Info "Total archivos de divisiones sincronizados: $sincronizadosDivisiones"

# =========================================================================
# FASE 3: OPTIMIZACIÓN DE ESTRUCTURA
# =========================================================================
Write-Header "FASE 3: OPTIMIZACIÓN DE ESTRUCTURA"

Write-Step 1 "Creando estructura optimizada en public_html..."

# Crear archivo .htaccess para optimización
$htaccess = @"
# Optimización FIME COMPANY
Options -Indexes
DirectoryIndex index.html index.php

# Compresión GZIP
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>

# Cache
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType text/html "access plus 1 hour"
</IfModule>

# Redirección WWW
RewriteEngine On
RewriteCond %{HTTP_HOST} ^www\.(.*)$ [NC]
RewriteRule ^(.*)$ https://%1/$1 [R=301,L]

# Seguridad
<FilesMatch "\.(htaccess|htpasswd|ini|log|sh|inc|bak)$">
    Order Allow,Deny
    Deny from all
</FilesMatch>
"@

$htaccessPath = Join-Path "$($CONFIG.ProjectPath)\public_html" ".htaccess"
$htaccess | Out-File -FilePath $htaccessPath -Encoding UTF8 -Force
Write-Success "Archivo .htaccess creado y optimizado"

Write-Step 2 "Creando archivo README para public_html..."
$readme = @"
# FIME COMPANY - Public HTML
## Estructura del Sitio Web

Este directorio contiene todos los archivos listos para subir a cPanel.

### Estructura:
- \`index.html\` - Portal principal
- \`styles.css\` - Estilos globales
- \`categorias.json\` - Datos de productos
- \`ferreteria/\` - División Ferretería Industrial
- \`fimekids/\` - División FIMEKIDS
- \`fimetech/\` - División FIMETECH
- \`industria/\` - División Industria

### Última sincronización:
$(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

### Total de archivos:
$($sincronizadosRaiz + $sincronizadosDivisiones) archivos sincronizados

### Divisiones activas:
$($divisionesEncontradas -join ", ")
"@

$readmePath = Join-Path "$($CONFIG.ProjectPath)\public_html" "README.md"
$readme | Out-File -FilePath $readmePath -Encoding UTF8 -Force
Write-Success "README.md creado en public_html"

# =========================================================================
# FASE 4: PREPARACIÓN PARA GITHUB
# =========================================================================
Write-Header "FASE 4: PREPARACIÓN PARA GITHUB"

Write-Step 1 "Verificando estado de Git..."
if (Test-Path "$($CONFIG.ProjectPath)\.git") {
    try {
        $gitStatus = git status --short 2>&1
        if ($gitStatus) {
            $cambios = ($gitStatus | Measure-Object).Count
            Write-Info "Archivos modificados: $cambios"
        } else {
            Write-Success "No hay cambios pendientes"
        }
    } catch {
        Write-Warning "No se pudo verificar el estado de Git"
    }
} else {
    Write-Info "Inicializando repositorio Git..."
    git init
    git remote add origin $CONFIG.GitHubRepo
    Write-Success "Git inicializado"
}

Write-Step 2 "Preparando archivos para commit..."
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "Sincronización automática - $timestamp - $($sincronizadosRaiz + $sincronizadosDivisiones) archivos"

# =========================================================================
# FASE 5: GENERACIÓN DE REPORTES
# =========================================================================
Write-Header "FASE 5: GENERACIÓN DE REPORTES"

$reporte = @"
═══════════════════════════════════════════════════════════════
REPORTE DE SINCRONIZACIÓN - FIME COMPANY
═══════════════════════════════════════════════════════════════

FECHA Y HORA: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
PROYECTO: $($CONFIG.ProjectName)
RUTA: $($CONFIG.ProjectPath)

ESTADÍSTICAS DE SINCRONIZACIÓN:
───────────────────────────────────────────────────────────────
• Archivos raíz sincronizados:      $sincronizadosRaiz
• Archivos de divisiones:           $sincronizadosDivisiones
• Total de archivos sincronizados:  $($sincronizadosRaiz + $sincronizadosDivisiones)

DIVISIONES SINCRONIZADAS:
───────────────────────────────────────────────────────────────
$($divisionesEncontradas | ForEach-Object { "✓ $_" } | Out-String)

ESTRUCTURA PUBLIC_HTML:
───────────────────────────────────────────────────────────────
public_html/
├── index.html
├── styles.css
├── categorias.json
├── .htaccess (optimizado)
├── README.md
$(foreach ($div in $divisionesEncontradas) { "├── $div/" })

PRÓXIMOS PASOS:
───────────────────────────────────────────────────────────────
1. Revisar archivos en: $($CONFIG.ProjectPath)\public_html
2. Subir a GitHub con: git add . && git commit -m "$commitMessage" && git push
3. Subir a cPanel vía File Manager o FTP

COMANDOS SUGERIDOS:
───────────────────────────────────────────────────────────────
# Subir a GitHub:
cd "$($CONFIG.ProjectPath)"
git add .
git commit -m "$commitMessage"
git push origin $($CONFIG.GitHubBranch)

# URLs finales esperadas:
• https://fimecompany.com/
• https://fimecompany.com/ferreteria/
• https://fimecompany.com/fimekids/
• https://fimecompany.com/fimetech/

═══════════════════════════════════════════════════════════════
"@

Write-Host $reporte

# Guardar reporte en archivo
$fechaReporte = Get-Date -Format "yyyyMMdd-HHmmss"
$reportePath = Join-Path $CONFIG.ProjectPath "REPORTE-SINCRONIZACION-$fechaReporte.txt"
$reporte | Out-File -FilePath $reportePath -Encoding UTF8
Write-Success "Reporte guardado en: $reportePath"

# =========================================================================
# FASE 6: COMANDOS INTERACTIVOS
# =========================================================================
Write-Header "FASE 6: ACCIONES DISPONIBLES"

Write-Host ""
Write-Host "¿Qué deseas hacer ahora?" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. " -ForegroundColor Cyan -NoNewline
Write-Host "Subir a GitHub automáticamente" -ForegroundColor White
Write-Host "2. " -ForegroundColor Cyan -NoNewline
Write-Host "Ver archivos sincronizados en public_html" -ForegroundColor White
Write-Host "3. " -ForegroundColor Cyan -NoNewline
Write-Host "Abrir carpeta public_html" -ForegroundColor White
Write-Host "4. " -ForegroundColor Cyan -NoNewline
Write-Host "Salir (manual)" -ForegroundColor White
Write-Host ""

$opcion = Read-Host "Selecciona una opción (1-4)"

switch ($opcion) {
    "1" {
        Write-Header "SUBIENDO A GITHUB"
        Write-Step 1 "Agregando archivos..."
        git add .
        Write-Step 2 "Creando commit..."
        git commit -m $commitMessage
        Write-Step 3 "Subiendo a GitHub..."
        git push origin $CONFIG.GitHubBranch
        Write-Success "¡Archivos subidos a GitHub!"
    }
    "2" {
        Write-Header "ARCHIVOS EN PUBLIC_HTML"
        Get-ChildItem "$($CONFIG.ProjectPath)\public_html" -Recurse -File | 
            Select-Object FullName, Length, LastWriteTime | 
            Format-Table -AutoSize
    }
    "3" {
        Write-Info "Abriendo carpeta public_html..."
        explorer "$($CONFIG.ProjectPath)\public_html"
    }
    "4" {
        Write-Success "Sistema de sincronización completado"
    }
    default {
        Write-Warning "Opción no válida"
    }
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  SINCRONIZACIÓN COMPLETADA EXITOSAMENTE" -ForegroundColor Yellow -BackgroundColor DarkGreen
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
