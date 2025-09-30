@echo off
title AUTOMATIZACION PERMANENTE FIME COMPANY
color 0B
cls
echo.
echo ===============================================
echo   🔄 AUTOMATIZACION PERMANENTE FIME COMPANY
echo ===============================================
echo.

REM Cambiar al directorio correcto
cd /d "C:\Users\PC\.android\c panel"
echo 📁 Directorio: %CD%
echo.

echo 🔧 OPCIONES DE AUTOMATIZACION PERMANENTE:
echo.
echo 1️⃣  COMPLETA    - Ejecutar todo una vez
echo 2️⃣  CONTINUA    - Automatización permanente (no se detiene)
echo 3️⃣  TAREA       - Crear tarea programada del sistema
echo 4️⃣  MONITOREO   - Solo monitorear estado
echo 5️⃣  BACKUP      - Solo crear backup
echo.
set /p opcion="Selecciona una opción (1-5): "

if "%opcion%"=="1" (
    echo.
    echo 🚀 Ejecutando automatización completa...
    powershell -ExecutionPolicy Bypass -File "AUTOMATIZACION-PERMANENTE.ps1" -Accion "completa"
)

if "%opcion%"=="2" (
    echo.
    echo 🔄 Iniciando automatización permanente continua...
    echo ⚠️  ADVERTENCIA: Esta opción ejecutará indefinidamente
    echo ⚠️  Presiona Ctrl+C para detener
    echo.
    pause
    powershell -ExecutionPolicy Bypass -File "AUTOMATIZACION-PERMANENTE.ps1" -Accion "continua" -Continuo
)

if "%opcion%"=="3" (
    echo.
    echo 📅 Creando tarea programada del sistema...
    powershell -ExecutionPolicy Bypass -File "AUTOMATIZACION-PERMANENTE.ps1" -Accion "tarea"
    echo.
    echo ✅ Tarea programada creada
    echo 📋 La automatización se ejecutará automáticamente al iniciar Windows
)

if "%opcion%"=="4" (
    echo.
    echo 📊 Ejecutando solo monitoreo...
    powershell -ExecutionPolicy Bypass -File "AUTOMATIZACION-PERMANENTE.ps1" -Accion "monitoreo"
)

if "%opcion%"=="5" (
    echo.
    echo 💾 Creando backup automático...
    powershell -ExecutionPolicy Bypass -File "AUTOMATIZACION-PERMANENTE.ps1" -Accion "backup"
)

echo.
echo ✅ Automatización completada
echo.
echo 📋 Revisa el archivo de log:
echo    C:\Users\PC\.android\c panel\automatizacion-permanente.log
echo.
echo Presiona cualquier tecla para continuar...
pause >nul
