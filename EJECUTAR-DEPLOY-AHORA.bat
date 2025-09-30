@echo off
echo ========================================
echo   FIME COMPANY - DEPLOY AUTOMATICO
echo ========================================
echo.
echo Agregando archivos al repositorio...
echo.

REM Buscar Git en las ubicaciones comunes
set GIT_PATH=

if exist "C:\Program Files\Git\cmd\git.exe" (
    set GIT_PATH="C:\Program Files\Git\cmd\git.exe"
)

if exist "C:\Program Files (x86)\Git\cmd\git.exe" (
    set GIT_PATH="C:\Program Files (x86)\Git\cmd\git.exe"
)

if exist "%LOCALAPPDATA%\Programs\Git\cmd\git.exe" (
    set GIT_PATH="%LOCALAPPDATA%\Programs\Git\cmd\git.exe"
)

if "%GIT_PATH%"=="" (
    echo ERROR: Git no encontrado.
    echo Por favor, usa GitHub Desktop para hacer el commit y push.
    echo.
    echo 1. Abre GitHub Desktop
    echo 2. Selecciona el repositorio "fimecompany-AI-asisten-"
    echo 3. Escribe en Summary: "Corregir despliegue a public_html"
    echo 4. Haz clic en "Commit to main"
    echo 5. Haz clic en "Push origin"
    echo.
    pause
    exit /b 1
)

echo Git encontrado en: %GIT_PATH%
echo.

REM Agregar todos los archivos
%GIT_PATH% add .

REM Hacer commit
%GIT_PATH% commit -m "🔧 Corregir despliegue a public_html - Todas las carpetas restauradas"

REM Push al repositorio
%GIT_PATH% push origin main

echo.
echo ========================================
echo   DEPLOY COMPLETADO EXITOSAMENTE
echo ========================================
echo.
echo Visita https://fimecompany.com para ver los cambios
echo.
pause
