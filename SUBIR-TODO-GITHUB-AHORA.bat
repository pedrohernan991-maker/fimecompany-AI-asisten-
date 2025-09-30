@echo off
echo ========================================
echo   SUBIR TODO A GITHUB - FIME COMPANY
echo ========================================
echo.

REM Buscar Git que viene con GitHub Desktop
set GIT_PATH=

if exist "%LOCALAPPDATA%\GitHubDesktop\app-*\resources\app\git\cmd\git.exe" (
    for /d %%i in ("%LOCALAPPDATA%\GitHubDesktop\app-*") do (
        if exist "%%i\resources\app\git\cmd\git.exe" (
            set GIT_PATH="%%i\resources\app\git\cmd\git.exe"
        )
    )
)

if "%GIT_PATH%"=="" (
    if exist "%LOCALAPPDATA%\Programs\Git\cmd\git.exe" (
        set GIT_PATH="%LOCALAPPDATA%\Programs\Git\cmd\git.exe"
    )
)

if exist "C:\Program Files\Git\cmd\git.exe" (
    set GIT_PATH="C:\Program Files\Git\cmd\git.exe"
)

if "%GIT_PATH%"=="" (
    echo ❌ ERROR: No se encontró Git.
    echo.
    echo 📝 SOLUCIÓN MANUAL:
    echo 1. Abre GitHub Desktop
    echo 2. Ve a Repository → Show in Explorer
    echo 3. Verifica que veas todas las carpetas (public_html, ferreteria, etc.)
    echo 4. En GitHub Desktop, marca todos los archivos en "Changes"
    echo 5. Escribe en Summary: "Subir todas las carpetas FIME COMPANY"
    echo 6. Haz clic en "Commit to main"
    echo 7. Haz clic en "Push origin"
    echo.
    pause
    exit /b 1
)

echo ✅ Git encontrado
echo.
echo 📂 Agregando TODOS los archivos...
%GIT_PATH% add -A

echo.
echo 💾 Haciendo commit...
%GIT_PATH% commit -m "🚀 Subir todas las carpetas FIME COMPANY - public_html completo"

echo.
echo 🌐 Subiendo a GitHub...
%GIT_PATH% push origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo   ✅ SUBIDA EXITOSA A GITHUB
    echo ========================================
    echo.
    echo 🔄 GitHub Actions desplegará automáticamente
    echo 🌐 Visita: https://github.com/tu-usuario/fimecompany-AI-asisten-/actions
    echo.
) else (
    echo.
    echo ❌ ERROR al subir a GitHub
    echo.
    echo Posibles soluciones:
    echo 1. Verifica tu conexión a Internet
    echo 2. Usa GitHub Desktop manualmente
    echo.
)

pause


