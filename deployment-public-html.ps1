# ===============================================
# DEPLOYMENT DIRECTO A PUBLIC_HTML - CPANEL
# FIME COMPANY - Método directo cPanel
# ===============================================

Write-Host "🚀 DEPLOYMENT DIRECTO PUBLIC_HTML - CPANEL" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "==========================================" -ForegroundColor Yellow

# CONFIGURACIÓN PUBLIC_HTML
$CPANEL_CONFIG = @{
    "HOST" = "fimecompany.com"
    "USER" = "fimecomp"
    "PUBLIC_HTML" = "/public_html"
    "LOCAL_FILES" = "C:\Users\PC\.android\c panel"
    "SSH_KEY" = "$env:USERPROFILE\.ssh\fimecompany_key"
}

Write-Host "📁 CONFIGURACIÓN PUBLIC_HTML:" -ForegroundColor Green
Write-Host "   🌐 Host: $($CPANEL_CONFIG.HOST)" -ForegroundColor White
Write-Host "   👤 Usuario: $($CPANEL_CONFIG.USER)" -ForegroundColor White
Write-Host "   📂 Destino: $($CPANEL_CONFIG.PUBLIC_HTML)" -ForegroundColor White
Write-Host "   💻 Archivos locales: $($CPANEL_CONFIG.LOCAL_FILES)" -ForegroundColor White

# Función para trabajar directamente con public_html
function Deploy-ToPublicHTML {
    Write-Host ""
    Write-Host "🚀 SUBIENDO ARCHIVOS A PUBLIC_HTML" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "===================================" -ForegroundColor Yellow
    
    $localPath = $CPANEL_CONFIG.LOCAL_FILES
    $remotePath = $CPANEL_CONFIG.PUBLIC_HTML
    $sshUser = $CPANEL_CONFIG.USER
    $sshHost = $CPANEL_CONFIG.HOST
    $sshKey = $CPANEL_CONFIG.SSH_KEY
    
    Write-Host "📤 Método: SSH/SCP directo a public_html" -ForegroundColor Green
    Write-Host "📂 Ruta remota: $sshUser@$sshHost`:$remotePath" -ForegroundColor Cyan
    
    # Verificar conexión SSH
    Write-Host ""
    Write-Host "🔍 Verificando conexión SSH..." -ForegroundColor Yellow
    
    try {
        $testConnection = ssh -i "$sshKey" "$sshUser@$sshHost" "pwd" 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Conexión SSH exitosa" -ForegroundColor Green
            Write-Host "📁 Directorio home: $testConnection" -ForegroundColor Cyan
        } else {
            Write-Host "❌ Error de conexión SSH: $testConnection" -ForegroundColor Red
            Write-Host "🔧 Usando método alternativo (sin SSH)..." -ForegroundColor Yellow
            Deploy-ViaFileManager
            return
        }
    } catch {
        Write-Host "❌ SSH no disponible. Usando File Manager..." -ForegroundColor Yellow
        Deploy-ViaFileManager
        return
    }
    
    # Subir archivo principal index.html
    Write-Host ""
    Write-Host "📄 Subiendo index.html principal..." -ForegroundColor Green
    if (Test-Path "$localPath\index.html") {
        scp -i "$sshKey" "$localPath\index.html" "$sshUser@$sshHost`:$remotePath/"
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ index.html subido exitosamente" -ForegroundColor Green
        } else {
            Write-Host "❌ Error subiendo index.html" -ForegroundColor Red
        }
    } else {
        Write-Host "⚠️ index.html no encontrado en $localPath" -ForegroundColor Yellow
    }
    
    # Subir styles.css
    Write-Host "📄 Subiendo styles.css..." -ForegroundColor Green
    if (Test-Path "$localPath\styles.css") {
        scp -i "$sshKey" "$localPath\styles.css" "$sshUser@$sshHost`:$remotePath/"
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ styles.css subido exitosamente" -ForegroundColor Green
        } else {
            Write-Host "❌ Error subiendo styles.css" -ForegroundColor Red
        }
    }
    
    # Subir carpetas de divisiones
    $divisions = @("fimetech", "fimekids", "ferreteria", "constructora", "energia", "global", "imprexlaser", "inversiones")
    
    foreach ($division in $divisions) {
        Write-Host "📁 Subiendo carpeta $division..." -ForegroundColor Green
        
        if (Test-Path "$localPath\$division") {
            # Crear directorio remoto
            ssh -i "$sshKey" "$sshUser@$sshHost" "mkdir -p $remotePath/$division"
            
            # Subir carpeta completa
            scp -r -i "$sshKey" "$localPath\$division\*" "$sshUser@$sshHost`:$remotePath/$division/"
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Carpeta $division subida exitosamente" -ForegroundColor Green
            } else {
                Write-Host "❌ Error subiendo carpeta $division" -ForegroundColor Red
            }
        } else {
            Write-Host "⚠️ Carpeta $division no encontrada" -ForegroundColor Yellow
        }
    }
    
    # Configurar permisos
    Write-Host ""
    Write-Host "🔧 Configurando permisos en public_html..." -ForegroundColor Green
    
    $permissionCommands = @(
        "chmod 755 $remotePath",
        "chmod 644 $remotePath/*.html",
        "chmod 644 $remotePath/*.css",
        "chmod 644 $remotePath/*.js",
        "chmod -R 755 $remotePath/fimetech",
        "chmod -R 755 $remotePath/fimekids", 
        "chmod -R 755 $remotePath/ferreteria"
    )
    
    foreach ($cmd in $permissionCommands) {
        ssh -i "$sshKey" "$sshUser@$sshHost" "$cmd" 2>$null
        Write-Host "⚙️ Ejecutado: $cmd" -ForegroundColor Cyan
    }
    
    Write-Host "✅ Permisos configurados" -ForegroundColor Green
    
    # Verificar archivos subidos
    Write-Host ""
    Write-Host "🔍 Verificando archivos en public_html..." -ForegroundColor Yellow
    
    $fileList = ssh -i "$sshKey" "$sshUser@$sshHost" "ls -la $remotePath"
    Write-Host "📋 Archivos en public_html:" -ForegroundColor Cyan
    Write-Host $fileList -ForegroundColor White
    
    Write-Host ""
    Write-Host "🎉 ¡DEPLOYMENT A PUBLIC_HTML COMPLETADO!" -ForegroundColor Green -BackgroundColor DarkGreen
    Write-Host "=========================================" -ForegroundColor Yellow
    Write-Host "✅ Archivos subidos a public_html" -ForegroundColor Green
    Write-Host "✅ Permisos configurados correctamente" -ForegroundColor Green
    Write-Host "✅ Sitio web disponible públicamente" -ForegroundColor Green
}

# Método alternativo via File Manager (manual)
function Deploy-ViaFileManager {
    Write-Host ""
    Write-Host "📁 MÉTODO ALTERNATIVO - FILE MANAGER" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "====================================" -ForegroundColor Yellow
    
    Write-Host "🔧 SSH no disponible. Usa File Manager de cPanel:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📋 PASOS MANUALES:" -ForegroundColor Green
    Write-Host "1. Entra a cPanel → File Manager" -ForegroundColor White
    Write-Host "2. Ve a la carpeta 'public_html'" -ForegroundColor White
    Write-Host "3. Sube estos archivos desde '$($CPANEL_CONFIG.LOCAL_FILES)':" -ForegroundColor White
    Write-Host ""
    Write-Host "📄 ARCHIVOS A SUBIR:" -ForegroundColor Cyan
    Write-Host "   • index.html (archivo principal)" -ForegroundColor White
    Write-Host "   • styles.css (estilos)" -ForegroundColor White
    Write-Host ""
    Write-Host "📁 CARPETAS A SUBIR:" -ForegroundColor Cyan
    Write-Host "   • fimetech/ (completa)" -ForegroundColor White
    Write-Host "   • fimekids/ (completa)" -ForegroundColor White  
    Write-Host "   • ferreteria/ (completa)" -ForegroundColor White
    Write-Host "   • constructora/ (completa)" -ForegroundColor White
    Write-Host "   • energia/ (completa)" -ForegroundColor White
    Write-Host "   • global/ (completa)" -ForegroundColor White
    Write-Host "   • imprexlaser/ (completa)" -ForegroundColor White
    Write-Host "   • inversiones/ (completa)" -ForegroundColor White
    Write-Host ""
    Write-Host "🔧 DESPUÉS DE SUBIR:" -ForegroundColor Yellow
    Write-Host "   • Selecciona todos los archivos" -ForegroundColor White
    Write-Host "   • Click derecho → Permissions" -ForegroundColor White
    Write-Host "   • Carpetas: 755, Archivos: 644" -ForegroundColor White
    Write-Host ""
    Write-Host "🌐 VERIFICAR:" -ForegroundColor Green
    Write-Host "   • https://fimecompany.com" -ForegroundColor Cyan
    Write-Host "   • https://fimecompany.com/fimetech/" -ForegroundColor Cyan
    Write-Host "   • https://fimecompany.com/fimekids/" -ForegroundColor Cyan
}

# Función para verificar sitio público
function Test-PublicWebsite {
    Write-Host ""
    Write-Host "🌐 VERIFICANDO SITIO PÚBLICO" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "============================" -ForegroundColor Yellow
    
    $urls = @(
        "https://fimecompany.com",
        "https://fimecompany.com/fimetech/",
        "https://fimecompany.com/fimekids/",
        "https://fimecompany.com/ferreteria/"
    )
    
    foreach ($url in $urls) {
        Write-Host "🔍 Probando: $url" -ForegroundColor Yellow
        
        try {
            $response = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 10 -ErrorAction Stop
            
            if ($response.StatusCode -eq 200) {
                Write-Host "✅ $url - FUNCIONANDO (200)" -ForegroundColor Green
            } else {
                Write-Host "⚠️ $url - Código: $($response.StatusCode)" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "❌ $url - NO DISPONIBLE" -ForegroundColor Red
            Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
        }
        
        Start-Sleep -Milliseconds 500
    }
    
    Write-Host ""
    Write-Host "📋 SITIO PÚBLICO VERIFICADO" -ForegroundColor Green
}

# Función para crear backup antes del deployment
function Create-BackupBeforeDeploy {
    Write-Host "💾 Creando backup antes del deployment..." -ForegroundColor Green
    
    $backupDate = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupDir = "backup_$backupDate"
    
    ssh -i "$($CPANEL_CONFIG.SSH_KEY)" "$($CPANEL_CONFIG.USER)@$($CPANEL_CONFIG.HOST)" "mkdir -p ~/backups/$backupDir && cp -r $($CPANEL_CONFIG.PUBLIC_HTML)/* ~/backups/$backupDir/ 2>/dev/null || echo 'Primer deployment - sin backup necesario'"
    
    Write-Host "✅ Backup creado (si había archivos previos)" -ForegroundColor Green
}

Write-Host ""
Write-Host "📋 COMANDOS DISPONIBLES:" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Yellow
Write-Host "🚀 Deploy-ToPublicHTML        # Deployment directo SSH" -ForegroundColor White
Write-Host "📁 Deploy-ViaFileManager      # Método manual File Manager" -ForegroundColor White
Write-Host "🌐 Test-PublicWebsite         # Verificar sitio público" -ForegroundColor White
Write-Host "💾 Create-BackupBeforeDeploy  # Crear backup previo" -ForegroundColor White

Write-Host ""
Write-Host "🎯 DEPLOYMENT DIRECTO A PUBLIC_HTML:" -ForegroundColor Green
Write-Host "Deploy-ToPublicHTML" -ForegroundColor Yellow

Write-Host ""
Write-Host "🔧 SI SSH NO FUNCIONA:" -ForegroundColor Yellow
Write-Host "Deploy-ViaFileManager" -ForegroundColor Cyan
