@echo off
title FIME COMPANY - EJECUCION AUTOMATICA TOTAL
color 0A
echo.
echo ========================================
echo    FIME COMPANY - EJECUTANDO TODO
echo ========================================
echo.
echo 🚀 Iniciando ejecucion automatica...
echo.

REM Cambiar al directorio correcto
cd /d "C:\Users\PC\.android\c panel"
echo 📁 Directorio: %CD%
echo.

echo 🔍 Ejecutando verificacion completa automatica...
echo.

REM Ejecutar PowerShell con el script automatico
powershell -ExecutionPolicy Bypass -WindowStyle Normal -Command "& '%~dp0cursor-auto-ejecutar.ps1'"

echo.
echo ✅ Ejecucion automatica completada
echo.
echo 📋 Revisa los resultados arriba
echo.
echo Presiona cualquier tecla para continuar...
pause >nul
