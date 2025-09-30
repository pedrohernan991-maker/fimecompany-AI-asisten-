<?php
// Verificar si existe el archivo de categorías
$categorias_file = 'categorias.json';
if (!file_exists($categorias_file)) {
    die('Error: Archivo de categorías no encontrado');
}

// Cargar categorías
$cats = json_decode(file_get_contents($categorias_file), true);
if (!$cats) {
    die('Error: No se pudieron cargar las categorías');
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Catálogo completo de Ferretería FIME COMPANY - Herramientas, materiales de construcción, equipos industriales">
    <meta name="keywords" content="ferretería, herramientas, construcción, materiales, equipos, FIME COMPANY">
    <title>Catálogo Ferretería - FIME COMPANY</title>
    <link rel="canonical" href="https://fimecompany.com/ferreteria/">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
            color: #ffffff;
            line-height: 1.6;
            min-height: 100vh;
        }
        
        .header {
            background: linear-gradient(90deg, #00e5e5 0%, #00b3b3 100%);
            color: #000;
            padding: 30px 0;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 229, 229, 0.3);
            margin-bottom: 40px;
        }
        
        .header h1 {
            font-size: 2.8em;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 10px;
        }
        
        .header .subtitle {
            font-size: 1.3em;
            font-weight: 500;
            opacity: 0.9;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .search-container {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .search-bar {
            background: rgba(0, 229, 229, 0.1);
            border: 2px solid #00e5e5;
            border-radius: 50px;
            padding: 15px 30px;
            width: 100%;
            max-width: 600px;
            font-size: 16px;
            color: #fff;
            text-align: center;
        }
        
        .search-bar::placeholder {
            color: #00e5e5;
        }
        
        .categoria {
            margin-bottom: 60px;
            background: rgba(26, 26, 26, 0.8);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(0, 229, 229, 0.2);
        }
        
        .categoria h2 {
            color: #00e5e5;
            font-size: 2.2em;
            text-align: center;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
            border-bottom: 3px solid #00e5e5;
            padding-bottom: 15px;
        }
        
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
        }
        
        .card {
            background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
            border: 2px solid #00e5e5;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 229, 229, 0.1), transparent);
            transition: left 0.5s;
        }
        
        .card:hover::before {
            left: 100%;
        }
        
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0, 229, 229, 0.3);
            border-color: #ff6b6b;
        }
        
        .card img {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
            margin-bottom: 15px;
            border-radius: 10px;
            background: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #00e5e5;
            font-size: 3em;
        }
        
        .card h3 {
            color: #ffffff;
            font-size: 1.2em;
            margin-bottom: 15px;
            font-weight: bold;
            min-height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        
        .precio {
            color: #ff6b6b;
            font-weight: bold;
            font-size: 1.6em;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(255, 107, 107, 0.3);
        }
        
        .btn-agregar {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            width: 100%;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }
        
        .btn-agregar:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
        }
        
        .no-image {
            background: linear-gradient(135deg, #333 0%, #555 100%);
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 3em;
            color: #00e5e5;
        }
        
        .stats {
            background: rgba(0, 229, 229, 0.1);
            border: 1px solid #00e5e5;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 40px;
            text-align: center;
        }
        
        .stats h3 {
            color: #00e5e5;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .stat-item {
            background: rgba(255, 107, 107, 0.1);
            border-radius: 10px;
            padding: 15px;
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #ff6b6b;
        }
        
        .stat-label {
            color: #cccccc;
            font-size: 0.9em;
        }
        
        .navigation {
            text-align: center;
            margin: 50px 0;
        }
        
        .nav-link {
            color: #00e5e5;
            text-decoration: none;
            font-size: 18px;
            margin: 0 15px;
            padding: 12px 25px;
            border: 2px solid #00e5e5;
            border-radius: 25px;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .nav-link:hover {
            background: #00e5e5;
            color: #000;
            transform: translateY(-2px);
        }
        
        .footer {
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
            text-align: center;
            padding: 40px 20px;
            margin-top: 60px;
            border-top: 2px solid #00e5e5;
        }
        
        .footer p {
            color: #00e5e5;
            margin-bottom: 10px;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }
            
            .grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }
            
            .categoria h2 {
                font-size: 1.8em;
            }
            
            .nav-link {
                display: block;
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>🏪 Ferretería FIME COMPANY</h1>
        <p class="subtitle">Catálogo Completo • Herramientas Profesionales • Materiales de Calidad</p>
    </header>

    <div class="container">
        <div class="search-container">
            <input type="text" class="search-bar" placeholder="🔍 Buscar productos en nuestro catálogo..." id="searchInput">
        </div>

        <?php
        // Calcular estadísticas
        $total_categorias = count($cats['categorias']);
        $total_productos = 0;
        foreach ($cats['categorias'] as $cat) {
            $total_productos += count($cat['productos']);
        }
        ?>

        <div class="stats">
            <h3>📊 Estadísticas del Catálogo</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number"><?php echo $total_categorias; ?></div>
                    <div class="stat-label">Categorías</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><?php echo $total_productos; ?></div>
                    <div class="stat-label">Productos</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">100%</div>
                    <div class="stat-label">Calidad</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Disponible</div>
                </div>
            </div>
        </div>

        <?php foreach ($cats['categorias'] as $cat): ?>
            <div class="categoria">
                <h2><?php echo htmlspecialchars($cat['nombre']); ?></h2>
                <div class="grid">
                    <?php foreach ($cat['productos'] as $p): ?>
                        <div class="card">
                            <?php if (!empty($p['imagen']) && file_exists('imagenes/'.$p['imagen'])): ?>
                                <img src="imagenes/<?php echo htmlspecialchars($p['imagen']); ?>" alt="<?php echo htmlspecialchars($p['nombre']); ?>">
                            <?php else: ?>
                                <div class="no-image">🛠️</div>
                            <?php endif; ?>
                            <h3><?php echo htmlspecialchars($p['nombre']); ?></h3>
                            <div class="precio"><?php echo htmlspecialchars($p['precio']); ?></div>
                            <button class="btn-agregar" onclick="agregarCarrito('<?php echo htmlspecialchars($p['nombre']); ?>', '<?php echo htmlspecialchars($p['precio']); ?>')">
                                🛒 Agregar al Carrito
                            </button>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <div class="navigation">
        <a href="../index.html" class="nav-link">🏠 Portal Principal</a>
        <a href="../industria/index.html" class="nav-link">🏭 Industria</a>
        <a href="#" class="nav-link">📞 Contacto</a>
        <a href="#" class="nav-link">🛒 Ver Carrito</a>
    </div>

    <footer class="footer">
        <p>© 2024 FIME COMPANY - Ferretería Profesional | Catálogo Completo</p>
        <p>📞 Teléfono: (555) 123-4567 | 📧 ferreteria@fimecompany.com</p>
        <p>🏪 Más de <?php echo $total_productos; ?> productos disponibles en <?php echo $total_categorias; ?> categorías</p>
    </footer>

    <script>
        // Funcionalidad de búsqueda
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.card');
            const categorias = document.querySelectorAll('.categoria');
            
            categorias.forEach(categoria => {
                let hasVisibleCards = false;
                const cardsInCategory = categoria.querySelectorAll('.card');
                
                cardsInCategory.forEach(card => {
                    const title = card.querySelector('h3').textContent.toLowerCase();
                    
                    if (title.includes(searchTerm) || searchTerm === '') {
                        card.style.display = 'block';
                        hasVisibleCards = true;
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Mostrar/ocultar categoría completa si no hay productos visibles
                categoria.style.display = hasVisibleCards ? 'block' : 'none';
            });
        });
        
        // Funcionalidad del carrito
        function agregarCarrito(nombre, precio) {
            // Encontrar el botón que fue clickeado
            const buttons = document.querySelectorAll('.btn-agregar');
            let clickedButton = null;
            
            buttons.forEach(btn => {
                if (btn.textContent.includes('Agregar al Carrito')) {
                    const card = btn.closest('.card');
                    const cardTitle = card.querySelector('h3').textContent;
                    if (cardTitle === nombre) {
                        clickedButton = btn;
                    }
                }
            });
            
            if (clickedButton) {
                // Animación del botón
                clickedButton.style.background = '#4ecdc4';
                clickedButton.innerHTML = '✅ Agregado al Carrito';
                
                setTimeout(() => {
                    clickedButton.style.background = 'linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%)';
                    clickedButton.innerHTML = '🛒 Agregar al Carrito';
                }, 2000);
            }
            
            // Aquí se puede integrar con un sistema de carrito real
            console.log('Producto agregado:', nombre, precio);
            
            // Mostrar notificación (opcional)
            if (typeof showNotification === 'function') {
                showNotification('Producto agregado: ' + nombre);
            }
        }
        
        // Efecto de carga
        window.addEventListener('load', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = 'all 0.6s ease';
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 50);
            });
        });
    </script>
</body>
</html>



// Verificar si existe el archivo de categorías
$categorias_file = 'categorias.json';
if (!file_exists($categorias_file)) {
    die('Error: Archivo de categorías no encontrado');
}

// Cargar categorías
$cats = json_decode(file_get_contents($categorias_file), true);
if (!$cats) {
    die('Error: No se pudieron cargar las categorías');
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Catálogo completo de Ferretería FIME COMPANY - Herramientas, materiales de construcción, equipos industriales">
    <meta name="keywords" content="ferretería, herramientas, construcción, materiales, equipos, FIME COMPANY">
    <title>Catálogo Ferretería - FIME COMPANY</title>
    <link rel="canonical" href="https://fimecompany.com/ferreteria/">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
            color: #ffffff;
            line-height: 1.6;
            min-height: 100vh;
        }
        
        .header {
            background: linear-gradient(90deg, #00e5e5 0%, #00b3b3 100%);
            color: #000;
            padding: 30px 0;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 229, 229, 0.3);
            margin-bottom: 40px;
        }
        
        .header h1 {
            font-size: 2.8em;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 10px;
        }
        
        .header .subtitle {
            font-size: 1.3em;
            font-weight: 500;
            opacity: 0.9;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .search-container {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .search-bar {
            background: rgba(0, 229, 229, 0.1);
            border: 2px solid #00e5e5;
            border-radius: 50px;
            padding: 15px 30px;
            width: 100%;
            max-width: 600px;
            font-size: 16px;
            color: #fff;
            text-align: center;
        }
        
        .search-bar::placeholder {
            color: #00e5e5;
        }
        
        .categoria {
            margin-bottom: 60px;
            background: rgba(26, 26, 26, 0.8);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(0, 229, 229, 0.2);
        }
        
        .categoria h2 {
            color: #00e5e5;
            font-size: 2.2em;
            text-align: center;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
            border-bottom: 3px solid #00e5e5;
            padding-bottom: 15px;
        }
        
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
        }
        
        .card {
            background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
            border: 2px solid #00e5e5;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 229, 229, 0.1), transparent);
            transition: left 0.5s;
        }
        
        .card:hover::before {
            left: 100%;
        }
        
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0, 229, 229, 0.3);
            border-color: #ff6b6b;
        }
        
        .card img {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
            margin-bottom: 15px;
            border-radius: 10px;
            background: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #00e5e5;
            font-size: 3em;
        }
        
        .card h3 {
            color: #ffffff;
            font-size: 1.2em;
            margin-bottom: 15px;
            font-weight: bold;
            min-height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        
        .precio {
            color: #ff6b6b;
            font-weight: bold;
            font-size: 1.6em;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(255, 107, 107, 0.3);
        }
        
        .btn-agregar {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            width: 100%;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }
        
        .btn-agregar:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
        }
        
        .no-image {
            background: linear-gradient(135deg, #333 0%, #555 100%);
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 3em;
            color: #00e5e5;
        }
        
        .stats {
            background: rgba(0, 229, 229, 0.1);
            border: 1px solid #00e5e5;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 40px;
            text-align: center;
        }
        
        .stats h3 {
            color: #00e5e5;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .stat-item {
            background: rgba(255, 107, 107, 0.1);
            border-radius: 10px;
            padding: 15px;
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #ff6b6b;
        }
        
        .stat-label {
            color: #cccccc;
            font-size: 0.9em;
        }
        
        .navigation {
            text-align: center;
            margin: 50px 0;
        }
        
        .nav-link {
            color: #00e5e5;
            text-decoration: none;
            font-size: 18px;
            margin: 0 15px;
            padding: 12px 25px;
            border: 2px solid #00e5e5;
            border-radius: 25px;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .nav-link:hover {
            background: #00e5e5;
            color: #000;
            transform: translateY(-2px);
        }
        
        .footer {
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
            text-align: center;
            padding: 40px 20px;
            margin-top: 60px;
            border-top: 2px solid #00e5e5;
        }
        
        .footer p {
            color: #00e5e5;
            margin-bottom: 10px;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }
            
            .grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }
            
            .categoria h2 {
                font-size: 1.8em;
            }
            
            .nav-link {
                display: block;
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>🏪 Ferretería FIME COMPANY</h1>
        <p class="subtitle">Catálogo Completo • Herramientas Profesionales • Materiales de Calidad</p>
    </header>

    <div class="container">
        <div class="search-container">
            <input type="text" class="search-bar" placeholder="🔍 Buscar productos en nuestro catálogo..." id="searchInput">
        </div>

        <?php
        // Calcular estadísticas
        $total_categorias = count($cats['categorias']);
        $total_productos = 0;
        foreach ($cats['categorias'] as $cat) {
            $total_productos += count($cat['productos']);
        }
        ?>

        <div class="stats">
            <h3>📊 Estadísticas del Catálogo</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number"><?php echo $total_categorias; ?></div>
                    <div class="stat-label">Categorías</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><?php echo $total_productos; ?></div>
                    <div class="stat-label">Productos</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">100%</div>
                    <div class="stat-label">Calidad</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Disponible</div>
                </div>
            </div>
        </div>

        <?php foreach ($cats['categorias'] as $cat): ?>
            <div class="categoria">
                <h2><?php echo htmlspecialchars($cat['nombre']); ?></h2>
                <div class="grid">
                    <?php foreach ($cat['productos'] as $p): ?>
                        <div class="card">
                            <?php if (!empty($p['imagen']) && file_exists('imagenes/'.$p['imagen'])): ?>
                                <img src="imagenes/<?php echo htmlspecialchars($p['imagen']); ?>" alt="<?php echo htmlspecialchars($p['nombre']); ?>">
                            <?php else: ?>
                                <div class="no-image">🛠️</div>
                            <?php endif; ?>
                            <h3><?php echo htmlspecialchars($p['nombre']); ?></h3>
                            <div class="precio"><?php echo htmlspecialchars($p['precio']); ?></div>
                            <button class="btn-agregar" onclick="agregarCarrito('<?php echo htmlspecialchars($p['nombre']); ?>', '<?php echo htmlspecialchars($p['precio']); ?>')">
                                🛒 Agregar al Carrito
                            </button>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <div class="navigation">
        <a href="../index.html" class="nav-link">🏠 Portal Principal</a>
        <a href="../industria/index.html" class="nav-link">🏭 Industria</a>
        <a href="#" class="nav-link">📞 Contacto</a>
        <a href="#" class="nav-link">🛒 Ver Carrito</a>
    </div>

    <footer class="footer">
        <p>© 2024 FIME COMPANY - Ferretería Profesional | Catálogo Completo</p>
        <p>📞 Teléfono: (555) 123-4567 | 📧 ferreteria@fimecompany.com</p>
        <p>🏪 Más de <?php echo $total_productos; ?> productos disponibles en <?php echo $total_categorias; ?> categorías</p>
    </footer>

    <script>
        // Funcionalidad de búsqueda
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.card');
            const categorias = document.querySelectorAll('.categoria');
            
            categorias.forEach(categoria => {
                let hasVisibleCards = false;
                const cardsInCategory = categoria.querySelectorAll('.card');
                
                cardsInCategory.forEach(card => {
                    const title = card.querySelector('h3').textContent.toLowerCase();
                    
                    if (title.includes(searchTerm) || searchTerm === '') {
                        card.style.display = 'block';
                        hasVisibleCards = true;
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Mostrar/ocultar categoría completa si no hay productos visibles
                categoria.style.display = hasVisibleCards ? 'block' : 'none';
            });
        });
        
        // Funcionalidad del carrito
        function agregarCarrito(nombre, precio) {
            // Encontrar el botón que fue clickeado
            const buttons = document.querySelectorAll('.btn-agregar');
            let clickedButton = null;
            
            buttons.forEach(btn => {
                if (btn.textContent.includes('Agregar al Carrito')) {
                    const card = btn.closest('.card');
                    const cardTitle = card.querySelector('h3').textContent;
                    if (cardTitle === nombre) {
                        clickedButton = btn;
                    }
                }
            });
            
            if (clickedButton) {
                // Animación del botón
                clickedButton.style.background = '#4ecdc4';
                clickedButton.innerHTML = '✅ Agregado al Carrito';
                
                setTimeout(() => {
                    clickedButton.style.background = 'linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%)';
                    clickedButton.innerHTML = '🛒 Agregar al Carrito';
                }, 2000);
            }
            
            // Aquí se puede integrar con un sistema de carrito real
            console.log('Producto agregado:', nombre, precio);
            
            // Mostrar notificación (opcional)
            if (typeof showNotification === 'function') {
                showNotification('Producto agregado: ' + nombre);
            }
        }
        
        // Efecto de carga
        window.addEventListener('load', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = 'all 0.6s ease';
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 50);
            });
        });
    </script>
</body>
</html>



// Verificar si existe el archivo de categorías
$categorias_file = 'categorias.json';
if (!file_exists($categorias_file)) {
    die('Error: Archivo de categorías no encontrado');
}

// Cargar categorías
$cats = json_decode(file_get_contents($categorias_file), true);
if (!$cats) {
    die('Error: No se pudieron cargar las categorías');
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Catálogo completo de Ferretería FIME COMPANY - Herramientas, materiales de construcción, equipos industriales">
    <meta name="keywords" content="ferretería, herramientas, construcción, materiales, equipos, FIME COMPANY">
    <title>Catálogo Ferretería - FIME COMPANY</title>
    <link rel="canonical" href="https://fimecompany.com/ferreteria/">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
            color: #ffffff;
            line-height: 1.6;
            min-height: 100vh;
        }
        
        .header {
            background: linear-gradient(90deg, #00e5e5 0%, #00b3b3 100%);
            color: #000;
            padding: 30px 0;
            text-align: center;
            box-shadow: 0 4px 20px rgba(0, 229, 229, 0.3);
            margin-bottom: 40px;
        }
        
        .header h1 {
            font-size: 2.8em;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 3px;
            margin-bottom: 10px;
        }
        
        .header .subtitle {
            font-size: 1.3em;
            font-weight: 500;
            opacity: 0.9;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .search-container {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .search-bar {
            background: rgba(0, 229, 229, 0.1);
            border: 2px solid #00e5e5;
            border-radius: 50px;
            padding: 15px 30px;
            width: 100%;
            max-width: 600px;
            font-size: 16px;
            color: #fff;
            text-align: center;
        }
        
        .search-bar::placeholder {
            color: #00e5e5;
        }
        
        .categoria {
            margin-bottom: 60px;
            background: rgba(26, 26, 26, 0.8);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(0, 229, 229, 0.2);
        }
        
        .categoria h2 {
            color: #00e5e5;
            font-size: 2.2em;
            text-align: center;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
            border-bottom: 3px solid #00e5e5;
            padding-bottom: 15px;
        }
        
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
        }
        
        .card {
            background: linear-gradient(135deg, #1a1a1a 0%, #2a2a2a 100%);
            border: 2px solid #00e5e5;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 229, 229, 0.1), transparent);
            transition: left 0.5s;
        }
        
        .card:hover::before {
            left: 100%;
        }
        
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0, 229, 229, 0.3);
            border-color: #ff6b6b;
        }
        
        .card img {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
            margin-bottom: 15px;
            border-radius: 10px;
            background: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #00e5e5;
            font-size: 3em;
        }
        
        .card h3 {
            color: #ffffff;
            font-size: 1.2em;
            margin-bottom: 15px;
            font-weight: bold;
            min-height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        
        .precio {
            color: #ff6b6b;
            font-weight: bold;
            font-size: 1.6em;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(255, 107, 107, 0.3);
        }
        
        .btn-agregar {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            width: 100%;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }
        
        .btn-agregar:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 107, 107, 0.4);
        }
        
        .no-image {
            background: linear-gradient(135deg, #333 0%, #555 100%);
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 3em;
            color: #00e5e5;
        }
        
        .stats {
            background: rgba(0, 229, 229, 0.1);
            border: 1px solid #00e5e5;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 40px;
            text-align: center;
        }
        
        .stats h3 {
            color: #00e5e5;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .stat-item {
            background: rgba(255, 107, 107, 0.1);
            border-radius: 10px;
            padding: 15px;
        }
        
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #ff6b6b;
        }
        
        .stat-label {
            color: #cccccc;
            font-size: 0.9em;
        }
        
        .navigation {
            text-align: center;
            margin: 50px 0;
        }
        
        .nav-link {
            color: #00e5e5;
            text-decoration: none;
            font-size: 18px;
            margin: 0 15px;
            padding: 12px 25px;
            border: 2px solid #00e5e5;
            border-radius: 25px;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        .nav-link:hover {
            background: #00e5e5;
            color: #000;
            transform: translateY(-2px);
        }
        
        .footer {
            background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
            text-align: center;
            padding: 40px 20px;
            margin-top: 60px;
            border-top: 2px solid #00e5e5;
        }
        
        .footer p {
            color: #00e5e5;
            margin-bottom: 10px;
        }
        
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2em;
            }
            
            .grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }
            
            .categoria h2 {
                font-size: 1.8em;
            }
            
            .nav-link {
                display: block;
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>🏪 Ferretería FIME COMPANY</h1>
        <p class="subtitle">Catálogo Completo • Herramientas Profesionales • Materiales de Calidad</p>
    </header>

    <div class="container">
        <div class="search-container">
            <input type="text" class="search-bar" placeholder="🔍 Buscar productos en nuestro catálogo..." id="searchInput">
        </div>

        <?php
        // Calcular estadísticas
        $total_categorias = count($cats['categorias']);
        $total_productos = 0;
        foreach ($cats['categorias'] as $cat) {
            $total_productos += count($cat['productos']);
        }
        ?>

        <div class="stats">
            <h3>📊 Estadísticas del Catálogo</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number"><?php echo $total_categorias; ?></div>
                    <div class="stat-label">Categorías</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number"><?php echo $total_productos; ?></div>
                    <div class="stat-label">Productos</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">100%</div>
                    <div class="stat-label">Calidad</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Disponible</div>
                </div>
            </div>
        </div>

        <?php foreach ($cats['categorias'] as $cat): ?>
            <div class="categoria">
                <h2><?php echo htmlspecialchars($cat['nombre']); ?></h2>
                <div class="grid">
                    <?php foreach ($cat['productos'] as $p): ?>
                        <div class="card">
                            <?php if (!empty($p['imagen']) && file_exists('imagenes/'.$p['imagen'])): ?>
                                <img src="imagenes/<?php echo htmlspecialchars($p['imagen']); ?>" alt="<?php echo htmlspecialchars($p['nombre']); ?>">
                            <?php else: ?>
                                <div class="no-image">🛠️</div>
                            <?php endif; ?>
                            <h3><?php echo htmlspecialchars($p['nombre']); ?></h3>
                            <div class="precio"><?php echo htmlspecialchars($p['precio']); ?></div>
                            <button class="btn-agregar" onclick="agregarCarrito('<?php echo htmlspecialchars($p['nombre']); ?>', '<?php echo htmlspecialchars($p['precio']); ?>')">
                                🛒 Agregar al Carrito
                            </button>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <div class="navigation">
        <a href="../index.html" class="nav-link">🏠 Portal Principal</a>
        <a href="../industria/index.html" class="nav-link">🏭 Industria</a>
        <a href="#" class="nav-link">📞 Contacto</a>
        <a href="#" class="nav-link">🛒 Ver Carrito</a>
    </div>

    <footer class="footer">
        <p>© 2024 FIME COMPANY - Ferretería Profesional | Catálogo Completo</p>
        <p>📞 Teléfono: (555) 123-4567 | 📧 ferreteria@fimecompany.com</p>
        <p>🏪 Más de <?php echo $total_productos; ?> productos disponibles en <?php echo $total_categorias; ?> categorías</p>
    </footer>

    <script>
        // Funcionalidad de búsqueda
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.card');
            const categorias = document.querySelectorAll('.categoria');
            
            categorias.forEach(categoria => {
                let hasVisibleCards = false;
                const cardsInCategory = categoria.querySelectorAll('.card');
                
                cardsInCategory.forEach(card => {
                    const title = card.querySelector('h3').textContent.toLowerCase();
                    
                    if (title.includes(searchTerm) || searchTerm === '') {
                        card.style.display = 'block';
                        hasVisibleCards = true;
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Mostrar/ocultar categoría completa si no hay productos visibles
                categoria.style.display = hasVisibleCards ? 'block' : 'none';
            });
        });
        
        // Funcionalidad del carrito
        function agregarCarrito(nombre, precio) {
            // Encontrar el botón que fue clickeado
            const buttons = document.querySelectorAll('.btn-agregar');
            let clickedButton = null;
            
            buttons.forEach(btn => {
                if (btn.textContent.includes('Agregar al Carrito')) {
                    const card = btn.closest('.card');
                    const cardTitle = card.querySelector('h3').textContent;
                    if (cardTitle === nombre) {
                        clickedButton = btn;
                    }
                }
            });
            
            if (clickedButton) {
                // Animación del botón
                clickedButton.style.background = '#4ecdc4';
                clickedButton.innerHTML = '✅ Agregado al Carrito';
                
                setTimeout(() => {
                    clickedButton.style.background = 'linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%)';
                    clickedButton.innerHTML = '🛒 Agregar al Carrito';
                }, 2000);
            }
            
            // Aquí se puede integrar con un sistema de carrito real
            console.log('Producto agregado:', nombre, precio);
            
            // Mostrar notificación (opcional)
            if (typeof showNotification === 'function') {
                showNotification('Producto agregado: ' + nombre);
            }
        }
        
        // Efecto de carga
        window.addEventListener('load', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                card.style.transition = 'all 0.6s ease';
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 50);
            });
        });
    </script>
</body>
</html>






