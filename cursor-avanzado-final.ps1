# CURSOR AVANZADO - CONFIGURACION FINAL
Write-Host "CURSOR PROGRAMADOR AVANZADO - FINAL" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# Crear estructura de directorios para desarrollo
$directorios = @(
  "proyectos",
  "proyectos/web",
  "proyectos/juegos", 
  "proyectos/templates",
  "assets",
  "assets/images",
  "assets/sounds",
  "assets/fonts",
  "scripts",
  "styles",
  "docs"
)

Write-Host "Creando estructura de directorios..." -ForegroundColor Yellow
foreach ($dir in $directorios) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Name $dir -Force
    Write-Host "  ✓ $dir creado" -ForegroundColor Green
  }
}

# Crear archivos de configuración
Write-Host "Creando archivos de configuración..." -ForegroundColor Yellow

# package.json para proyectos web
$packageJson = @{
  name            = "cursor-web-project"
  version         = "1.0.0"
  description     = "Proyecto web creado con Cursor Avanzado"
  main            = "index.html"
  scripts         = @{
    dev   = "live-server --port=5500"
    build = "webpack --mode=production"
    start = "live-server --port=5500"
  }
  devDependencies = @{
    "live-server" = "^1.2.2"
    "webpack"     = "^5.0.0"
    "webpack-cli" = "^4.0.0"
  }
} | ConvertTo-Json -Depth 3

$packageJson | Out-File -FilePath "package.json" -Encoding UTF8

# webpack.config.js
$webpackConfig = @'
const path = require("path");

module.exports = {
  entry: "./src/index.js",
  output: {
    filename: "bundle.js",
    path: path.resolve(__dirname, "dist"),
  },
  module: {
    rules: [
      {
        test: /\.css$/i,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i,
        type: "asset/resource",
      },
    ],
  },
  devServer: {
    static: "./dist",
    port: 5500,
    hot: true,
  },
};
'@

$webpackConfig | Out-File -FilePath "webpack.config.js" -Encoding UTF8

# .gitignore
$gitignore = @'
node_modules/
dist/
*.log
.DS_Store
Thumbs.db
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
'@

$gitignore | Out-File -FilePath ".gitignore" -Encoding UTF8

Write-Host "Archivos de configuración creados!" -ForegroundColor Green

# Crear templates de proyectos
Write-Host "Creando templates de proyectos..." -ForegroundColor Yellow

# Template de juego básico
$gameTemplate = @"
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cursor Game</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: #000;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            font-family: Arial, sans-serif;
        }
        #gameCanvas {
            border: 2px solid #fff;
            background: #111;
        }
        .controls {
            position: absolute;
            top: 10px;
            left: 10px;
            color: white;
        }
    </style>
</head>
<body>
    <div class="controls">
        <p>FPS: <span id="fps">0</span></p>
        <p>Objetos: <span id="objects">0</span></p>
    </div>
    <canvas id="gameCanvas" width="800" height="600"></canvas>
    <script src="cursor-game-engine.js"></script>
    <script>
        // Tu código del juego aquí
        const game = new CursorGameEngine('gameCanvas');
        
        // Crear objetos del juego
        const player = new GameObject(100, 100, 32, 32);
        player.velocityX = 2;
        
        game.addGameObject(player);
        
        // Inicializar y empezar
        game.init().then(() => {
            game.start();
        });
    </script>
</body>
</html>
"@

$gameTemplate | Out-File -FilePath "proyectos/juegos/template.html" -Encoding UTF8

# Template de página web
$webTemplate = @"
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cursor Web Project</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <nav>
            <h1>Mi Proyecto Web</h1>
            <ul>
                <li><a href="#home">Inicio</a></li>
                <li><a href="#about">Acerca</a></li>
                <li><a href="#contact">Contacto</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <section id="home">
            <h2>Bienvenido</h2>
            <p>Este es un proyecto web creado con Cursor Avanzado.</p>
        </section>
        
        <section id="about">
            <h2>Acerca de</h2>
            <p>Información sobre el proyecto.</p>
        </section>
        
        <section id="contact">
            <h2>Contacto</h2>
            <p>Ponte en contacto con nosotros.</p>
        </section>
    </main>
    
    <footer>
        <p>&copy; 2024 Cursor Avanzado</p>
    </footer>
    
    <script src="script.js"></script>
</body>
</html>
"@

$webTemplate | Out-File -FilePath "proyectos/web/template.html" -Encoding UTF8

Write-Host "Templates creados!" -ForegroundColor Green

# Crear archivos de estilos
$cssTemplate = @"
/* Cursor Web Project Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    background: #f4f4f4;
}

header {
    background: #2c3e50;
    color: white;
    padding: 1rem 0;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1000;
}

nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
}

nav ul {
    display: flex;
    list-style: none;
    gap: 2rem;
}

nav a {
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
}

nav a:hover {
    color: #3498db;
}

main {
    margin-top: 80px;
    max-width: 1200px;
    margin-left: auto;
    margin-right: auto;
    padding: 2rem;
}

section {
    background: white;
    margin: 2rem 0;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

h2 {
    color: #2c3e50;
    margin-bottom: 1rem;
}

footer {
    background: #34495e;
    color: white;
    text-align: center;
    padding: 2rem;
    margin-top: 2rem;
}

/* Responsive */
@media (max-width: 768px) {
    nav {
        flex-direction: column;
        gap: 1rem;
    }
    
    nav ul {
        flex-direction: column;
        gap: 1rem;
        text-align: center;
    }
    
    main {
        padding: 1rem;
    }
}
"@

$cssTemplate | Out-File -FilePath "proyectos/web/styles.css" -Encoding UTF8

# Crear archivo JavaScript
$jsTemplate = @"
// Cursor Web Project JavaScript
document.addEventListener('DOMContentLoaded', function() {
    console.log('Cursor Web Project cargado');
    
    // Smooth scrolling para enlaces de navegación
    const navLinks = document.querySelectorAll('nav a[href^="#"]');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetSection = document.querySelector(targetId);
            
            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Animaciones al hacer scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // Observar todas las secciones
    const sections = document.querySelectorAll('section');
    sections.forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
        section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(section);
    });
    
    // Efecto parallax en el header
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const header = document.querySelector('header');
        
        if (scrolled > 100) {
            header.style.background = 'rgba(44, 62, 80, 0.95)';
            header.style.backdropFilter = 'blur(10px)';
        } else {
            header.style.background = '#2c3e50';
            header.style.backdropFilter = 'none';
        }
    });
});

// Funciones utilitarias
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

// Exportar funciones para uso en módulos
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { debounce, throttle };
}
"@

$jsTemplate | Out-File -FilePath "proyectos/web/script.js" -Encoding UTF8

Write-Host ""
Write-Host "CURSOR AVANZADO CONFIGURADO COMPLETAMENTE!" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green
Write-Host ""
Write-Host "ESTRUCTURA CREADA:" -ForegroundColor Cyan
Write-Host "• proyectos/web/ - Proyectos web" -ForegroundColor White
Write-Host "• proyectos/juegos/ - Juegos" -ForegroundColor White
Write-Host "• assets/ - Recursos multimedia" -ForegroundColor White
Write-Host "• scripts/ - Scripts de automatización" -ForegroundColor White
Write-Host "• styles/ - Estilos CSS" -ForegroundColor White
Write-Host "• docs/ - Documentación" -ForegroundColor White
Write-Host ""
Write-Host "ARCHIVOS CREADOS:" -ForegroundColor Cyan
Write-Host "• package.json - Configuración de proyecto" -ForegroundColor White
Write-Host "• webpack.config.js - Configuración de bundling" -ForegroundColor White
Write-Host "• .gitignore - Archivos a ignorar en Git" -ForegroundColor White
Write-Host "• cursor-game-engine.js - Motor de juegos" -ForegroundColor White
Write-Host "• Templates HTML, CSS y JS" -ForegroundColor White
Write-Host ""
Write-Host "COMANDOS DISPONIBLES:" -ForegroundColor Cyan
Write-Host "• npm run dev - Servidor de desarrollo" -ForegroundColor White
Write-Host "• npm run build - Construir proyecto" -ForegroundColor White
Write-Host "• npm start - Iniciar servidor" -ForegroundColor White
Write-Host ""
Write-Host "¡Cursor está listo para desarrollo avanzado!" -ForegroundColor Green




