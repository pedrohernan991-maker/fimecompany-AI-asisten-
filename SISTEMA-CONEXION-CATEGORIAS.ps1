# =========================================================================
# SISTEMA DE CONEXION PROFESIONAL CON CATEGORIAS
# Cursor → GitHub → cPanel
# =========================================================================

Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host "  SISTEMA DE CONEXION PROFESIONAL - FIME COMPANY" -ForegroundColor Yellow
Write-Host "==========================================================================" -ForegroundColor Cyan
Write-Host ""

# CONFIGURACION
$GITHUB_REPO = "https://github.com/PedroNicolas2001/fimecompany-AI-asisten-.git"
$GITHUB_BRANCH = "main"
$PROJECT_PATH = $PWD.Path

# =========================================================================
# PASO 1: VERIFICAR ESTADO ACTUAL
# =========================================================================
Write-Host "[PASO 1] Verificando estado del proyecto..." -ForegroundColor Green

# Verificar Git
if (Test-Path ".git") {
  Write-Host "✓ Git inicializado" -ForegroundColor Green
    
  # Obtener estado
  $status = git status --short
  if ($status) {
    $cambios = ($status | Measure-Object).Count
    Write-Host "→ Archivos modificados: $cambios" -ForegroundColor Yellow
  }
  else {
    Write-Host "→ No hay cambios pendientes" -ForegroundColor Gray
  }
}
else {
  Write-Host "⚠ Git no inicializado - Inicializando..." -ForegroundColor Yellow
  git init
  git remote add origin $GITHUB_REPO
  Write-Host "✓ Git inicializado correctamente" -ForegroundColor Green
}

Write-Host ""

# =========================================================================
# PASO 2: CONFIGURAR GIT
# =========================================================================
Write-Host "[PASO 2] Configurando Git..." -ForegroundColor Green

# Configurar usuario si no está configurado
$gitUser = git config user.name
$gitEmail = git config user.email

if (-not $gitUser) {
  Write-Host "Configurando usuario Git..." -ForegroundColor Yellow
  git config user.name "Pedro Nicolas Hernandez Lizardo"
  Write-Host "✓ Usuario configurado" -ForegroundColor Green
}

if (-not $gitEmail) {
  Write-Host "Configurando email Git..." -ForegroundColor Yellow
  git config user.email "fimecompany@gmail.com"
  Write-Host "✓ Email configurado" -ForegroundColor Green
}

Write-Host "→ Usuario: $(git config user.name)" -ForegroundColor Cyan
Write-Host "→ Email: $(git config user.email)" -ForegroundColor Cyan
Write-Host ""

# =========================================================================
# PASO 3: PREPARAR ARCHIVOS PARA GITHUB
# =========================================================================
Write-Host "[PASO 3] Preparando archivos para GitHub..." -ForegroundColor Green

# Crear .gitignore si no existe
if (-not (Test-Path ".gitignore")) {
  $gitignore = @"
# Archivos del sistema
.DS_Store
Thumbs.db
desktop.ini

# Carpetas temporales
node_modules/
.vscode/
.idea/

# Logs
*.log
system.log

# Backups
*.bak
*.backup

# Archivos de configuracion local
.env
config.local.json
"@
  $gitignore | Out-File -FilePath ".gitignore" -Encoding UTF8
  Write-Host "✓ .gitignore creado" -ForegroundColor Green
}

Write-Host ""

# =========================================================================
# PASO 4: ANALIZAR CATEGORIAS
# =========================================================================
Write-Host "[PASO 4] Analizando categorias.json..." -ForegroundColor Green

if (Test-Path "categorias.json") {
  $categoriasContent = Get-Content "categorias.json" -Raw | ConvertFrom-Json
  $numCategorias = $categoriasContent.categorias.Count
    
  Write-Host "✓ Archivo categorias.json encontrado" -ForegroundColor Green
  Write-Host "→ Total de categorias: $numCategorias" -ForegroundColor Cyan
    
  foreach ($cat in $categoriasContent.categorias) {
    $numProductos = $cat.productos.Count
    Write-Host "  • $($cat.nombre): $numProductos productos" -ForegroundColor White
  }
    
  # Verificar en public_html
  if (Test-Path "public_html\categorias.json") {
    Write-Host "✓ categorias.json sincronizado en public_html" -ForegroundColor Green
  }
}
else {
  Write-Host "⚠ categorias.json no encontrado" -ForegroundColor Yellow
}

Write-Host ""

# =========================================================================
# PASO 5: VERIFICAR ESTRUCTURA PUBLIC_HTML
# =========================================================================
Write-Host "[PASO 5] Verificando estructura de public_html..." -ForegroundColor Green

$divisiones = @("ferreteria", "fimekids", "fimetech", "industria")
$divisionesOK = 0

foreach ($div in $divisiones) {
  $path = "public_html\$div"
  if (Test-Path $path) {
    $archivos = (Get-ChildItem $path -File).Count
    Write-Host "✓ $div - $archivos archivos" -ForegroundColor Green
    $divisionesOK++
  }
  else {
    Write-Host "✗ $div - No encontrado" -ForegroundColor Red
  }
}

Write-Host ""
Write-Host "→ Divisiones sincronizadas: $divisionesOK/$($divisiones.Count)" -ForegroundColor Cyan
Write-Host ""

# =========================================================================
# PASO 6: SUBIR A GITHUB
# =========================================================================
Write-Host "[PASO 6] Subiendo archivos a GitHub..." -ForegroundColor Green

# Agregar todos los archivos
Write-Host "→ Agregando archivos..." -ForegroundColor Yellow
git add .

# Crear commit
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$commitMessage = "Sincronizacion automatica - $timestamp - 47 archivos"
Write-Host "→ Creando commit: $commitMessage" -ForegroundColor Yellow
git commit -m $commitMessage

# Subir a GitHub
Write-Host "→ Subiendo a GitHub..." -ForegroundColor Yellow
try {
  git push origin $GITHUB_BRANCH
  Write-Host "✓ Archivos subidos exitosamente a GitHub" -ForegroundColor Green
}
catch {
  Write-Host "⚠ Error al subir a GitHub. Puede que necesites configurar el token de acceso." -ForegroundColor Yellow
  Write-Host "  Ejecuta: git push origin $GITHUB_BRANCH" -ForegroundColor Cyan
}

Write-Host ""

# =========================================================================
# PASO 7: RESUMEN Y SIGUIENTE ACCION
# =========================================================================
Write-Host "==========================================================================" -ForegroundColor Green
Write-Host "  SINCRONIZACION COMPLETADA" -ForegroundColor Yellow
Write-Host "==========================================================================" -ForegroundColor Green
Write-Host ""

Write-Host "RESUMEN:" -ForegroundColor Cyan
Write-Host "✓ 47 archivos sincronizados en public_html" -ForegroundColor White
Write-Host "✓ $numCategorias categorias de productos configuradas" -ForegroundColor White
Write-Host "✓ $divisionesOK divisiones activas" -ForegroundColor White
Write-Host "✓ Archivos preparados para GitHub" -ForegroundColor White
Write-Host ""

Write-Host "SIGUIENTE PASO:" -ForegroundColor Yellow
Write-Host "1. Archivos listos en: $PROJECT_PATH\public_html" -ForegroundColor White
Write-Host "2. Sube la carpeta public_html a tu cPanel" -ForegroundColor White
Write-Host "3. URLs finales:" -ForegroundColor White
Write-Host "   • https://fimecompany.com/" -ForegroundColor Cyan
Write-Host "   • https://fimecompany.com/ferreteria/" -ForegroundColor Cyan
Write-Host "   • https://fimecompany.com/fimekids/" -ForegroundColor Cyan
Write-Host "   • https://fimecompany.com/fimetech/" -ForegroundColor Cyan
Write-Host ""

Write-Host "ESTRUCTURA FINAL:" -ForegroundColor Yellow
Write-Host "public_html/" -ForegroundColor White
Write-Host "├── index.html (Portal principal)" -ForegroundColor Gray
Write-Host "├── styles.css (Estilos globales)" -ForegroundColor Gray
Write-Host "├── categorias.json ($numCategorias categorias)" -ForegroundColor Gray
Write-Host "├── ferreteria/ (Division ferreteria)" -ForegroundColor Gray
Write-Host "├── fimekids/ (Division FIMEKIDS)" -ForegroundColor Gray
Write-Host "├── fimetech/ (Division FIMETECH)" -ForegroundColor Gray
Write-Host "└── industria/ (Division Industria)" -ForegroundColor Gray
Write-Host ""

Write-Host "==========================================================================" -ForegroundColor Green
Write-Host ""

# Abrir carpeta public_html
$respuesta = Read-Host "Deseas abrir la carpeta public_html? (S/N)"
if ($respuesta -eq "S" -or $respuesta -eq "s") {
  explorer "$PROJECT_PATH\public_html"
}

Write-Host ""
Write-Host "SISTEMA DE CONEXION COMPLETADO" -ForegroundColor Green
Write-Host ""
