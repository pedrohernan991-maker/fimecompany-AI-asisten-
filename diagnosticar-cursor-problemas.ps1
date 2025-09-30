# DIAGNOSTICAR PROBLEMAS DE CURSOR
Write-Host "DIAGNOSTICAR PROBLEMAS DE CURSOR" -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Verificando estado de Cursor..." -ForegroundColor Yellow

# 1. Verificar si Cursor está ejecutándose
$cursorProcesses = Get-Process | Where-Object {$_.ProcessName -like "*cursor*"}
if ($cursorProcesses) {
    Write-Host "✅ Cursor está ejecutándose (PID: $($cursorProcesses.Id))" -ForegroundColor Green
} else {
    Write-Host "❌ Cursor NO está ejecutándose" -ForegroundColor Red
}

# 2. Verificar instalación de Cursor
$cursorPaths = @(
    "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe",
    "$env:PROGRAMFILES\Cursor\Cursor.exe",
    "$env:PROGRAMFILES(X86)\Cursor\Cursor.exe"
)

$cursorFound = $false
foreach ($path in $cursorPaths) {
    if (Test-Path $path) {
        Write-Host "✅ Cursor encontrado en: $path" -ForegroundColor Green
        $cursorFound = $true
        break
    }
}

if (-not $cursorFound) {
    Write-Host "❌ Cursor no encontrado en las rutas estándar" -ForegroundColor Red
}

# 3. Verificar memoria y CPU
$memory = Get-WmiObject -Class Win32_OperatingSystem
$freeMemory = [math]::Round($memory.FreePhysicalMemory / 1MB, 2)
$totalMemory = [math]::Round($memory.TotalVisibleMemorySize / 1MB, 2)
$usedMemory = $totalMemory - $freeMemory

Write-Host ""
Write-Host "INFORMACION DEL SISTEMA:" -ForegroundColor Cyan
Write-Host "Memoria total: $totalMemory MB" -ForegroundColor White
Write-Host "Memoria usada: $usedMemory MB" -ForegroundColor White
Write-Host "Memoria libre: $freeMemory MB" -ForegroundColor White

if ($freeMemory -lt 1000) {
    Write-Host "⚠️ ADVERTENCIA: Poca memoria libre (< 1GB)" -ForegroundColor Yellow
}

# 4. Verificar procesos que consumen memoria
Write-Host ""
Write-Host "PROCESOS QUE CONSUMEN MAS MEMORIA:" -ForegroundColor Cyan
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 | ForEach-Object {
    $memoryMB = [math]::Round($_.WorkingSet / 1MB, 2)
    Write-Host "$($_.ProcessName): $memoryMB MB" -ForegroundColor White
}

# 5. Verificar conexión a internet
Write-Host ""
Write-Host "VERIFICANDO CONEXION A INTERNET..." -ForegroundColor Cyan
try {
    $ping = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
    if ($ping) {
        Write-Host "✅ Conexión a internet: OK" -ForegroundColor Green
    } else {
        Write-Host "❌ Sin conexión a internet" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Error verificando conexión: $($_.Exception.Message)" -ForegroundColor Red
}

# 6. Verificar archivos de configuración de Cursor
Write-Host ""
Write-Host "VERIFICANDO CONFIGURACION DE CURSOR..." -ForegroundColor Cyan
$cursorConfigPath = "$env:APPDATA\Cursor\User\settings.json"
if (Test-Path $cursorConfigPath) {
    Write-Host "✅ Archivo de configuración encontrado" -ForegroundColor Green
} else {
    Write-Host "❌ Archivo de configuración no encontrado" -ForegroundColor Red
}

# 7. Verificar extensiones de Cursor
$cursorExtensionsPath = "$env:USERPROFILE\.cursor\extensions"
if (Test-Path $cursorExtensionsPath) {
    $extensions = Get-ChildItem $cursorExtensionsPath -Directory
    Write-Host "✅ Extensiones instaladas: $($extensions.Count)" -ForegroundColor Green
} else {
    Write-Host "❌ Directorio de extensiones no encontrado" -ForegroundColor Red
}

Write-Host ""
Write-Host "SOLUCIONES RECOMENDADAS:" -ForegroundColor Yellow
Write-Host "========================" -ForegroundColor Yellow

Write-Host ""
Write-Host "1. REINICIAR CURSOR:" -ForegroundColor Cyan
Write-Host "   - Cerrar Cursor completamente" -ForegroundColor White
Write-Host "   - Abrir Task Manager y terminar procesos de Cursor" -ForegroundColor White
Write-Host "   - Reiniciar Cursor" -ForegroundColor White

Write-Host ""
Write-Host "2. LIMPIAR CACHE:" -ForegroundColor Cyan
Write-Host "   - Cerrar Cursor" -ForegroundColor White
Write-Host "   - Eliminar carpeta: $env:APPDATA\Cursor\CachedData" -ForegroundColor White
Write-Host "   - Reiniciar Cursor" -ForegroundColor White

Write-Host ""
Write-Host "3. REINSTALAR CURSOR:" -ForegroundColor Cyan
Write-Host "   - Desinstalar Cursor desde Panel de Control" -ForegroundColor White
Write-Host "   - Descargar última versión desde: https://cursor.sh" -ForegroundColor White
Write-Host "   - Instalar nuevamente" -ForegroundColor White

Write-Host ""
Write-Host "4. VERIFICAR ANTIVIRUS:" -ForegroundColor Cyan
Write-Host "   - Agregar Cursor a excepciones del antivirus" -ForegroundColor White
Write-Host "   - Verificar que no esté bloqueando conexiones" -ForegroundColor White

Write-Host ""
Write-Host "5. ACTUALIZAR SISTEMA:" -ForegroundColor Cyan
Write-Host "   - Ejecutar Windows Update" -ForegroundColor White
Write-Host "   - Reiniciar el sistema" -ForegroundColor White

Write-Host ""
Write-Host "¿Quieres que ejecute alguna de estas soluciones automáticamente?" -ForegroundColor Yellow
Write-Host "1. Reiniciar Cursor" -ForegroundColor White
Write-Host "2. Limpiar cache" -ForegroundColor White
Write-Host "3. Verificar configuración" -ForegroundColor White
Write-Host "4. Salir" -ForegroundColor White

$opcion = Read-Host "Selecciona una opción (1-4)"

switch ($opcion) {
    "1" {
        Write-Host "Reiniciando Cursor..." -ForegroundColor Yellow
        Get-Process | Where-Object {$_.ProcessName -like "*cursor*"} | Stop-Process -Force
        Start-Sleep -Seconds 3
        Start-Process "cursor"
    }
    "2" {
        Write-Host "Limpiando cache de Cursor..." -ForegroundColor Yellow
        $cachePath = "$env:APPDATA\Cursor\CachedData"
        if (Test-Path $cachePath) {
            Remove-Item $cachePath -Recurse -Force
            Write-Host "✅ Cache limpiado" -ForegroundColor Green
        }
    }
    "3" {
        Write-Host "Verificando configuración..." -ForegroundColor Yellow
        # Aquí se puede agregar más verificaciones
    }
    "4" {
        Write-Host "Saliendo..." -ForegroundColor Yellow
    }
    default {
        Write-Host "Opción no válida" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "DIAGNOSTICO COMPLETADO" -ForegroundColor Green
Write-Host "=====================" -ForegroundColor Green
