# Script para subir FimeTech completo a cPanel
# Autor: FIME COMPANY
# Fecha: 26/09/2025

Write-Host "🚀 INICIANDO SUBIDA DE FIMETECH A CPANEL" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Cyan

# Configuración FTP
$ftpServer = "ftp.fimecompany.com"
$ftpUser = "fimecompany"
$ftpPass = "FimeCompany2024!"
$remotePath = "/public_html/fimetech/"

# Archivos a subir
$filesToUpload = @(
    "fimetech/index.html",
    "fimetech/products.json", 
    "fimetech/cart.js",
    "fimetech/chatgpt.html",
    "fimetech/iphone15pro.html",
    "fimetech/rtx4090.html"
)

# Función para subir archivo via FTP
function Upload-File {
    param(
        [string]$localFile,
        [string]$remoteFile
    )
    
    try {
        Write-Host "📤 Subiendo: $localFile" -ForegroundColor Yellow
        
        # Crear conexión FTP
        $ftp = [System.Net.FtpWebRequest]::Create("ftp://$ftpServer$remoteFile")
        $ftp.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
        $ftp.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $ftp.UseBinary = $true
        
        # Leer archivo local
        $fileContent = [System.IO.File]::ReadAllBytes($localFile)
        $ftp.ContentLength = $fileContent.Length
        
        # Subir archivo
        $requestStream = $ftp.GetRequestStream()
        $requestStream.Write($fileContent, 0, $fileContent.Length)
        $requestStream.Close()
        
        # Verificar respuesta
        $response = $ftp.GetResponse()
        Write-Host "✅ Subido exitosamente: $remoteFile" -ForegroundColor Green
        $response.Close()
        
        return $true
    }
    catch {
        Write-Host "❌ Error subiendo $localFile : $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Función para crear directorio remoto
function Create-RemoteDirectory {
    param([string]$directory)
    
    try {
        $ftp = [System.Net.FtpWebRequest]::Create("ftp://$ftpServer$directory")
        $ftp.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
        $ftp.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        $response = $ftp.GetResponse()
        Write-Host "📁 Directorio creado: $directory" -ForegroundColor Green
        $response.Close()
        return $true
    }
    catch {
        Write-Host "⚠️ Directorio ya existe o error: $directory" -ForegroundColor Yellow
        return $false
    }
}

# Verificar conexión FTP
Write-Host "🔍 Verificando conexión FTP..." -ForegroundColor Cyan
try {
    $ftp = [System.Net.FtpWebRequest]::Create("ftp://$ftpServer/")
    $ftp.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
    $ftp.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $response = $ftp.GetResponse()
    Write-Host "✅ Conexión FTP exitosa" -ForegroundColor Green
    $response.Close()
}
catch {
    Write-Host "❌ Error de conexión FTP: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Verifica las credenciales FTP en el script" -ForegroundColor Yellow
    exit 1
}

# Crear directorio fimetech en el servidor
Write-Host "📁 Creando directorio fimetech..." -ForegroundColor Cyan
Create-RemoteDirectory "/public_html/fimetech"

# Subir archivos
Write-Host "📤 Iniciando subida de archivos..." -ForegroundColor Cyan
$successCount = 0
$totalFiles = $filesToUpload.Count

foreach ($file in $filesToUpload) {
    if (Test-Path $file) {
        $fileName = Split-Path $file -Leaf
        $remoteFile = "$remotePath$fileName"
        
        if (Upload-File $file $remoteFile) {
            $successCount++
        }
        
        # Pausa entre archivos
        Start-Sleep -Milliseconds 500
    } else {
        Write-Host "⚠️ Archivo no encontrado: $file" -ForegroundColor Yellow
    }
}

# Resumen final
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "📊 RESUMEN DE SUBIDA" -ForegroundColor Green
Write-Host "Archivos procesados: $totalFiles" -ForegroundColor White
Write-Host "Archivos subidos: $successCount" -ForegroundColor Green
Write-Host "Errores: $($totalFiles - $successCount)" -ForegroundColor Red

if ($successCount -eq $totalFiles) {
    Write-Host "🎉 ¡FIMETECH SUBIDO EXITOSAMENTE!" -ForegroundColor Green
    Write-Host "🌐 URL: https://fimecompany.com/fimetech/" -ForegroundColor Cyan
    Write-Host "📱 Página principal: https://fimecompany.com/fimetech/index.html" -ForegroundColor Cyan
} else {
    Write-Host "⚠️ Subida completada con errores" -ForegroundColor Yellow
}

# Verificar archivos subidos
Write-Host "🔍 Verificando archivos en el servidor..." -ForegroundColor Cyan
try {
    $ftp = [System.Net.FtpWebRequest]::Create("ftp://$ftpServer$remotePath")
    $ftp.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
    $ftp.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $response = $ftp.GetResponse()
    $reader = New-Object System.IO.StreamReader($response.GetResponseStream())
    $files = $reader.ReadToEnd()
    $reader.Close()
    $response.Close()
    
    Write-Host "📋 Archivos en el servidor:" -ForegroundColor Green
    $files -split "`n" | ForEach-Object { 
        if ($_.Trim()) { 
            Write-Host "  ✅ $($_.Trim())" -ForegroundColor Green 
        } 
    }
}
catch {
    Write-Host "⚠️ No se pudo verificar archivos en el servidor" -ForegroundColor Yellow
}

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "✨ Script completado" -ForegroundColor Green
Write-Host "Presiona cualquier tecla para continuar..." -ForegroundColor Gray
Read-Host








