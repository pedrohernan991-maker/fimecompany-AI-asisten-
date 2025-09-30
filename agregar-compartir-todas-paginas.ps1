# Script para agregar icono de compartir a todas las páginas de FIME COMPANY
# Autor: Sistema FIME COMPANY
# Fecha: $(Get-Date)

Write-Host "🚀 Iniciando proceso de agregar icono de compartir a todas las páginas..." -ForegroundColor Green

# Función para agregar el componente de compartir a una página
function Add-ShareComponent {
    param(
        [string]$FilePath
    )
    
    if (-not (Test-Path $FilePath)) {
        Write-Host "❌ Archivo no encontrado: $FilePath" -ForegroundColor Red
        return
    }
    
    Write-Host "📝 Procesando: $FilePath" -ForegroundColor Yellow
    
    # Leer el contenido del archivo
    $content = Get-Content $FilePath -Raw -Encoding UTF8
    
    # Verificar si ya tiene el componente de compartir
    if ($content -match "share-button") {
        Write-Host "✅ Ya tiene componente de compartir: $FilePath" -ForegroundColor Green
        return
    }
    
    # CSS para el botón de compartir (adaptado al tema de cada página)
    $shareCSS = @'
    /* Estilos para el botón de compartir */
    .share-button {
        position: fixed;
        top: 20px;
        right: 20px;
        background: linear-gradient(45deg, #00e5e5, #007a7a);
        color: white;
        border: none;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        cursor: pointer;
        font-size: 24px;
        box-shadow: 0 4px 15px rgba(0, 229, 229, 0.4);
        transition: all 0.3s ease;
        z-index: 1000;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .share-button:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 20px rgba(0, 229, 229, 0.6);
    }

    .share-button:active {
        transform: scale(0.95);
    }

    /* Modal de compartir */
    .share-modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        z-index: 2000;
        backdrop-filter: blur(5px);
    }

    .share-modal-content {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        max-width: 400px;
        width: 90%;
        text-align: center;
    }

    .share-modal h3 {
        color: #2c3e50;
        margin-bottom: 20px;
        font-size: 1.5em;
    }

    .share-options {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
        gap: 15px;
        margin-bottom: 20px;
    }

    .share-option {
        background: #f8f9fa;
        border: 2px solid #e9ecef;
        border-radius: 10px;
        padding: 15px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        color: #2c3e50;
    }

    .share-option:hover {
        background: #00e5e5;
        color: white;
        transform: translateY(-2px);
    }

    .share-option i {
        font-size: 24px;
        display: block;
        margin-bottom: 5px;
    }

    .share-url {
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 8px;
        padding: 10px;
        margin: 15px 0;
        font-family: monospace;
        font-size: 14px;
        word-break: break-all;
    }

    .close-share {
        background: #6c757d;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 20px;
        cursor: pointer;
        font-size: 14px;
    }

    .close-share:hover {
        background: #5a6268;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .share-button {
            width: 50px;
            height: 50px;
            font-size: 20px;
            top: 15px;
            right: 15px;
        }

        .share-modal-content {
            padding: 20px;
            margin: 20px;
        }

        .share-options {
            grid-template-columns: repeat(2, 1fr);
        }
    }
'@

    # HTML del botón y modal de compartir
    $shareHTML = @'
  <!-- BOTÓN DE COMPARTIR -->
  <button class="share-button" onclick="openShareModal()" title="Compartir página">
      📤
  </button>

  <!-- MODAL DE COMPARTIR -->
  <div id="shareModal" class="share-modal">
      <div class="share-modal-content">
          <h3>📤 Compartir Página</h3>
          <div class="share-options">
              <a href="#" class="share-option" onclick="shareWhatsApp()">
                  <i>📱</i>
                  WhatsApp
              </a>
              <a href="#" class="share-option" onclick="shareFacebook()">
                  <i>📘</i>
                  Facebook
              </a>
              <a href="#" class="share-option" onclick="shareTwitter()">
                  <i>🐦</i>
                  Twitter
              </a>
              <a href="#" class="share-option" onclick="shareEmail()">
                  <i>📧</i>
                  Email
              </a>
              <a href="#" class="share-option" onclick="copyLink()">
                  <i>📋</i>
                  Copiar Link
              </a>
              <a href="#" class="share-option" onclick="shareTelegram()">
                  <i>✈️</i>
                  Telegram
              </a>
          </div>
          <div class="share-url" id="shareUrl"></div>
          <button class="close-share" onclick="closeShareModal()">Cerrar</button>
      </div>
  </div>
'@

    # JavaScript para las funciones de compartir
    $shareJS = @'
    // ========== FUNCIONES DE COMPARTIR ==========
    
    // Función para abrir el modal de compartir
    function openShareModal() {
        const modal = document.getElementById('shareModal');
        const urlElement = document.getElementById('shareUrl');
        
        // Obtener la URL actual
        const currentUrl = window.location.href;
        const pageTitle = document.title;
        
        // Mostrar la URL en el modal
        urlElement.textContent = currentUrl;
        
        // Mostrar el modal
        modal.style.display = 'block';
        
        // Agregar animación de entrada
        setTimeout(() => {
            modal.querySelector('.share-modal-content').style.transform = 'translate(-50%, -50%) scale(1)';
            modal.querySelector('.share-modal-content').style.opacity = '1';
        }, 10);
    }

    // Función para cerrar el modal
    function closeShareModal() {
        const modal = document.getElementById('shareModal');
        modal.style.display = 'none';
    }

    // Cerrar modal al hacer click fuera
    document.getElementById('shareModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeShareModal();
        }
    });

    // Función para compartir en WhatsApp
    function shareWhatsApp() {
        const url = encodeURIComponent(window.location.href);
        const title = encodeURIComponent(document.title);
        const text = encodeURIComponent('¡Mira esta página de FIME COMPANY!\n\n' + title + '\n\n');
        
        window.open('https://wa.me/?text=' + text + url, '_blank');
        closeShareModal();
    }

    // Función para compartir en Facebook
    function shareFacebook() {
        const url = encodeURIComponent(window.location.href);
        window.open('https://www.facebook.com/sharer/sharer.php?u=' + url, '_blank');
        closeShareModal();
    }

    // Función para compartir en Twitter
    function shareTwitter() {
        const url = encodeURIComponent(window.location.href);
        const title = encodeURIComponent(document.title);
        const text = encodeURIComponent('¡Mira esta página de FIME COMPANY! ' + title);
        
        window.open('https://twitter.com/intent/tweet?text=' + text + '&url=' + url, '_blank');
        closeShareModal();
    }

    // Función para compartir por email
    function shareEmail() {
        const url = window.location.href;
        const title = document.title;
        const subject = encodeURIComponent('Compartir: ' + title);
        const body = encodeURIComponent('¡Hola!\n\nTe comparto esta página de FIME COMPANY:\n\n' + title + '\n' + url + '\n\n¡Saludos!');
        
        window.location.href = 'mailto:?subject=' + subject + '&body=' + body;
        closeShareModal();
    }

    // Función para copiar el link
    function copyLink() {
        const url = window.location.href;
        
        if (navigator.clipboard) {
            navigator.clipboard.writeText(url).then(() => {
                alert('¡Link copiado al portapapeles!');
            });
        } else {
            // Fallback para navegadores más antiguos
            const textArea = document.createElement('textarea');
            textArea.value = url;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand('copy');
            document.body.removeChild(textArea);
            alert('¡Link copiado al portapapeles!');
        }
        
        closeShareModal();
    }

    // Función para compartir en Telegram
    function shareTelegram() {
        const url = encodeURIComponent(window.location.href);
        const title = encodeURIComponent(document.title);
        const text = encodeURIComponent('¡Mira esta página de FIME COMPANY!\n\n' + title + '\n\n');
        
        window.open('https://t.me/share/url?url=' + url + '&text=' + text, '_blank');
        closeShareModal();
    }

    // Agregar efecto de vibración en dispositivos móviles
    function vibrate() {
        if (navigator.vibrate) {
            navigator.vibrate(50);
        }
    }

    // Agregar vibración a los botones
    document.querySelectorAll('.share-option').forEach(option => {
        option.addEventListener('click', vibrate);
    });

    document.querySelector('.share-button').addEventListener('click', vibrate);
'@

    # Agregar CSS antes del cierre de </style>
    if ($content -match "</style>") {
        $content = $content -replace "</style>", "$shareCSS`n</style>"
    }
    
    # Agregar HTML después de <body>
    if ($content -match "<body[^>]*>") {
        $content = $content -replace "(<body[^>]*>)", "`$1`n$shareHTML"
    }
    
    # Agregar JavaScript antes del cierre de </script> o </body>
    if ($content -match "</script>") {
        $content = $content -replace "</script>", "$shareJS`n</script>"
    } elseif ($content -match "</body>") {
        $content = $content -replace "</body>", "<script>$shareJS</script>`n</body>"
    }
    
    # Guardar el archivo modificado
    Set-Content $FilePath -Value $content -Encoding UTF8
    
    Write-Host "✅ Componente de compartir agregado: $FilePath" -ForegroundColor Green
}

# Lista de archivos HTML a procesar
$htmlFiles = @(
    "fimekids/index.html",
    "fimetech/index.html",
    "creaweb/index.html",
    "industria/index.html",
    "public_html/index.html",
    "public_html/ferreteria/index.html",
    "public_html/fimekids/index.html",
    "public_html/industria/index.html",
    "cursor/fimecompany.com/cursorftp/index.html",
    "cursor/fimecompany.com/cursorftp/ferreteria/index.html",
    "cursor/fimecompany.com/cursorftp/fimekids/index.html",
    "cursor/fimecompany.com/cursorftp/constructora/index.html",
    "cursor/fimecompany.com/cursorftp/energia/index.html",
    "cursor/fimecompany.com/cursorftp/global/index.html",
    "cursor/fimecompany.com/cursorftp/imprexlaser/index.html",
    "cursor/fimecompany.com/cursorftp/inversiones/index.html"
)

# Procesar cada archivo
foreach ($file in $htmlFiles) {
    Add-ShareComponent -FilePath $file
}

# Buscar archivos HTML adicionales
Write-Host "🔍 Buscando archivos HTML adicionales..." -ForegroundColor Cyan
$additionalFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse | Where-Object { 
    $_.FullName -notmatch "share-component" -and 
    $_.FullName -notmatch "index\.html$" -and
    $_.FullName -notmatch "ferreteria.*index\.html$"
}

foreach ($file in $additionalFiles) {
    Add-ShareComponent -FilePath $file.FullName
}

Write-Host "🎉 ¡Proceso completado! Todas las páginas ahora tienen el icono de compartir." -ForegroundColor Green
Write-Host "📊 Resumen:" -ForegroundColor Yellow
Write-Host "   - Páginas procesadas: $($htmlFiles.Count + $additionalFiles.Count)" -ForegroundColor White
Write-Host "   - Funcionalidades agregadas:" -ForegroundColor White
Write-Host "     • Botón flotante de compartir" -ForegroundColor White
Write-Host "     • Modal con opciones de redes sociales" -ForegroundColor White
Write-Host "     • WhatsApp, Facebook, Twitter, Email, Telegram" -ForegroundColor White
Write-Host "     • Copiar link al portapapeles" -ForegroundColor White
Write-Host "     • Efectos de vibración en móviles" -ForegroundColor White
Write-Host "     • Diseño responsive" -ForegroundColor White








