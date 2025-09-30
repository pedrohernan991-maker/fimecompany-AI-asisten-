@echo off
echo ========================================
echo COPIANDO ARCHIVOS A FIMECOMPANY-AI-ASISTEN
echo ========================================
echo.

REM Verificar que existe la carpeta del repositorio
if not exist "C:\Users\PC\Desktop\fimecompany-AI-asisten" (
    echo ERROR: No se encuentra la carpeta del repositorio
    echo Asegurate de haber clonado fimecompany-AI-asisten en el Desktop
    pause
    exit /b 1
)

echo Copiando archivos desde "c panel" a "fimecompany-AI-asisten"...
echo.

REM Copiar todos los archivos y carpetas
xcopy "C:\Users\PC\.android\c panel\*" "C:\Users\PC\Desktop\fimecompany-AI-asisten\" /E /H /Y /I

echo.
echo ========================================
echo ARCHIVOS COPIADOS EXITOSAMENTE
echo ========================================
echo.
echo Ahora ve a GitHub Desktop y:
echo 1. Selecciona el repositorio fimecompany-AI-asisten
echo 2. Veras todos los archivos nuevos en "Changes"
echo 3. Escribe un mensaje de commit: "Actualizacion completa FIME COMPANY"
echo 4. Haz clic en "Commit to main"
echo 5. Haz clic en "Push origin" para desplegar a cPanel
echo.
echo El despliegue sera automatico via GitHub Actions
echo.
pause
echo ========================================
echo COPIANDO ARCHIVOS A FIMECOMPANY-AI-ASISTEN
echo ========================================
echo.

REM Verificar que existe la carpeta del repositorio
if not exist "C:\Users\PC\Desktop\fimecompany-AI-asisten" (
    echo ERROR: No se encuentra la carpeta fimecompany-AI-asisten en el Desktop
    echo Asegurate de haber clonado el repositorio correctamente
    pause
    exit /b 1
)

echo Copiando archivos desde "c panel" a "fimecompany-AI-asisten"...
echo.

REM Copiar todos los archivos y carpetas
xcopy "C:\Users\PC\.android\c panel\*" "C:\Users\PC\Desktop\fimecompany-AI-asisten\" /E /H /Y /I

echo.
echo ========================================
echo ARCHIVOS COPIADOS EXITOSAMENTE
echo ========================================
echo.
echo Ahora ve a GitHub Desktop y:
echo 1. Selecciona el repositorio "fimecompany-AI-asisten"
echo 2. Veras todos los archivos nuevos en "Changes"
echo 3. Escribe un mensaje de commit: "Actualizacion completa FIME COMPANY"
echo 4. Haz clic en "Commit to main"
echo 5. Haz clic en "Push origin" para desplegar a cPanel
echo.
echo El despliegue automatico tomara unos minutos
echo.
pause
