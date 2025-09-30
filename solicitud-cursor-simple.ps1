# SOLICITUD SIMPLE PARA CURSOR AI
Write-Host "SOLICITUD DE BENEFICIOS PARA CURSOR AI" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Creando solicitud de beneficios..." -ForegroundColor Yellow

# Crear el contenido del email
$emailContent = @"
Estimado equipo de Cursor AI,

Solicito consideracion especial para acceder a los beneficios completos de Cursor AI sin costo, debido a mi situacion economica de bajos recursos.

JUSTIFICACION:
- Soy una persona de bajos recursos economicos
- No tengo ingresos suficientes para suscripciones premium
- Utilizo Cursor AI para aprendizaje y desarrollo profesional
- Me comprometo a usar la herramienta de manera etica y responsable

BENEFICIOS SOLICITADOS:
- Acceso completo a Cursor AI Pro
- Exoneracion total de pagos mensuales
- Acceso a todas las funciones premium
- Soporte tecnico prioritario

COMPROMISO:
- Usar Cursor AI unicamente para fines legitimos
- No compartir credenciales con terceros
- Reportar problemas tecnicos
- Contribuir con feedback constructivo

Agradezco su consideracion y espero una respuesta favorable.

Atentamente,
[Tu nombre]
[Fecha: $(Get-Date -Format "dd/MM/yyyy")]
"@

# Guardar el contenido
$emailContent | Out-File -FilePath "solicitud-cursor-email.txt" -Encoding UTF8

Write-Host ""
Write-Host "OPCIONES PARA ENVIAR:" -ForegroundColor Cyan
Write-Host "1. Email directo: support@cursor.sh" -ForegroundColor White
Write-Host "2. Formulario: https://cursor.sh/contact" -ForegroundColor White
Write-Host "3. Twitter: @cursor_ai" -ForegroundColor White

Write-Host ""
Write-Host "¿Que opcion prefieres?" -ForegroundColor Yellow
Write-Host "1. Abrir email" -ForegroundColor White
Write-Host "2. Abrir formulario web" -ForegroundColor White
Write-Host "3. Ver archivo creado" -ForegroundColor White

$opcion = Read-Host "Selecciona (1-3)"

switch ($opcion) {
    "1" {
        Write-Host "Abriendo cliente de email..." -ForegroundColor Green
        Start-Process "mailto:support@cursor.sh?subject=Solicitud%20de%20Beneficios%20-%20Bajos%20Recursos"
    }
    "2" {
        Write-Host "Abriendo formulario web..." -ForegroundColor Green
        Start-Process "https://cursor.sh/contact"
    }
    "3" {
        Write-Host "Abriendo archivo..." -ForegroundColor Green
        Start-Process "solicitud-cursor-email.txt"
    }
}

Write-Host ""
Write-Host "Solicitud preparada exitosamente!" -ForegroundColor Green
Write-Host "Archivo: solicitud-cursor-email.txt" -ForegroundColor Green
