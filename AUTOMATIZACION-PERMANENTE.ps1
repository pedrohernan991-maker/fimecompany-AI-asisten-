# ===============================================
# AUTOMATIZACIÓN PERMANENTE CON POWERSHELL
# FIME COMPANY - Automatización que funciona siempre
# ===============================================

param(
    [string]$Accion = "completa",
    [switch]$Continuo = $false,
    [int]$Intervalo = 300  # 5 minutos por defecto
)

Write-Host "🔄 AUTOMATIZACIÓN PERMANENTE POWERSHELL" -ForegroundColor Cyan -BackgroundColor DarkBlue
Write-Host "=======================================" -ForegroundColor Yellow

# Configuración permanente
$script:CONFIG_PERMANENTE = @{
    "PROYECTO_DIR" = "C:\Users\PC\.android\c panel"
    "LOG_FILE" = "C:\Users\PC\.android\c panel\automatizacion-permanente.log"
    "HOST" = "fimecompany.com"
    "USER" = "fimecomp"
    "SSH_KEY" = "$env:USERPROFILE\.ssh\fimecompany_key"
    "BACKUP_DIR" = "C:\Users\PC\.android\backups"
    "ULTIMO_SYNC" = ""
}

# Función para logging permanente
function Write-LogPermanente {
    param($Mensaje, $Tipo = "INFO")
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Tipo] $Mensaje"
    
    # Escribir en consola
    switch ($Tipo) {
        "ERROR" { Write-Host $logEntry -ForegroundColor Red }
        "WARNING" { Write-Host $logEntry -ForegroundColor Yellow }
        "SUCCESS" { Write-Host $logEntry -ForegroundColor Green }
        default { Write-Host $logEntry -ForegroundColor White }
    }
    
    # Escribir en archivo log
    try {
        Add-Content -Path $script:CONFIG_PERMANENTE.LOG_FILE -Value $logEntry -ErrorAction SilentlyContinue
    } catch { }
}

# Función de configuración inicial permanente
function Initialize-AutomacionPermanente {
    Write-LogPermanente "🚀 Iniciando configuración permanente..."
    
    try {
        # Configurar PowerShell permanentemente
        Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
        Write-LogPermanente "✅ Execution Policy configurada permanentemente" "SUCCESS"
        
        # Crear directorios necesarios
        $dirs = @(
            $script:CONFIG_PERMANENTE.PROYECTO_DIR,
            (Split-Path $script:CONFIG_PERMANENTE.LOG_FILE),
            $script:CONFIG_PERMANENTE.BACKUP_DIR,
            "$env:USERPROFILE\.ssh"
        )
        
        foreach ($dir in $dirs) {
            if (!(Test-Path $dir)) {
                New-Item -ItemType Directory -Path $dir -Force | Out-Null
                Write-LogPermanente "✅ Directorio creado: $dir" "SUCCESS"
            }
        }
        
        # Configurar clave SSH permanentemente
        $sshKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWUOllsl8akAXn76BKADWCLZQ+vXiyK8SzjGlQKj68gVxuaaeQmoW7/EP+WSjf9zSEbPJvpUQLBdcqZSxo+jxOq0aO6zVjNAIxqGIli78LAez3ED4O5AHCaQ+xXTLIqJZSsie7VGoX2FkQw+jlzLd4QdRiqZoMUSLaQd7JI4/JLtVezqKajG6OBrcy232qLDzzVyuvUgcRjQibBhNgmguEjx78b8Zh2wgVD/gapLMIdR3VwABWr9Y5UUUd3N84XzBx4FJ99/nak8fBX+ikugQjWyrlpHxlgn+IL9HqKf2oTPq/FJ06tzlWPRDi0txC48+8Htchgz8Zke9+u7Z6PVOP"
        $sshKey | Out-File -FilePath "$env:USERPROFILE\.ssh\fimecompany_key.pub" -Encoding ASCII -Force
        Write-LogPermanente "✅ Clave SSH configurada permanentemente" "SUCCESS"
        
        return $true
    } catch {
        Write-LogPermanente "❌ Error en configuración inicial: $($_.Exception.Message)" "ERROR"
        return $false
    }
}

# Función de monitoreo permanente
function Start-MonitoreoPermanente {
    Write-LogPermanente "📊 Iniciando monitoreo permanente..."
    
    # Monitorear archivos locales
    $archivos = @("index.html", "styles.css", "fimetech\index.html", "fimekids\index.html", "ferreteria\index.html")
    
    foreach ($archivo in $archivos) {
        $rutaCompleta = Join-Path $script:CONFIG_PERMANENTE.PROYECTO_DIR $archivo
        if (Test-Path $rutaCompleta) {
            $ultimaModif = (Get-Item $rutaCompleta).LastWriteTime
            Write-LogPermanente "✅ $archivo - Última modificación: $ultimaModif" "SUCCESS"
        } else {
            Write-LogPermanente "⚠️ $archivo - NO ENCONTRADO" "WARNING"
        }
    }
    
    # Monitorear conectividad
    $puertos = @(22, 2222, 2083, 80, 443)
    
    foreach ($puerto in $puertos) {
        try {
            $test = Test-NetConnection -ComputerName $script:CONFIG_PERMANENTE.HOST -Port $puerto -WarningAction SilentlyContinue -InformationLevel Quiet
            if ($test.TcpTestSucceeded) {
                Write-LogPermanente "✅ Puerto $puerto - CONECTADO" "SUCCESS"
            } else {
                Write-LogPermanente "❌ Puerto $puerto - NO DISPONIBLE" "ERROR"
            }
        } catch {
            Write-LogPermanente "❌ Puerto $puerto - ERROR DE CONEXIÓN" "ERROR"
        }
    }
    
    # Monitorear sitio web
    $sitios = @("https://fimecompany.com", "https://fimecompany.com/fimetech/", "https://fimecompany.com/fimekids/")
    
    foreach ($sitio in $sitios) {
        try {
            $response = Invoke-WebRequest -Uri $sitio -Method Head -TimeoutSec 10 -ErrorAction Stop
            Write-LogPermanente "✅ $sitio - FUNCIONANDO (${($response.StatusCode)})" "SUCCESS"
        } catch {
            Write-LogPermanente "❌ $sitio - NO DISPONIBLE" "ERROR"
        }
    }
}

# Función de sincronización automática permanente
function Start-SincronizacionAutomatica {
    Write-LogPermanente "🔄 Iniciando sincronización automática..."
    
    try {
        # Verificar si SSH está disponible
        $sshTest = Test-NetConnection -ComputerName $script:CONFIG_PERMANENTE.HOST -Port 22 -WarningAction SilentlyContinue -InformationLevel Quiet
        
        if ($sshTest.TcpTestSucceeded) {
            Write-LogPermanente "✅ SSH disponible - Intentando sincronización automática" "SUCCESS"
            
            # Intentar sincronización via SSH
            $archivosASubir = @(
                @{Local="index.html"; Remoto="/public_html/index.html"},
                @{Local="styles.css"; Remoto="/public_html/styles.css"}
            )
            
            foreach ($archivo in $archivosASubir) {
                $localPath = Join-Path $script:CONFIG_PERMANENTE.PROYECTO_DIR $archivo.Local
                
                if (Test-Path $localPath) {
                    try {
                        # Usar SCP si está disponible
                        if (Get-Command scp -ErrorAction SilentlyContinue) {
                            $scpCommand = "scp -i `"$($script:CONFIG_PERMANENTE.SSH_KEY)`" `"$localPath`" `"$($script:CONFIG_PERMANENTE.USER)@$($script:CONFIG_PERMANENTE.HOST):$($archivo.Remoto)`""
                            Invoke-Expression $scpCommand
                            
                            if ($LASTEXITCODE -eq 0) {
                                Write-LogPermanente "✅ $($archivo.Local) sincronizado automáticamente" "SUCCESS"
                            } else {
                                Write-LogPermanente "⚠️ $($archivo.Local) - Error en sincronización automática" "WARNING"
                            }
                        }
                    } catch {
                        Write-LogPermanente "⚠️ Error sincronizando $($archivo.Local): $($_.Exception.Message)" "WARNING"
                    }
                }
            }
        } else {
            Write-LogPermanente "⚠️ SSH no disponible - Sincronización manual requerida" "WARNING"
        }
        
        # Actualizar timestamp
        $script:CONFIG_PERMANENTE.ULTIMO_SYNC = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Write-LogPermanente "📅 Última sincronización: $($script:CONFIG_PERMANENTE.ULTIMO_SYNC)" "INFO"
        
    } catch {
        Write-LogPermanente "❌ Error en sincronización: $($_.Exception.Message)" "ERROR"
    }
}

# Función de backup automático permanente
function Start-BackupAutomatico {
    Write-LogPermanente "💾 Iniciando backup automático..."
    
    try {
        $backupName = "fimecompany_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
        $backupPath = Join-Path $script:CONFIG_PERMANENTE.BACKUP_DIR "$backupName.zip"
        
        # Crear backup local
        if (Test-Path $script:CONFIG_PERMANENTE.PROYECTO_DIR) {
            Compress-Archive -Path "$($script:CONFIG_PERMANENTE.PROYECTO_DIR)\*" -DestinationPath $backupPath -Force
            Write-LogPermanente "✅ Backup local creado: $backupPath" "SUCCESS"
            
            # Limpiar backups antiguos (mantener solo los últimos 10)
            $backupsAntiguos = Get-ChildItem $script:CONFIG_PERMANENTE.BACKUP_DIR -Filter "fimecompany_backup_*.zip" | Sort-Object LastWriteTime -Descending | Select-Object -Skip 10
            
            foreach ($backup in $backupsAntiguos) {
                Remove-Item $backup.FullName -Force
                Write-LogPermanente "🗑️ Backup antiguo eliminado: $($backup.Name)" "INFO"
            }
        }
    } catch {
        Write-LogPermanente "❌ Error en backup: $($_.Exception.Message)" "ERROR"
    }
}

# Función de automatización continua
function Start-AutomacionContinua {
    Write-LogPermanente "🔄 Iniciando automatización continua..."
    Write-LogPermanente "⏱️ Intervalo: $Intervalo segundos" "INFO"
    
    while ($true) {
        try {
            Write-LogPermanente "🔄 Ejecutando ciclo de automatización..." "INFO"
            
            # Monitoreo
            Start-MonitoreoPermanente
            
            # Sincronización cada 5 ciclos
            if ((Get-Random -Maximum 5) -eq 0) {
                Start-SincronizacionAutomatica
            }
            
            # Backup cada 20 ciclos
            if ((Get-Random -Maximum 20) -eq 0) {
                Start-BackupAutomatico
            }
            
            Write-LogPermanente "✅ Ciclo completado - Esperando $Intervalo segundos..." "SUCCESS"
            Start-Sleep -Seconds $Intervalo
            
        } catch {
            Write-LogPermanente "❌ Error en automatización continua: $($_.Exception.Message)" "ERROR"
            Start-Sleep -Seconds 60  # Esperar 1 minuto antes de reintentar
        }
    }
}

# Función para crear tarea programada permanente
function New-TareaProgramadaPermanente {
    Write-LogPermanente "📅 Creando tarea programada permanente..."
    
    try {
        $scriptPath = $PSCommandPath
        $taskName = "FIME_COMPANY_Automatizacion_Permanente"
        
        # Eliminar tarea existente si existe
        try {
            Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
        } catch { }
        
        # Crear nueva tarea
        $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$scriptPath`" -Accion continua -Continuo"
        $trigger = New-ScheduledTaskTrigger -AtStartup
        $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
        
        Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Description "Automatización permanente FIME COMPANY"
        
        Write-LogPermanente "✅ Tarea programada creada: $taskName" "SUCCESS"
        
    } catch {
        Write-LogPermanente "❌ Error creando tarea programada: $($_.Exception.Message)" "ERROR"
    }
}

# Función principal
function Start-AutomacionPermanente {
    param($AccionEspecifica = "completa")
    
    Write-LogPermanente "🚀 AUTOMATIZACIÓN PERMANENTE INICIADA" "INFO"
    Write-LogPermanente "Acción: $AccionEspecifica" "INFO"
    
    # Inicialización
    if (!(Initialize-AutomacionPermanente)) {
        Write-LogPermanente "❌ Error en inicialización - Abortando" "ERROR"
        return $false
    }
    
    # Cambiar al directorio de trabajo
    Set-Location $script:CONFIG_PERMANENTE.PROYECTO_DIR
    
    switch ($AccionEspecifica) {
        "completa" {
            Write-LogPermanente "🎯 Ejecutando automatización completa..." "INFO"
            Start-MonitoreoPermanente
            Start-SincronizacionAutomatica
            Start-BackupAutomatico
        }
        
        "monitoreo" {
            Write-LogPermanente "📊 Ejecutando solo monitoreo..." "INFO"
            Start-MonitoreoPermanente
        }
        
        "sincronizacion" {
            Write-LogPermanente "🔄 Ejecutando solo sincronización..." "INFO"
            Start-SincronizacionAutomatica
        }
        
        "backup" {
            Write-LogPermanente "💾 Ejecutando solo backup..." "INFO"
            Start-BackupAutomatico
        }
        
        "continua" {
            Write-LogPermanente "🔄 Ejecutando automatización continua..." "INFO"
            Start-AutomacionContinua
        }
        
        "tarea" {
            Write-LogPermanente "📅 Creando tarea programada..." "INFO"
            New-TareaProgramadaPermanente
        }
        
        default {
            Write-LogPermanente "⚠️ Acción no reconocida: $AccionEspecifica" "WARNING"
            Start-MonitoreoPermanente
        }
    }
    
    Write-LogPermanente "✅ AUTOMATIZACIÓN PERMANENTE COMPLETADA" "SUCCESS"
    return $true
}

# Manejo de parámetros y ejecución
Write-Host ""
Write-Host "📋 PARÁMETROS DE AUTOMATIZACIÓN PERMANENTE:" -ForegroundColor Yellow
Write-Host "   • Acción: $Accion" -ForegroundColor White
Write-Host "   • Continuo: $Continuo" -ForegroundColor White
Write-Host "   • Intervalo: $Intervalo segundos" -ForegroundColor White

if ($Continuo) {
    Write-Host ""
    Write-Host "🔄 MODO CONTINUO ACTIVADO - Presiona Ctrl+C para detener" -ForegroundColor Yellow
    Start-AutomacionPermanente -AccionEspecifica "continua"
} else {
    Start-AutomacionPermanente -AccionEspecifica $Accion
}

Write-Host ""
Write-Host "📋 COMANDOS DISPONIBLES:" -ForegroundColor Yellow
Write-Host "   .\AUTOMATIZACION-PERMANENTE.ps1 -Accion completa" -ForegroundColor White
Write-Host "   .\AUTOMATIZACION-PERMANENTE.ps1 -Accion continua -Continuo" -ForegroundColor White
Write-Host "   .\AUTOMATIZACION-PERMANENTE.ps1 -Accion tarea" -ForegroundColor White
Write-Host "   .\AUTOMATIZACION-PERMANENTE.ps1 -Accion monitoreo" -ForegroundColor White
Write-Host ""
Write-Host "📝 Log file: $($script:CONFIG_PERMANENTE.LOG_FILE)" -ForegroundColor Cyan
