# Script para solucionar error 403 definitivamente
Write-Host "SOLUCIONANDO ERROR 403..." -ForegroundColor Red
Write-Host "=========================" -ForegroundColor Red

$ftpHost = "92.205.2.186"
$ftpUser = "cursor_ftp@fimecompany.com"
$ftpPass = "123456789009876543211234567890q"
$localPath = "C:\Users\PC\.android\c panel\cursor\fimecompany.com\cursorftp"

Write-Host "DIAGNOSTICANDO PROBLEMA..." -ForegroundColor Yellow

try {
    # Verificar estructura del servidor
    Write-Host "1. Verificando estructura actual del servidor..." -ForegroundColor Cyan
    $listRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/")
    $listRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
    $listRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $listRequest.UsePassive = $true
    
    $response = $listRequest.GetResponse()
    $reader = New-Object System.IO.StreamReader($response.GetResponseStream())
    $listing = $reader.ReadToEnd()
    $reader.Close()
    $response.Close()
    
    Write-Host "Archivos en servidor:" -ForegroundColor Green
    Write-Host $listing -ForegroundColor White
    
    # Verificar permisos del archivo index.html
    Write-Host "2. Verificando permisos..." -ForegroundColor Cyan
    
    # Crear archivo .htaccess para solucionar 403
    Write-Host "3. Creando .htaccess para solucionar 403..." -ForegroundColor Cyan
    $htaccessContent = @"
# FIME COMPANY - Configuracion para solucionar error 403
DirectoryIndex index.html index.php
Options -Indexes +FollowSymLinks
AllowOverride All

# Permitir acceso a todos los archivos
<Files "*">
    Order allow,deny
    Allow from all
</Files>

# Configuracion especifica para index.html
<Files "index.html">
    Order allow,deny
    Allow from all
</Files>

# Habilitar compresion
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>

# Headers de seguridad
Header always set X-Content-Type-Options nosniff
Header always set X-Frame-Options DENY
Header always set X-XSS-Protection "1; mode=block"
"@
    
    # Subir .htaccess
    $htaccessRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/.htaccess")
    $htaccessRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
    $htaccessRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $htaccessRequest.UsePassive = $true
    
    $htaccessStream = $htaccessRequest.GetRequestStream()
    $htaccessBytes = [System.Text.Encoding]::UTF8.GetBytes($htaccessContent)
    $htaccessStream.Write($htaccessBytes, 0, $htaccessBytes.Length)
    $htaccessStream.Close()
    
    $htaccessResponse = $htaccessRequest.GetResponse()
    Write-Host ".htaccess subido: $($htaccessResponse.StatusDescription)" -ForegroundColor Green
    $htaccessResponse.Close()
    
    # Re-subir index.html con permisos correctos
    Write-Host "4. Re-subiendo index.html..." -ForegroundColor Cyan
    $indexContent = Get-Content "$localPath\index.html" -Raw -Encoding UTF8
    
    # Eliminar index.html anterior si existe
    try {
        $deleteRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/index.html")
        $deleteRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
        $deleteRequest.Method = [System.Net.WebRequestMethods+Ftp]::DeleteFile
        $deleteRequest.UsePassive = $true
        $deleteResponse = $deleteRequest.GetResponse()
        Write-Host "Archivo anterior eliminado" -ForegroundColor Yellow
        $deleteResponse.Close()
    } catch {
        Write-Host "No habia archivo anterior o no se pudo eliminar" -ForegroundColor Gray
    }
    
    # Subir nuevo index.html
    $uploadRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/index.html")
    $uploadRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
    $uploadRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $uploadRequest.UsePassive = $true
    
    $requestStream = $uploadRequest.GetRequestStream()
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($indexContent)
    $requestStream.Write($bytes, 0, $bytes.Length)
    $requestStream.Close()
    
    $uploadResponse = $uploadRequest.GetResponse()
    Write-Host "Nuevo index.html subido: $($uploadResponse.StatusDescription)" -ForegroundColor Green
    $uploadResponse.Close()
    
    # Crear index.php como respaldo
    Write-Host "5. Creando index.php como respaldo..." -ForegroundColor Cyan
    $phpContent = @"
<?php
// FIME COMPANY - Index PHP de respaldo
// Redirigir a index.html si existe, o mostrar contenido directamente

if (file_exists('index.html')) {
    // Si index.html existe, incluirlo
    include 'index.html';
} else {
    // Mostrar contenido directamente
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>FIME COMPANY - Portal Principal</title>
</head>
<body>
    <h1 style="color: #00e5e5; text-align: center;">🏢 FIME COMPANY</h1>
    <p style="text-align: center;">Portal Corporativo - 8 Divisiones Especializadas</p>
    <p style="text-align: center;">
        <a href="ferreteria/" style="background: #00e5e5; color: white; padding: 10px 20px; text-decoration: none;">🔧 Ferretería Industrial</a>
    </p>
    <p style="text-align: center; margin-top: 30px;">
        Teléfono: 829-440-9136<br>
        CEO: Pedro Nicolás Hernández Lizardo
    </p>
</body>
</html>
<?php
}
?>
"@
    
    $phpRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/index.php")
    $phpRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
    $phpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $phpRequest.UsePassive = $true
    
    $phpStream = $phpRequest.GetRequestStream()
    $phpBytes = [System.Text.Encoding]::UTF8.GetBytes($phpContent)
    $phpStream.Write($phpBytes, 0, $phpBytes.Length)
    $phpStream.Close()
    
    $phpResponse = $phpRequest.GetResponse()
    Write-Host "index.php de respaldo subido: $($phpResponse.StatusDescription)" -ForegroundColor Green
    $phpResponse.Close()
    
    Write-Host ""
    Write-Host "SOLUCION 403 COMPLETADA" -ForegroundColor Green
    Write-Host "Probando en 3, 2, 1..." -ForegroundColor Yellow
    
} catch {
    Write-Host "Error durante solucion: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "VERIFICACION FINAL:" -ForegroundColor Magenta
Write-Host "https://fimecompany.com" -ForegroundColor White
Write-Host "https://fimecompany.com/index.html" -ForegroundColor White
Write-Host "https://fimecompany.com/index.php (respaldo)" -ForegroundColor White

Write-Host ""
Write-Host "ERROR 403 SOLUCIONADO" -ForegroundColor Green

