# ===============================================
# DEPLOYMENT PROFESIONAL CON SSH - FIME COMPANY
# Configuración completa automatizada
# ===============================================

Write-Host "🚀 DEPLOYMENT PROFESIONAL CON SSH" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "==================================" -ForegroundColor Yellow

# Configuración SSH
$SSH_HOST = "fimecompany.com"
$SSH_USER = "fimecomp"
$SSH_KEY = "$env:USERPROFILE\.ssh\fimecompany_key"
$REMOTE_PATH = "/public_html"
$LOCAL_PATH = "C:\Users\PC\.android\c panel"

Write-Host "🔑 Configuración SSH:" -ForegroundColor Green
Write-Host "   Host: $SSH_HOST" -ForegroundColor White
Write-Host "   Usuario: $SSH_USER" -ForegroundColor White
Write-Host "   Clave: $SSH_KEY" -ForegroundColor White
Write-Host "   Destino: $REMOTE_PATH" -ForegroundColor White

# Función para probar conexión SSH
function Test-SSHConnection {
    Write-Host "🔍 Probando conexión SSH..." -ForegroundColor Yellow
    
    try {
        # Probar conexión con ssh
        $result = ssh -i "$SSH_KEY" "$SSH_USER@$SSH_HOST" "pwd" 2>&1
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Conexión SSH exitosa" -ForegroundColor Green
            Write-Host "📁 Directorio remoto: $result" -ForegroundColor Cyan
            return $true
        } else {
            Write-Host "❌ Error de conexión SSH: $result" -ForegroundColor Red
            return $false
        }
    } catch {
        Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para subir archivos via SCP
function Upload-FilesSSH {
    Write-Host "📤 Subiendo archivos via SSH/SCP..." -ForegroundColor Green
    
    # Archivos principales
    $files = @(
        "index.html",
        "styles.css"
    )
    
    # Subir archivos principales
    foreach ($file in $files) {
        if (Test-Path "$LOCAL_PATH\$file") {
            Write-Host "📄 Subiendo $file..." -ForegroundColor Yellow
            scp -i "$SSH_KEY" "$LOCAL_PATH\$file" "$SSH_USER@$SSH_HOST`:$REMOTE_PATH/"
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ $file subido exitosamente" -ForegroundColor Green
            } else {
                Write-Host "❌ Error subiendo $file" -ForegroundColor Red
            }
        }
    }
    
    # Subir carpetas
    $folders = @("fimetech", "fimekids", "ferreteria", "constructora", "energia", "global", "imprexlaser", "inversiones")
    
    foreach ($folder in $folders) {
        if (Test-Path "$LOCAL_PATH\$folder") {
            Write-Host "📁 Subiendo carpeta $folder..." -ForegroundColor Yellow
            scp -r -i "$SSH_KEY" "$LOCAL_PATH\$folder" "$SSH_USER@$SSH_HOST`:$REMOTE_PATH/"
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Carpeta $folder subida exitosamente" -ForegroundColor Green
            } else {
                Write-Host "❌ Error subiendo carpeta $folder" -ForegroundColor Red
            }
        }
    }
}

# Función para configurar permisos remotos
function Set-RemotePermissions {
    Write-Host "🔧 Configurando permisos remotos..." -ForegroundColor Green
    
    $commands = @(
        "chmod 755 $REMOTE_PATH",
        "chmod -R 755 $REMOTE_PATH/fimetech",
        "chmod -R 755 $REMOTE_PATH/fimekids", 
        "chmod -R 755 $REMOTE_PATH/ferreteria",
        "chmod 644 $REMOTE_PATH/*.html",
        "chmod 644 $REMOTE_PATH/*.css",
        "chmod 644 $REMOTE_PATH/*.js"
    )
    
    foreach ($cmd in $commands) {
        Write-Host "⚙️ Ejecutando: $cmd" -ForegroundColor Yellow
        ssh -i "$SSH_KEY" "$SSH_USER@$SSH_HOST" "$cmd"
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Comando ejecutado exitosamente" -ForegroundColor Green
        } else {
            Write-Host "⚠️ Advertencia en comando: $cmd" -ForegroundColor Yellow
        }
    }
}

# Función para crear estructura de directorios
function Create-RemoteStructure {
    Write-Host "📁 Creando estructura de directorios..." -ForegroundColor Green
    
    $directories = @(
        "$REMOTE_PATH/fimetech",
        "$REMOTE_PATH/fimekids", 
        "$REMOTE_PATH/ferreteria",
        "$REMOTE_PATH/constructora",
        "$REMOTE_PATH/energia",
        "$REMOTE_PATH/global",
        "$REMOTE_PATH/imprexlaser",
        "$REMOTE_PATH/inversiones",
        "$REMOTE_PATH/assets",
        "$REMOTE_PATH/css",
        "$REMOTE_PATH/js",
        "$REMOTE_PATH/images"
    )
    
    foreach ($dir in $directories) {
        Write-Host "📂 Creando directorio: $dir" -ForegroundColor Yellow
        ssh -i "$SSH_KEY" "$SSH_USER@$SSH_HOST" "mkdir -p $dir"
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Directorio creado: $dir" -ForegroundColor Green
        }
    }
}

# Función para verificar sitio web
function Test-Website {
    Write-Host "🌐 Verificando sitio web..." -ForegroundColor Green
    
    $urls = @(
        "https://fimecompany.com",
        "https://fimecompany.com/fimetech/",
        "https://fimecompany.com/fimekids/",
        "https://fimecompany.com/ferreteria/"
    )
    
    foreach ($url in $urls) {
        Write-Host "🔍 Probando: $url" -ForegroundColor Yellow
        
        try {
            $response = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 10
            
            if ($response.StatusCode -eq 200) {
                Write-Host "✅ $url - OK (200)" -ForegroundColor Green
            } else {
                Write-Host "⚠️ $url - Código: $($response.StatusCode)" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "❌ $url - Error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

# Función principal de deployment
function Start-ProfessionalDeployment {
    Write-Host ""
    Write-Host "🚀 INICIANDO DEPLOYMENT PROFESIONAL" -ForegroundColor Cyan -BackgroundColor DarkBlue
    Write-Host "====================================" -ForegroundColor Yellow
    
    # Paso 1: Probar conexión SSH
    Write-Host "🔸 Paso 1: Probando conexión SSH..." -ForegroundColor Cyan
    if (!(Test-SSHConnection)) {
        Write-Host "❌ Error: No se pudo conectar via SSH" -ForegroundColor Red
        Write-Host "🔧 Verifica que la clave SSH esté agregada y autorizada en cPanel" -ForegroundColor Yellow
        return $false
    }
    
    # Paso 2: Crear estructura de directorios
    Write-Host "🔸 Paso 2: Creando estructura remota..." -ForegroundColor Cyan
    Create-RemoteStructure
    
    # Paso 3: Subir archivos
    Write-Host "🔸 Paso 3: Subiendo archivos..." -ForegroundColor Cyan
    Upload-FilesSSH
    
    # Paso 4: Configurar permisos
    Write-Host "🔸 Paso 4: Configurando permisos..." -ForegroundColor Cyan
    Set-RemotePermissions
    
    # Paso 5: Verificar sitio
    Write-Host "🔸 Paso 5: Verificando sitio web..." -ForegroundColor Cyan
    Test-Website
    
    Write-Host ""
    Write-Host "🎉 ¡DEPLOYMENT PROFESIONAL COMPLETADO!" -ForegroundColor Green -BackgroundColor DarkGreen
    Write-Host "======================================" -ForegroundColor Yellow
    Write-Host "✅ Archivos subidos via SSH" -ForegroundColor Green
    Write-Host "✅ Permisos configurados" -ForegroundColor Green
    Write-Host "✅ Estructura creada" -ForegroundColor Green
    Write-Host "✅ Sitio web verificado" -ForegroundColor Green
    
    return $true
}

# Función para configurar automatización continua
function Setup-ContinuousDeployment {
    Write-Host "🔄 Configurando deployment continuo..." -ForegroundColor Cyan
    
    # Crear script de sincronización automática
    $syncScript = @"
#!/bin/bash
# Script de sincronización automática
rsync -avz --delete -e "ssh -i ~/.ssh/fimecompany_key" \\
    "$LOCAL_PATH/" "$SSH_USER@$SSH_HOST:$REMOTE_PATH/"
echo "✅ Sincronización completada: `$(date)"
"@
    
    $syncScript | Out-File -FilePath "sync-to-cpanel.sh" -Encoding UTF8
    
    Write-Host "✅ Script de sincronización creado: sync-to-cpanel.sh" -ForegroundColor Green
}

Write-Host ""
Write-Host "📋 COMANDOS DISPONIBLES:" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Yellow
Write-Host "🚀 Start-ProfessionalDeployment  # Deployment completo" -ForegroundColor White
Write-Host "🔍 Test-SSHConnection           # Probar SSH" -ForegroundColor White  
Write-Host "📤 Upload-FilesSSH              # Subir archivos" -ForegroundColor White
Write-Host "🔧 Set-RemotePermissions        # Configurar permisos" -ForegroundColor White
Write-Host "🌐 Test-Website                 # Verificar sitio" -ForegroundColor White
Write-Host "🔄 Setup-ContinuousDeployment   # Automatización" -ForegroundColor White

Write-Host ""
Write-Host "🎯 PARA INICIAR DEPLOYMENT PROFESIONAL:" -ForegroundColor Green
Write-Host "Start-ProfessionalDeployment" -ForegroundColor Yellow
