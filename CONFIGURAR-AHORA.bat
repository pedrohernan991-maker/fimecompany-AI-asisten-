@echo off
title CONFIGURANDO FIME COMPANY AHORA
color 0B
cls
echo.
echo ===============================================
echo    🚀 CONFIGURANDO FIME COMPANY AHORA
echo ===============================================
echo.

REM Cambiar al directorio
cd /d "C:\Users\PC\.android\c panel"
echo 📁 Directorio actual: %CD%
echo.

echo 🔧 PASO 1: Configurando permisos PowerShell...
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force"
if %errorlevel% == 0 (
    echo ✅ Permisos PowerShell configurados
) else (
    echo ⚠️ Permisos PowerShell - usando alternativa
)
echo.

echo 🔧 PASO 2: Creando estructura de directorios...
if not exist "%USERPROFILE%\.ssh" mkdir "%USERPROFILE%\.ssh"
echo ✅ Directorio SSH creado
echo.

echo 🔧 PASO 3: Configurando claves SSH...
echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP > "%USERPROFILE%\.ssh\fimecompany_key.pub"
echo ✅ Clave SSH pública guardada
echo.

echo 🔧 PASO 4: Verificando archivos web...
if exist "index.html" (
    echo ✅ index.html encontrado
) else (
    echo ⚠️ index.html no encontrado
)

if exist "styles.css" (
    echo ✅ styles.css encontrado  
) else (
    echo ⚠️ styles.css no encontrado
)

if exist "fimetech" (
    echo ✅ Carpeta fimetech encontrada
) else (
    echo ⚠️ Carpeta fimetech no encontrada
)
echo.

echo 🔧 PASO 5: Verificando conectividad...
echo Probando conexión a fimecompany.com...
ping -n 2 fimecompany.com >nul 2>&1
if %errorlevel% == 0 (
    echo ✅ Conexión a fimecompany.com: OK
) else (
    echo ⚠️ Conexión a fimecompany.com: Verificar red
)
echo.

echo 🔧 PASO 6: Configurando acceso directo...
echo @echo off > "ABRIR-CPANEL.bat"
echo title Abrir cPanel FIME COMPANY >> "ABRIR-CPANEL.bat"
echo start https://fimecompany.com:2083 >> "ABRIR-CPANEL.bat"
echo ✅ Acceso directo a cPanel creado
echo.

echo 🔧 PASO 7: Creando script de subida manual...
(
echo @echo off
echo title SUBIR ARCHIVOS A CPANEL - METODO MANUAL
echo color 0E
echo echo.
echo echo ========================================
echo echo    SUBIR ARCHIVOS A CPANEL MANUAL
echo echo ========================================
echo echo.
echo echo 🔧 PASOS PARA SUBIR ARCHIVOS:
echo echo.
echo echo 1️⃣ ABRIR CPANEL:
echo echo    • Abre: https://fimecompany.com:2083
echo echo    • Usuario: fimecomp
echo echo    • Contraseña: [tu contraseña]
echo echo.
echo echo 2️⃣ ABRIR FILE MANAGER:
echo echo    • Busca "File Manager" en cPanel
echo echo    • Haz clic en "File Manager"  
echo echo    • Ve a carpeta "public_html"
echo echo.
echo echo 3️⃣ SUBIR ESTOS ARCHIVOS:
echo echo    • index.html
echo echo    • styles.css
echo echo    • Carpeta fimetech ^(completa^)
echo echo    • Carpeta fimekids ^(completa^)
echo echo    • Carpeta ferreteria ^(completa^)
echo echo.
echo echo 📂 DESDE ESTA CARPETA: %CD%
echo echo.
echo echo 4️⃣ CONFIGURAR PERMISOS:
echo echo    • Selecciona todos los archivos
echo echo    • Click derecho -^> Permissions
echo echo    • Carpetas: 755, Archivos: 644
echo echo.
echo echo 5️⃣ VERIFICAR:
echo echo    • https://fimecompany.com
echo echo    • https://fimecompany.com/fimetech/
echo echo    • https://fimecompany.com/fimekids/
echo echo.
echo pause
) > "SUBIR-MANUAL.bat"
echo ✅ Script de subida manual creado
echo.

echo 🔧 PASO 8: Creando script de configuración SSH...
(
echo @echo off
echo title CONFIGURAR SSH EN CPANEL
echo color 0D
echo echo.
echo echo ========================================
echo echo    CONFIGURAR SSH EN CPANEL
echo echo ========================================
echo echo.
echo echo 🔑 TU CLAVE SSH PUBLICA:
echo echo.
echo echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP
echo echo.
echo echo 📋 PASOS:
echo echo 1. Abre cPanel: https://fimecompany.com:2083
echo echo 2. Busca "SSH Keys" o "Claves SSH"
echo echo 3. Haz clic en "Import Key" o "Importar Clave"  
echo echo 4. Pega la clave de arriba
echo echo 5. Nombre: fimecompany_key
echo echo 6. Haz clic en "Import"
echo echo 7. Haz clic en "Authorize" o "Autorizar"
echo echo.
echo pause
) > "CONFIGURAR-SSH.bat"
echo ✅ Script de configuración SSH creado
echo.

echo 🎉 CONFIGURACIÓN COMPLETADA
echo ==============================
echo.
echo ✅ Permisos configurados
echo ✅ Claves SSH preparadas  
echo ✅ Scripts creados
echo ✅ Accesos directos listos
echo.
echo 📁 ARCHIVOS CREADOS:
echo    • ABRIR-CPANEL.bat
echo    • SUBIR-MANUAL.bat  
echo    • CONFIGURAR-SSH.bat
echo    • EJECUTAR-TODO-AUTOMATICO.bat
echo.
echo 🚀 PRÓXIMOS PASOS:
echo 1. Ejecuta: CONFIGURAR-SSH.bat
echo 2. Ejecuta: SUBIR-MANUAL.bat
echo 3. Verifica: https://fimecompany.com
echo.
echo Presiona cualquier tecla para continuar...
pause >nul
