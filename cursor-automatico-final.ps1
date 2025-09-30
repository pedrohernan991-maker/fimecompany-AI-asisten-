# Cursor - Automatizacion completa para subir archivos
Write-Host "CURSOR AUTOMATICO - SUBIDA CPANEL" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Configuracion
$localPath = "C:\Users\PC\.android\c panel\cursor\fimecompany.com\cursorftp"
$ftpHost = "92.205.2.186"
$ftpUser = "cursor_ftp@fimecompany.com"
$ftpPass = "123456789009876543211234567890q"

Write-Host "VERIFICANDO ARCHIVOS..." -ForegroundColor Yellow
if (-not (Test-Path $localPath)) {
  Write-Host "ERROR: Archivos no encontrados" -ForegroundColor Red
  exit 1
}

Write-Host "Archivos listos para subir:" -ForegroundColor Green
Get-ChildItem $localPath -Recurse -File | ForEach-Object {
  Write-Host "  $($_.Name) ($($_.Length) bytes)" -ForegroundColor White
}

Write-Host ""
Write-Host "METODO 1: USANDO POWERSHELL FTP CLIENT" -ForegroundColor Cyan

try {
  # Crear cliente FTP con PowerShell
  $ftpRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/")
  $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
  $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
  $ftpRequest.UsePassive = $true
    
  Write-Host "Conectando con PowerShell FTP..." -ForegroundColor Yellow
  $response = $ftpRequest.GetResponse()
  $reader = New-Object System.IO.StreamReader($response.GetResponseStream())
  $listing = $reader.ReadToEnd()
  $reader.Close()
  $response.Close()
    
  Write-Host "Conexion exitosa. Contenido del servidor:" -ForegroundColor Green
  Write-Host $listing -ForegroundColor White
    
  # Subir index.html principal
  Write-Host "Subiendo index.html principal..." -ForegroundColor Yellow
  $indexContent = Get-Content "$localPath\index.html" -Raw -Encoding UTF8
    
  $uploadRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/index.html")
  $uploadRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
  $uploadRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
  $uploadRequest.UsePassive = $true
    
  $requestStream = $uploadRequest.GetRequestStream()
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($indexContent)
  $requestStream.Write($bytes, 0, $bytes.Length)
  $requestStream.Close()
    
  $uploadResponse = $uploadRequest.GetResponse()
  Write-Host "Index principal subido: $($uploadResponse.StatusDescription)" -ForegroundColor Green
  $uploadResponse.Close()
    
  # Crear directorio ferreteria
  Write-Host "Creando directorio ferreteria..." -ForegroundColor Yellow
  try {
    $mkdirRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/ferreteria")
    $mkdirRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
    $mkdirRequest.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
    $mkdirRequest.UsePassive = $true
    $mkdirResponse = $mkdirRequest.GetResponse()
    Write-Host "Directorio creado: $($mkdirResponse.StatusDescription)" -ForegroundColor Green
    $mkdirResponse.Close()
  }
  catch {
    Write-Host "Directorio ya existe o error: $($_.Exception.Message)" -ForegroundColor Yellow
  }
    
  # Subir index de ferreteria
  Write-Host "Subiendo ferreteria/index.html..." -ForegroundColor Yellow
  $ferreteriaContent = Get-Content "$localPath\ferreteria\index.html" -Raw -Encoding UTF8
    
  $ferreteriaRequest = [System.Net.FtpWebRequest]::Create("ftp://$ftpHost/ferreteria/index.html")
  $ferreteriaRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPass)
  $ferreteriaRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
  $ferreteriaRequest.UsePassive = $true
    
  $ferreteriaStream = $ferreteriaRequest.GetRequestStream()
  $ferreteriaBytes = [System.Text.Encoding]::UTF8.GetBytes($ferreteriaContent)
  $ferreteriaStream.Write($ferreteriaBytes, 0, $ferreteriaBytes.Length)
  $ferreteriaStream.Close()
    
  $ferreteriaResponse = $ferreteriaRequest.GetResponse()
  Write-Host "Ferreteria index subido: $($ferreteriaResponse.StatusDescription)" -ForegroundColor Green
  $ferreteriaResponse.Close()
    
  Write-Host ""
  Write-Host "SUBIDA COMPLETADA CON EXITO" -ForegroundColor Green
    
}
catch {
  Write-Host "Error con PowerShell FTP: $($_.Exception.Message)" -ForegroundColor Red
    
  Write-Host ""
  Write-Host "METODO 2: USANDO CURL (ALTERNATIVO)" -ForegroundColor Cyan
    
  # Intentar con curl si esta disponible
  $curlPath = where.exe curl 2>$null
  if ($curlPath) {
    Write-Host "Usando curl para subida..." -ForegroundColor Yellow
        
    # Subir con curl
    & curl --ftp-create-dirs -T "$localPath\index.html" "ftp://$ftpUser`:$ftpPass@$ftpHost/"
    & curl --ftp-create-dirs -T "$localPath\ferreteria\index.html" "ftp://$ftpUser`:$ftpPass@$ftpHost/ferreteria/"
        
    Write-Host "Subida con curl completada" -ForegroundColor Green
  }
  else {
    Write-Host "Curl no disponible" -ForegroundColor Red
  }
}

Write-Host ""
Write-Host "VERIFICACION DE SITIO WEB:" -ForegroundColor Magenta
Write-Host "Principal: https://fimecompany.com" -ForegroundColor White
Write-Host "Ferreteria: https://fimecompany.com/ferreteria/" -ForegroundColor White

Write-Host ""
Write-Host "CURSOR AUTOMATICO COMPLETADO" -ForegroundColor Green

