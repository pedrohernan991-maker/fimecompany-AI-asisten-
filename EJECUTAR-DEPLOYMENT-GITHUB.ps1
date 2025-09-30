#!/usr/bin/env powershell
# 🚀 FIME COMPANY - DEPLOYMENT AUTOMÁTICO A GITHUB Y CPANEL
# =========================================================

Write-Host "🚀 INICIANDO DEPLOYMENT AUTOMÁTICO..." -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "=====================================" -ForegroundColor Yellow

# PASO 1: Preparar archivos
Write-Host ""
Write-Host "📁 PASO 1: PREPARANDO ARCHIVOS..." -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Yellow

# Asegurar que estamos en el directorio correcto
Set-Location "C:\Users\PC\.android\c panel"

# PASO 2: Agregar todos los archivos
Write-Host ""
Write-Host "📦 PASO 2: AGREGANDO ARCHIVOS A GIT..." -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Yellow

git agregar .
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Archivos agregados correctamente" -ForegroundColor Green
} else {
    Write-Host "⚠️  Usando comando estándar..." -ForegroundColor Yellow
    git add .
}

# PASO 3: Crear commit en español
Write-Host ""
Write-Host "💾 PASO 3: CREANDO COMMIT EN ESPAÑOL..." -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Yellow

$commitMessage = "🚀 FIME COMPANY - Proyecto completo con automatización cPanel"
git confirmar -m $commitMessage
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Usando comando estándar..." -ForegroundColor Yellow
    git commit -m $commitMessage
}

# PASO 4: Crear repositorio en GitHub
Write-Host ""
Write-Host "🌍 PASO 4: CREANDO REPOSITORIO EN GITHUB..." -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Yellow

$repoName = "fime-company-automatizado"
gh crear-repo $repoName --public --description "🏢 FIME COMPANY - Portal corporativo con automatización cPanel completa"
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Usando comando estándar..." -ForegroundColor Yellow
    gh repo create $repoName --public --description "🏢 FIME COMPANY - Portal corporativo con automatización cPanel completa"
}

# PASO 5: Configurar remote origin
Write-Host ""
Write-Host "🔗 PASO 5: CONFIGURANDO REPOSITORIO REMOTO..." -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Yellow

git remote add origin "https://github.com/$(gh api user --jq .login)/$repoName.git"
Write-Host "✅ Repositorio remoto configurado" -ForegroundColor Green

# PASO 6: Subir código a GitHub
Write-Host ""
Write-Host "⬆️  PASO 6: SUBIENDO CÓDIGO A GITHUB..." -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Yellow

git subir -u origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Usando comando estándar..." -ForegroundColor Yellow
    git push -u origin main
}

# PASO 7: Configurar GitHub Actions para deployment
Write-Host ""
Write-Host "⚙️  PASO 7: CONFIGURANDO GITHUB ACTIONS..." -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Yellow

# Crear directorio .github/workflows si no existe
if (-not (Test-Path ".github/workflows")) {
    New-Item -ItemType Directory -Path ".github/workflows" -Force | Out-Null
}

# Crear workflow de deployment
@"
name: 🚀 Deploy FIME COMPANY a cPanel

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: 📥 Checkout código
      uses: actions/checkout@v3
    
    - name: 🚀 Deploy vía FTP a cPanel
      uses: SamKirkland/FTP-Deploy-Action@4.3.3
      with:
        server: fimecompany.com
        username: fimecomp
        password: `${{ secrets.CPANEL_FTP_PASSWORD }}
        local-dir: ./
        server-dir: /public_html/
        exclude: |
          **/.git*
          **/.git*/**
          **/node_modules/**
          **/*.ps1
          **/*.bat
          **/*.md
          **/INSTRUCCIONES-*
          
    - name: ✅ Notificar deployment exitoso
      run: |
        echo "🎉 Deployment completado exitosamente!"
        echo "🌐 Sitio web: https://fimecompany.com"
        echo "📁 Archivos desplegados en /public_html/"
"@ | Out-File -FilePath ".github/workflows/deploy.yml" -Encoding utf8

Write-Host "✅ GitHub Actions configurado" -ForegroundColor Green

# PASO 8: Commit y push del workflow
Write-Host ""
Write-Host "📤 PASO 8: SUBIENDO CONFIGURACIÓN DE DEPLOYMENT..." -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Yellow

git add .github/workflows/deploy.yml
git commit -m "⚙️ Configurar GitHub Actions para deployment automático a cPanel"
git push origin main

Write-Host ""
Write-Host "🎉 ¡DEPLOYMENT AUTOMÁTICO CONFIGURADO!" -ForegroundColor Green -BackgroundColor DarkGreen
Write-Host "======================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "📋 PRÓXIMOS PASOS:" -ForegroundColor White -BackgroundColor DarkBlue
Write-Host "==================" -ForegroundColor Yellow
Write-Host "1. 🔑 Ir a GitHub → Repositorio → Settings → Secrets" -ForegroundColor Cyan
Write-Host "2. 🔐 Agregar secret: CPANEL_FTP_PASSWORD" -ForegroundColor Cyan
Write-Host "3. 🚀 Cualquier push a main → Deployment automático" -ForegroundColor Cyan
Write-Host ""
Write-Host "🌐 REPOSITORIO: https://github.com/$(gh api user --jq .login)/$repoName" -ForegroundColor Green
Write-Host "🌍 SITIO WEB: https://fimecompany.com" -ForegroundColor Green
Write-Host ""
Write-Host "✨ ¡AUTOMATIZACIÓN COMPLETA ACTIVADA!" -ForegroundColor Magenta

# Abrir GitHub en el navegador
Write-Host ""
Write-Host "🌐 ABRIENDO GITHUB EN EL NAVEGADOR..." -ForegroundColor Cyan
Start-Process "https://github.com/$(gh api user --jq .login)/$repoName"

Read-Host "Presiona ENTER para continuar..."
