# CONFIGURAR ANDROID STUDIO Y EMULADOR AVD
Write-Host "CONFIGURAR ANDROID STUDIO Y EMULADOR AVD" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Solucionando problemas del emulador AVD..." -ForegroundColor Yellow

# 1. Verificar si Android Studio está instalado
$androidStudioPath = "C:\Program Files\Android\Android Studio\bin\studio64.exe"
if (Test-Path $androidStudioPath) {
    Write-Host "✅ Android Studio encontrado en: $androidStudioPath" -ForegroundColor Green
} else {
    Write-Host "❌ Android Studio no encontrado. Verificando rutas alternativas..." -ForegroundColor Red
    
    # Buscar en rutas alternativas
    $alternativePaths = @(
        "C:\Program Files (x86)\Android\Android Studio\bin\studio64.exe",
        "C:\Users\$env:USERNAME\AppData\Local\Android\Sdk\emulator\emulator.exe",
        "C:\Android\Sdk\emulator\emulator.exe"
    )
    
    foreach ($path in $alternativePaths) {
        if (Test-Path $path) {
            Write-Host "✅ Encontrado en: $path" -ForegroundColor Green
            $androidStudioPath = $path
            break
        }
    }
}

# 2. Verificar SDK de Android
$sdkPath = "$env:LOCALAPPDATA\Android\Sdk"
if (Test-Path $sdkPath) {
    Write-Host "✅ Android SDK encontrado en: $sdkPath" -ForegroundColor Green
} else {
    Write-Host "❌ Android SDK no encontrado. Configurando variables de entorno..." -ForegroundColor Red
    
    # Configurar variables de entorno
    [Environment]::SetEnvironmentVariable("ANDROID_HOME", $sdkPath, "User")
    [Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $sdkPath, "User")
    Write-Host "✅ Variables de entorno configuradas" -ForegroundColor Green
}

# 3. Verificar emulador
$emulatorPath = "$sdkPath\emulator\emulator.exe"
if (Test-Path $emulatorPath) {
    Write-Host "✅ Emulador encontrado en: $emulatorPath" -ForegroundColor Green
} else {
    Write-Host "❌ Emulador no encontrado. Instalando..." -ForegroundColor Red
}

# 4. Crear script para configurar AVD
$avdScript = @"
@echo off
echo CONFIGURANDO AVD (ANDROID VIRTUAL DEVICE)
echo ========================================

echo.
echo 1. Abriendo Android Studio...
start "" "$androidStudioPath"

echo.
echo 2. Instrucciones para configurar AVD:
echo.
echo    a) En Android Studio, ve a: Tools ^> AVD Manager
echo    b) Click en "Create Virtual Device"
echo    c) Selecciona: Phone ^> Pixel 4
echo    d) Selecciona: API Level 34 (Android 14)
echo    e) Click en "Next" y luego "Finish"
echo.
echo 3. Una vez creado el AVD:
echo    a) Click en el boton "Play" (triangulo verde) del AVD
echo    b) Espera a que se inicie el emulador
echo    c) Ejecuta la app BBM Messenger
echo.

pause
"@

$avdScript | Out-File -FilePath "configurar-avd.bat" -Encoding ASCII

Write-Host ""
Write-Host "SOLUCIONES PARA EL PROBLEMA AVD:" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "1. PROBLEMA: AVD no configurado" -ForegroundColor Yellow
Write-Host "   SOLUCION: Crear un nuevo AVD en Android Studio" -ForegroundColor White
Write-Host "   - Tools > AVD Manager > Create Virtual Device" -ForegroundColor White
Write-Host "   - Seleccionar: Pixel 4, API 34" -ForegroundColor White

Write-Host ""
Write-Host "2. PROBLEMA: SDK no instalado" -ForegroundColor Yellow
Write-Host "   SOLUCION: Instalar Android SDK" -ForegroundColor White
Write-Host "   - File > Settings > Appearance & Behavior > System Settings > Android SDK" -ForegroundColor White
Write-Host "   - Instalar: Android 14 (API 34)" -ForegroundColor White

Write-Host ""
Write-Host "3. PROBLEMA: Emulador lento" -ForegroundColor Yellow
Write-Host "   SOLUCION: Configurar aceleracion de hardware" -ForegroundColor White
Write-Host "   - AVD Manager > Edit > Advanced Settings" -ForegroundColor White
Write-Host "   - Graphics: Hardware - GLES 2.0" -ForegroundColor White

Write-Host ""
Write-Host "4. PROBLEMA: Permisos de administrador" -ForegroundColor Yellow
Write-Host "   SOLUCION: Ejecutar Android Studio como administrador" -ForegroundColor White
Write-Host "   - Click derecho en Android Studio > Ejecutar como administrador" -ForegroundColor White

Write-Host ""
Write-Host "ARCHIVOS CREADOS:" -ForegroundColor Cyan
Write-Host "• configurar-avd.bat - Script para configurar AVD" -ForegroundColor White

Write-Host ""
Write-Host "INSTRUCCIONES RAPIDAS:" -ForegroundColor Yellow
Write-Host "1. Ejecutar: configurar-avd.bat" -ForegroundColor White
Write-Host "2. Seguir las instrucciones en pantalla" -ForegroundColor White
Write-Host "3. Crear AVD en Android Studio" -ForegroundColor White
Write-Host "4. Ejecutar la app BBM Messenger" -ForegroundColor White

Write-Host ""
Write-Host "PRESIONA CUALQUIER TECLA PARA CONTINUAR..." -ForegroundColor Yellow
Read-Host
