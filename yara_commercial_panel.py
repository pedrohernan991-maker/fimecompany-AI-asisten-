#!/usr/bin/env python3
"""
Panel Comercial HTML con verificación de localhost y API de YARA
Integrado con Quantum Programmer Bot
"""

import os
import sys
import json
import webbrowser
import subprocess
import requests
import time
from datetime import datetime
from pathlib import Path

class YaraCommercialPanel:
    def __init__(self):
        self.panel_name = "YARA Commercial Panel"
        self.version = "1.0.0"
        self.localhost_url = "http://localhost:8080"
        self.yara_api_url = "http://localhost:3000/api/yara"
        self.html_file = "yara_commercial_panel.html"
        
    def create_html_panel(self):
        """Crea el panel comercial HTML"""
        
        html_content = f"""
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{self.panel_name} v{self.version}</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}
        
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }}
        
        .container {{
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }}
        
        .header {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
        }}
        
        .header h1 {{
            color: #2c3e50;
            font-size: 2.5em;
            margin-bottom: 10px;
        }}
        
        .header p {{
            color: #7f8c8d;
            font-size: 1.2em;
        }}
        
        .status-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }}
        
        .status-card {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }}
        
        .status-card:hover {{
            transform: translateY(-5px);
        }}
        
        .status-card h3 {{
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.3em;
        }}
        
        .status-indicator {{
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 10px;
        }}
        
        .status-online {{
            background-color: #27ae60;
            animation: pulse 2s infinite;
        }}
        
        .status-offline {{
            background-color: #e74c3c;
        }}
        
        .status-checking {{
            background-color: #f39c12;
            animation: pulse 1s infinite;
        }}
        
        @keyframes pulse {{
            0% {{ opacity: 1; }}
            50% {{ opacity: 0.5; }}
            100% {{ opacity: 1; }}
        }}
        
        .info-section {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }}
        
        .info-section h3 {{
            color: #2c3e50;
            margin-bottom: 15px;
        }}
        
        .info-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }}
        
        .info-item {{
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #3498db;
        }}
        
        .info-item strong {{
            color: #2c3e50;
            display: block;
            margin-bottom: 5px;
        }}
        
        .controls {{
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 30px;
        }}
        
        .btn {{
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1em;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }}
        
        .btn:hover {{
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }}
        
        .btn-success {{
            background: linear-gradient(45deg, #27ae60, #229954);
        }}
        
        .btn-warning {{
            background: linear-gradient(45deg, #f39c12, #e67e22);
        }}
        
        .btn-danger {{
            background: linear-gradient(45deg, #e74c3c, #c0392b);
        }}
        
        .log-section {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            margin-top: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }}
        
        .log-content {{
            background: #2c3e50;
            color: #ecf0f1;
            padding: 15px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            max-height: 300px;
            overflow-y: auto;
        }}
        
        .timestamp {{
            color: #95a5a6;
            font-size: 0.8em;
        }}
        
        .footer {{
            text-align: center;
            margin-top: 30px;
            color: rgba(255, 255, 255, 0.8);
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 {self.panel_name}</h1>
            <p>Panel de monitoreo comercial con verificación de localhost y API de YARA</p>
        </div>
        
        <div class="status-grid">
            <div class="status-card">
                <h3>🌐 Localhost Status</h3>
                <p>
                    <span class="status-indicator status-checking" id="localhost-indicator"></span>
                    <span id="localhost-status">Verificando...</span>
                </p>
                <p><strong>URL:</strong> {self.localhost_url}</p>
                <p><strong>Puerto:</strong> 8080</p>
            </div>
            
            <div class="status-card">
                <h3>⚛️ YARA API Status</h3>
                <p>
                    <span class="status-indicator status-checking" id="yara-indicator"></span>
                    <span id="yara-status">Verificando...</span>
                </p>
                <p><strong>URL:</strong> {self.yara_api_url}</p>
                <p><strong>Puerto:</strong> 3000</p>
            </div>
            
            <div class="status-card">
                <h3>📊 Sistema Status</h3>
                <p>
                    <span class="status-indicator status-online" id="system-indicator"></span>
                    <span id="system-status">Online</span>
                </p>
                <p><strong>Versión:</strong> {self.version}</p>
                <p><strong>Timestamp:</strong> <span id="current-time"></span></p>
            </div>
        </div>
        
        <div class="info-section">
            <h3>📋 Información del Sistema</h3>
            <div class="info-grid">
                <div class="info-item">
                    <strong>Panel Name</strong>
                    {self.panel_name}
                </div>
                <div class="info-item">
                    <strong>Version</strong>
                    {self.version}
                </div>
                <div class="info-item">
                    <strong>Localhost URL</strong>
                    {self.localhost_url}
                </div>
                <div class="info-item">
                    <strong>YARA API URL</strong>
                    {self.yara_api_url}
                </div>
                <div class="info-item">
                    <strong>Status</strong>
                    <span id="overall-status">Verificando servicios...</span>
                </div>
                <div class="info-item">
                    <strong>Last Check</strong>
                    <span id="last-check">-</span>
                </div>
            </div>
        </div>
        
        <div class="controls">
            <button class="btn" onclick="checkServices()">🔄 Verificar Servicios</button>
            <button class="btn btn-success" onclick="openLocalhost()">🌐 Abrir Localhost</button>
            <button class="btn btn-warning" onclick="testYaraAPI()">⚛️ Probar YARA API</button>
            <button class="btn btn-danger" onclick="clearLogs()">🗑️ Limpiar Logs</button>
        </div>
        
        <div class="log-section">
            <h3>📝 Log de Actividad</h3>
            <div class="log-content" id="log-content">
                <div class="timestamp">[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}]</div>
                <div>🚀 Panel comercial iniciado</div>
                <div>⚛️ Iniciando verificación de servicios...</div>
            </div>
        </div>
        
        <div class="footer">
            <p>Desarrollado con Quantum Programmer Bot | {datetime.now().year}</p>
        </div>
    </div>
    
    <script>
        let checkInterval;
        
        function updateTime() {{
            document.getElementById('current-time').textContent = new Date().toLocaleString();
        }}
        
        function addLog(message) {{
            const logContent = document.getElementById('log-content');
            const timestamp = new Date().toLocaleString();
            const logEntry = document.createElement('div');
            logEntry.innerHTML = `
                <div class="timestamp">[${{timestamp}}]</div>
                <div>${{message}}</div>
            `;
            logContent.appendChild(logEntry);
            logContent.scrollTop = logContent.scrollHeight;
        }}
        
        function updateStatus(service, status, message) {{
            const indicator = document.getElementById(service + '-indicator');
            const statusText = document.getElementById(service + '-status');
            
            indicator.className = 'status-indicator status-' + status;
            statusText.textContent = message;
        }}
        
        async function checkLocalhost() {{
            try {{
                const response = await fetch('{self.localhost_url}', {{
                    method: 'GET',
                    mode: 'no-cors',
                    cache: 'no-cache'
                }});
                updateStatus('localhost', 'online', 'Conectado');
                addLog('✅ Localhost verificado exitosamente');
                return true;
            }} catch (error) {{
                updateStatus('localhost', 'offline', 'Desconectado');
                addLog('❌ Error conectando a localhost: ' + error.message);
                return false;
            }}
        }}
        
        async function checkYaraAPI() {{
            try {{
                const response = await fetch('{self.yara_api_url}', {{
                    method: 'GET',
                    headers: {{
                        'Content-Type': 'application/json'
                    }}
                }});
                
                if (response.ok) {{
                    const data = await response.json();
                    updateStatus('yara', 'online', 'API Funcionando');
                    addLog('✅ YARA API verificada exitosamente');
                    return true;
                }} else {{
                    updateStatus('yara', 'offline', 'API Error: ' + response.status);
                    addLog('❌ YARA API error: ' + response.status);
                    return false;
                }}
            }} catch (error) {{
                updateStatus('yara', 'offline', 'API Desconectada');
                addLog('❌ Error conectando a YARA API: ' + error.message);
                return false;
            }}
        }}
        
        async function checkServices() {{
            addLog('🔄 Iniciando verificación de servicios...');
            document.getElementById('last-check').textContent = new Date().toLocaleString();
            
            const localhostOk = await checkLocalhost();
            const yaraOk = await checkYaraAPI();
            
            if (localhostOk && yaraOk) {{
                document.getElementById('overall-status').textContent = 'Todos los servicios online';
                addLog('✅ Todos los servicios verificados exitosamente');
            }} else {{
                document.getElementById('overall-status').textContent = 'Algunos servicios offline';
                addLog('⚠️ Algunos servicios no están disponibles');
            }}
        }}
        
        function openLocalhost() {{
            window.open('{self.localhost_url}', '_blank');
            addLog('🌐 Abriendo localhost en nueva pestaña');
        }}
        
        async function testYaraAPI() {{
            addLog('⚛️ Probando YARA API...');
            try {{
                const response = await fetch('{self.yara_api_url}', {{
                    method: 'GET',
                    headers: {{
                        'Content-Type': 'application/json'
                    }}
                }});
                
                if (response.ok) {{
                    const data = await response.json();
                    addLog('✅ YARA API responde correctamente');
                    addLog('📊 Datos recibidos: ' + JSON.stringify(data, null, 2));
                }} else {{
                    addLog('❌ YARA API error: ' + response.status);
                }}
            }} catch (error) {{
                addLog('❌ Error probando YARA API: ' + error.message);
            }}
        }}
        
        function clearLogs() {{
            document.getElementById('log-content').innerHTML = '';
            addLog('🗑️ Logs limpiados');
        }}
        
        // Inicialización
        document.addEventListener('DOMContentLoaded', function() {{
            updateTime();
            setInterval(updateTime, 1000);
            checkServices();
            
            // Verificar servicios cada 30 segundos
            checkInterval = setInterval(checkServices, 30000);
            
            addLog('🚀 Panel comercial cargado completamente');
        }});
        
        // Limpiar intervalo al cerrar
        window.addEventListener('beforeunload', function() {{
            if (checkInterval) {{
                clearInterval(checkInterval);
            }}
        }});
    </script>
</body>
</html>
"""
        
        with open(self.html_file, 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        return self.html_file
    
    def check_localhost(self):
        """Verifica el estado del localhost"""
        try:
            response = requests.get(self.localhost_url, timeout=5)
            return {
                "status": "online",
                "message": f"Localhost respondiendo (Status: {response.status_code})",
                "response_time": response.elapsed.total_seconds()
            }
        except requests.exceptions.ConnectionError:
            return {
                "status": "offline", 
                "message": "Localhost no disponible - Conexión rechazada"
            }
        except requests.exceptions.Timeout:
            return {
                "status": "timeout",
                "message": "Localhost no responde - Timeout"
            }
        except Exception as e:
            return {
                "status": "error",
                "message": f"Error verificando localhost: {e}"
            }
    
    def check_yara_api(self):
        """Verifica el estado de la API de YARA"""
        try:
            response = requests.get(self.yara_api_url, timeout=5)
            if response.status_code == 200:
                return {
                    "status": "online",
                    "message": f"YARA API funcionando (Status: {response.status_code})",
                    "response_time": response.elapsed.total_seconds(),
                    "data": response.json() if response.headers.get('content-type', '').startswith('application/json') else response.text
                }
            else:
                return {
                    "status": "error",
                    "message": f"YARA API error (Status: {response.status_code})"
                }
        except requests.exceptions.ConnectionError:
            return {
                "status": "offline",
                "message": "YARA API no disponible - Conexión rechazada"
            }
        except requests.exceptions.Timeout:
            return {
                "status": "timeout", 
                "message": "YARA API no responde - Timeout"
            }
        except Exception as e:
            return {
                "status": "error",
                "message": f"Error verificando YARA API: {e}"
            }
    
    def open_panel(self):
        """Abre el panel en el navegador"""
        try:
            # Crear el archivo HTML
            html_file = self.create_html_panel()
            file_path = os.path.abspath(html_file)
            
            # Abrir en el navegador
            webbrowser.open(f"file://{file_path}")
            
            return {
                "success": True,
                "message": f"✅ Panel comercial abierto en el navegador",
                "file": html_file,
                "path": file_path
            }
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error abriendo panel: {e}"
            }
    
    def verify_services(self):
        """Verifica todos los servicios"""
        print("🔄 Verificando servicios...")
        
        localhost_result = self.check_localhost()
        yara_result = self.check_yara_api()
        
        print(f"\n🌐 Localhost ({self.localhost_url}):")
        print(f"   Status: {localhost_result['status']}")
        print(f"   Mensaje: {localhost_result['message']}")
        
        print(f"\n⚛️ YARA API ({self.yara_api_url}):")
        print(f"   Status: {yara_result['status']}")
        print(f"   Mensaje: {yara_result['message']}")
        
        return {
            "localhost": localhost_result,
            "yara_api": yara_result,
            "overall_status": "online" if localhost_result["status"] == "online" and yara_result["status"] == "online" else "partial"
        }

def main():
    """Función principal"""
    panel = YaraCommercialPanel()
    
    print("🚀 YARA Commercial Panel - Quantum Programmer Bot")
    print("=" * 60)
    
    # Verificar servicios
    services = panel.verify_services()
    
    # Abrir panel
    result = panel.open_panel()
    print(f"\n{result['message']}")
    
    if result['success']:
        print(f"📁 Archivo: {result['file']}")
        print(f"📂 Ruta: {result['path']}")
    
    print("\n💡 El panel se actualiza automáticamente cada 30 segundos")
    print("🔧 Usa los botones del panel para interactuar con los servicios")

if __name__ == "__main__":
    main()