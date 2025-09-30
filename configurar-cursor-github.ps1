# FIME COMPANY - Automatización Cursor + GitHub + cPanel
Write-Host "🚀 INICIANDO AUTOMATIZACIÓN FIME COMPANY" -ForegroundColor Cyan

# Configurar Git
git config --global user.name "FIME COMPANY"
git config --global user.email "admin@fimecompany.com"
git config --global init.defaultBranch main

# Crear proyecto
$projectDir = "C:\Users\PC\.android\fime-company-automation"
if (Test-Path $projectDir) { Remove-Item $projectDir -Recurse -Force }
New-Item -ItemType Directory -Path $projectDir -Force | Out-Null
Set-Location $projectDir

# Inicializar Git
git init | Out-Null

# Crear estructura
$dirs = @("src", "src/ferreteria", "src/fimekids", "src/fimetech", ".github", ".github/workflows", "scripts")
foreach ($dir in $dirs) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

# Copiar archivos
$sourceDir = "C:\Users\PC\.android\c panel"
$files = @(
    @{S="index.html"; D="src/index.html"},
    @{S="ferreteria/index.html"; D="src/ferreteria/index.html"},
    @{S="fimekids/index.html"; D="src/fimekids/index.html"},
    @{S="fimekids/juegos.html"; D="src/fimekids/juegos.html"},
    @{S="fimekids/ia.html"; D="src/fimekids/ia.html"},
    @{S="fimekids/contacto.html"; D="src/fimekids/contacto.html"},
    @{S="fimetech/index.html"; D="src/fimetech/index.html"},
    @{S="fimetech/products.json"; D="src/fimetech/products.json"},
    @{S="fimetech/cart.js"; D="src/fimetech/cart.js"},
    @{S="fimetech/chatgpt.html"; D="src/fimetech/chatgpt.html"},
    @{S="fimetech/iphone15pro.html"; D="src/fimetech/iphone15pro.html"},
    @{S="fimetech/rtx4090.html"; D="src/fimetech/rtx4090.html"}
)

Write-Host "📋 Copiando archivos..." -ForegroundColor Green
foreach ($f in $files) {
    $src = Join-Path $sourceDir $f.S
    if (Test-Path $src) {
        $destDir = Split-Path $f.D -Parent
        if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
        Copy-Item $src $f.D -Force
        Write-Host "  ✅ $($f.S)" -ForegroundColor Green
    }
}

# GitHub Actions
Write-Host "🔄 Creando GitHub Actions..." -ForegroundColor Green
@"
name: Deploy to cPanel
on:
  push:
    branches: [ main ]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: SamKirkland/FTP-Deploy-Action@v4.3.4
      with:
        server: `${{ secrets.FTP_SERVER }}
        username: `${{ secrets.FTP_USERNAME }}
        password: `${{ secrets.FTP_PASSWORD }}
        local-dir: ./src/
        server-dir: /public_html/
"@ | Out-File -FilePath ".github/workflows/deploy.yml" -Encoding UTF8

# Cursor config
Write-Host "⚙️ Configurando Cursor..." -ForegroundColor Green
New-Item -ItemType Directory -Path ".vscode" -Force | Out-Null
@"
{
  "editor.fontSize": 14,
  "editor.tabSize": 2,
  "files.autoSave": "afterDelay",
  "git.enableSmartCommit": true,
  "terminal.integrated.defaultProfile.windows": "PowerShell"
}
"@ | Out-File -FilePath ".vscode/settings.json" -Encoding UTF8

# Package.json
@"
{
  "name": "fime-company-automation",
  "version": "1.0.0",
  "scripts": {
    "dev": "live-server src --port=3000"
  }
}
"@ | Out-File -FilePath "package.json" -Encoding UTF8

# README
@"
# FIME COMPANY - Automatización Completa
Sistema automatizado con Cursor + GitHub + cPanel

## Próximos pasos:
1. Crear repositorio en GitHub
2. git remote add origin [URL]
3. git push -u origin main
4. npm install
5. npm run dev
"@ | Out-File -FilePath "README.md" -Encoding UTF8

# Commit inicial
git add . 2>$null
git commit -m "🚀 FIME COMPANY automation setup" 2>$null | Out-Null

Write-Host ""
Write-Host "🎉 ¡AUTOMATIZACIÓN COMPLETADA!" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "================================" -ForegroundColor Yellow
Write-Host "📁 Proyecto: $projectDir" -ForegroundColor Cyan
Write-Host "🚀 ¡TODO LISTO!" -ForegroundColor Green
