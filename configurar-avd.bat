@echo off
echo CONFIGURANDO AVD (ANDROID VIRTUAL DEVICE)
echo ========================================

echo.
echo 1. Abriendo Android Studio...
start "" "C:\Program Files\Android\Android Studio\bin\studio64.exe"

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
