# ENVIAR SOLICITUD DE BENEFICIOS A CURSOR AI
Write-Host "ENVIAR SOLICITUD DE BENEFICIOS A CURSOR AI" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Preparando solicitud de beneficios para Cursor AI..." -ForegroundColor Yellow

# Crear el contenido del email
$emailContent = @"
Estimado equipo de Cursor AI,

Me dirijo a ustedes con el fin de solicitar consideración especial para acceder a los beneficios completos de Cursor AI sin costo alguno, debido a mi situación económica de bajos recursos.

JUSTIFICACIÓN DE LA SOLICITUD:

1. Situación Económica:
   - Soy una persona de bajos recursos económicos
   - No tengo ingresos suficientes para suscripciones de software premium
   - Dependo de herramientas gratuitas para mi desarrollo profesional

2. Necesidad Educativa/Profesional:
   - Utilizo Cursor AI para aprendizaje y desarrollo de proyectos
   - Es una herramienta esencial para mi crecimiento profesional
   - Me ayuda a mejorar mis habilidades de programación

3. Compromiso de Uso Responsable:
   - Me comprometo a usar la herramienta de manera ética y responsable
   - No compartiré credenciales con terceros
   - Utilizaré los beneficios para fines educativos y de desarrollo personal

BENEFICIOS SOLICITADOS:
- Acceso completo a Cursor AI Pro
- Exoneración total de pagos mensuales
- Acceso a todas las funciones premium
- Soporte técnico prioritario
- Actualizaciones automáticas

COMPROMISO:
Me comprometo a usar Cursor AI únicamente para fines legítimos, no revender o redistribuir el acceso, reportar problemas técnicos y contribuir con feedback constructivo.

Agradezco de antemano su consideración y espero una respuesta favorable a mi solicitud.

Atentamente,
[Tu nombre]
[Tu email]
[Fecha: $(Get-Date -Format "dd/MM/yyyy")]
"@

# Guardar el contenido en un archivo
$emailContent | Out-File -FilePath "solicitud-cursor-email.txt" -Encoding UTF8

Write-Host ""
Write-Host "OPCIONES PARA ENVIAR LA SOLICITUD:" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "1. EMAIL DIRECTO:" -ForegroundColor Yellow
Write-Host "   Destinatario: support@cursor.sh" -ForegroundColor White
Write-Host "   Asunto: Solicitud de Beneficios - Persona de Bajos Recursos" -ForegroundColor White
Write-Host "   Archivo creado: solicitud-cursor-email.txt" -ForegroundColor White

Write-Host ""
Write-Host "2. FORMULARIO DE CONTACTO:" -ForegroundColor Yellow
Write-Host "   URL: https://cursor.sh/contact" -ForegroundColor White
Write-Host "   Categoría: Billing & Pricing" -ForegroundColor White

Write-Host ""
Write-Host "3. REDES SOCIALES:" -ForegroundColor Yellow
Write-Host "   Twitter: @cursor_ai" -ForegroundColor White
Write-Host "   LinkedIn: Cursor AI" -ForegroundColor White
Write-Host "   Discord: Servidor oficial de Cursor" -ForegroundColor White

Write-Host ""
Write-Host "4. PROGRAMA DE AYUDA:" -ForegroundColor Yellow
Write-Host "   URL: https://cursor.sh/pricing" -ForegroundColor White
Write-Host "   Buscar: Programa de ayuda económica" -ForegroundColor White

Write-Host ""
Write-Host "¿Quieres que abra alguna de estas opciones?" -ForegroundColor Green
Write-Host "1. Abrir email (Outlook/Gmail)" -ForegroundColor White
Write-Host "2. Abrir formulario de contacto" -ForegroundColor White
Write-Host "3. Abrir página de precios" -ForegroundColor White
Write-Host "4. Ver archivo de solicitud" -ForegroundColor White
Write-Host "5. Salir" -ForegroundColor White

$opcion = Read-Host "Selecciona una opción (1-5)"

switch ($opcion) {
  "1" {
    Write-Host "Abriendo cliente de email..." -ForegroundColor Yellow
    Start-Process "mailto:support@cursor.sh?subject=Solicitud%20de%20Beneficios%20-%20Persona%20de%20Bajos%20Recursos&body=$($emailContent -replace "`n", "%0A")"
  }
  "2" {
    Write-Host "Abriendo formulario de contacto..." -ForegroundColor Yellow
    Start-Process "https://cursor.sh/contact"
  }
  "3" {
    Write-Host "Abriendo página de precios..." -ForegroundColor Yellow
    Start-Process "https://cursor.sh/pricing"
  }
  "4" {
    Write-Host "Abriendo archivo de solicitud..." -ForegroundColor Yellow
    Start-Process "solicitud-cursor-email.txt"
  }
  "5" {
    Write-Host "Saliendo..." -ForegroundColor Yellow
  }
  default {
    Write-Host "Opción no válida" -ForegroundColor Red
  }
}

Write-Host ""
Write-Host "CONSEJOS ADICIONALES:" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan

Write-Host ""
Write-Host "• Sé honesto y transparente en tu solicitud" -ForegroundColor White
Write-Host "• Menciona cómo Cursor AI te ayuda en tu desarrollo" -ForegroundColor White
Write-Host "• Ofrece contribuir con feedback y reportes de bugs" -ForegroundColor White
Write-Host "• Mantén un tono profesional y respetuoso" -ForegroundColor White
Write-Host "• Incluye información de contacto válida" -ForegroundColor White

Write-Host ""
Write-Host "ALTERNATIVAS SI NO OBTIENES LA EXONERACIÓN:" -ForegroundColor Yellow
Write-Host "===========================================" -ForegroundColor Yellow

Write-Host ""
Write-Host "• Usar la versión gratuita de Cursor AI" -ForegroundColor White
Write-Host "• Buscar alternativas open source" -ForegroundColor White
Write-Host "• Aplicar a programas de ayuda para estudiantes" -ForegroundColor White
Write-Host "• Considerar GitHub Student Pack" -ForegroundColor White

Write-Host ""
Write-Host "Solicitud preparada exitosamente!" -ForegroundColor Green
Write-Host "Archivo creado: solicitud-cursor-email.txt" -ForegroundColor Green
