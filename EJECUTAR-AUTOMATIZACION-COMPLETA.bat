@echo off
title AUTOMATIZACION COMPLETA PC - FIME COMPANY
color 0A
cls
echo.
echo ===============================================
echo   🖥️ AUTOMATIZACION COMPLETA PC - FIME COMPANY
echo ===============================================
echo.

REM Verificar si está ejecutándose como administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Ejecutándose como Administrador
) else (
    echo ⚠️  No es administrador - Algunas funciones pueden estar limitadas
)

echo.
echo 🚀 EJECUTANDO TODAS LAS OPCIONES AUTOMÁTICAMENTE:
echo.
echo    1️⃣ Configuración completa
echo    2️⃣ Monitoreo completo  
echo    3️⃣ Backup completo
echo    4️⃣ Sincronización automática
echo    5️⃣ Tarea programada del sistema
echo    6️⃣ Optimización del sistema
echo.

REM Cambiar al directorio correcto
cd /d "C:\Users\PC\.android\c panel"
echo 📁 Directorio: %CD%
echo.

echo 🔄 Iniciando automatización completa...
echo ⏱️  Esto tomará unos minutos...
echo.

REM Ejecutar script PowerShell completo
powershell -ExecutionPolicy Bypass -WindowStyle Normal -Command "& '%~dp0AUTOMATIZACION-PC-COMPLETA.ps1'"

echo.
echo 🎉 ¡AUTOMATIZACIÓN COMPLETA TERMINADA!
echo =====================================
echo.
echo ✅ Tu PC está ahora completamente automatizado
echo ✅ Se ejecutará automáticamente:
echo    • Al iniciar Windows
echo    • Diariamente a las 9:00 AM  
echo    • Al iniciar sesión
echo.
echo 📋 PRÓXIMOS PASOS MANUALES:
echo    1. Agregar clave SSH a cPanel
echo    2. Subir archivos a public_html
echo    3. Verificar: https://fimecompany.com
echo.
echo 📝 Revisa el log completo en:
echo    C:\Users\PC\.android\c panel\automatizacion-pc-completa.log
echo.
echo Presiona cualquier tecla para continuar...
pause >nul
