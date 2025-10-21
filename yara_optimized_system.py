#!/usr/bin/env python3
"""
Sistema Optimizado YARA - Inicia localhost, abre panel comercial y verifica API
Integrado con Quantum Programmer Bot
"""

import os
import sys
import json
import time
import webbrowser
import subprocess
import requests
import threading
from datetime import datetime
from pathlib import Path
import signal

class YaraOptimizedSystem:
    def __init__(self):
        self.system_name = "YARA Optimized System"
        self.version = "2.0.0"
        self.localhost_port = 8080
        self.yara_api_port = 3000
        self.localhost_url = f"http://localhost:{self.localhost_port}"
        self.yara_api_url = f"http://localhost:{self.yara_api_port}/api/yara"
        self.panel_file = "yara_optimized_panel.html"
        self.processes = []
        self.running = True
        
    def create_optimized_panel(self):
        """Crea el panel comercial optimizado"""
        
        html_content = f"""
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{self.system_name} v{self.version}</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}
        
        body {{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            color: #333;
        }}
        
        .container {{
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }}
        
        .header {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            text-align: center;
            position: relative;
            overflow: hidden;
        }}
        
        .header::before {{
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6b6b, #4ecdc4, #45b7d1, #96ceb4);
        }}
        
        .header h1 {{
            color: #2c3e50;
            font-size: 3em;
            margin-bottom: 15px;
            font-weight: 700;
        }}
        
        .header p {{
            color: #7f8c8d;
            font-size: 1.3em;
            margin-bottom: 20px;
        }}
        
        .status-badge {{
            display: inline-block;
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            font-weight: bold;
            font-size: 0.9em;
        }}
        
        .services-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }}
        
        .service-card {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }}
        
        .service-card::before {{
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #3498db, #9b59b6);
        }}
        
        .service-card:hover {{
            transform: translateY(-8px);
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
        }}
        
        .service-header {{
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }}
        
        .service-icon {{
            font-size: 2.5em;
            margin-right: 15px;
        }}
        
        .service-title {{
            color: #2c3e50;
            font-size: 1.4em;
            font-weight: 600;
        }}
        
        .status-indicator {{
            display: inline-block;
            width: 15px;
            height: 15px;
            border-radius: 50%;
            margin-right: 10px;
            position: relative;
        }}
        
        .status-online {{
            background: linear-gradient(45deg, #27ae60, #2ecc71);
            animation: pulse-green 2s infinite;
        }}
        
        .status-offline {{
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            animation: pulse-red 2s infinite;
        }}
        
        .status-checking {{
            background: linear-gradient(45deg, #f39c12, #e67e22);
            animation: pulse-orange 1s infinite;
        }}
        
        @keyframes pulse-green {{
            0%, 100% {{ opacity: 1; transform: scale(1); }}
            50% {{ opacity: 0.7; transform: scale(1.1); }}
        }}
        
        @keyframes pulse-red {{
            0%, 100% {{ opacity: 1; transform: scale(1); }}
            50% {{ opacity: 0.7; transform: scale(1.1); }}
        }}
        
        @keyframes pulse-orange {{
            0%, 100% {{ opacity: 1; transform: scale(1); }}
            50% {{ opacity: 0.5; transform: scale(1.2); }}
        }}
        
        .service-info {{
            margin-bottom: 15px;
        }}
        
        .info-row {{
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            padding: 8px 0;
            border-bottom: 1px solid #ecf0f1;
        }}
        
        .info-label {{
            font-weight: 600;
            color: #34495e;
        }}
        
        .info-value {{
            color: #7f8c8d;
            font-family: 'Courier New', monospace;
        }}
        
        .metrics-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }}
        
        .metric-card {{
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            border-left: 4px solid #3498db;
        }}
        
        .metric-value {{
            font-size: 1.5em;
            font-weight: bold;
            color: #2c3e50;
        }}
        
        .metric-label {{
            font-size: 0.8em;
            color: #7f8c8d;
            margin-top: 5px;
        }}
        
        .controls-section {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }}
        
        .controls-title {{
            color: #2c3e50;
            font-size: 1.5em;
            margin-bottom: 20px;
            text-align: center;
        }}
        
        .controls-grid {{
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }}
        
        .btn {{
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }}
        
        .btn:hover {{
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
        }}
        
        .btn-success {{
            background: linear-gradient(45deg, #27ae60, #229954);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.3);
        }}
        
        .btn-warning {{
            background: linear-gradient(45deg, #f39c12, #e67e22);
            box-shadow: 0 5px 15px rgba(243, 156, 18, 0.3);
        }}
        
        .btn-danger {{
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }}
        
        .btn-info {{
            background: linear-gradient(45deg, #17a2b8, #138496);
            box-shadow: 0 5px 15px rgba(23, 162, 184, 0.3);
        }}
        
        .log-section {{
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }}
        
        .log-header {{
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }}
        
        .log-title {{
            color: #2c3e50;
            font-size: 1.5em;
            font-weight: 600;
        }}
        
        .log-controls {{
            display: flex;
            gap: 10px;
        }}
        
        .log-content {{
            background: #2c3e50;
            color: #ecf0f1;
            padding: 20px;
            border-radius: 15px;
            font-family: 'Courier New', monospace;
            font-size: 0.9em;
            max-height: 400px;
            overflow-y: auto;
            border: 2px solid #34495e;
        }}
        
        .log-entry {{
            margin-bottom: 10px;
            padding: 8px 0;
            border-bottom: 1px solid #34495e;
        }}
        
        .log-timestamp {{
            color: #95a5a6;
            font-size: 0.8em;
            margin-right: 10px;
        }}
        
        .log-message {{
            color: #ecf0f1;
        }}
        
        .log-success {{
            color: #2ecc71;
        }}
        
        .log-error {{
            color: #e74c3c;
        }}
        
        .log-warning {{
            color: #f39c12;
        }}
        
        .log-info {{
            color: #3498db;
        }}
        
        .footer {{
            text-align: center;
            margin-top: 30px;
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9em;
        }}
        
        .auto-refresh {{
            position: fixed;
            top: 20px;
            right: 20px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 10px 15px;
            border-radius: 20px;
            font-size: 0.8em;
        }}
        
        @media (max-width: 768px) {{
            .container {{
                padding: 10px;
            }}
            
            .header h1 {{
                font-size: 2em;
            }}
            
            .services-grid {{
                grid-template-columns: 1fr;
            }}
            
            .controls-grid {{
                grid-template-columns: 1fr;
            }}
        }}
    </style>
</head>
<body>
    <div class="auto-refresh" id="auto-refresh">
        🔄 Auto-refresh: <span id="refresh-timer">30s</span>
    </div>
    
    <div class="container">
        <div class="header">
            <h1>🚀 {self.system_name}</h1>
            <p>Sistema optimizado con localhost, panel comercial y verificación de API YARA</p>
            <div class="status-badge" id="overall-status">Iniciando sistema...</div>
        </div>
        
        <div class="services-grid">
            <div class="service-card">
                <div class="service-header">
                    <div class="service-icon">🌐</div>
                    <div class="service-title">Localhost Server</div>
                </div>
                <div class="service-info">
                    <div class="info-row">
                        <span class="info-label">Status:</span>
                        <span>
                            <span class="status-indicator status-checking" id="localhost-indicator"></span>
                            <span id="localhost-status">Verificando...</span>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">URL:</span>
                        <span class="info-value">{self.localhost_url}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Puerto:</span>
                        <span class="info-value">{self.localhost_port}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Última verificación:</span>
                        <span class="info-value" id="localhost-last-check">-</span>
                    </div>
                </div>
                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-value" id="localhost-response-time">-</div>
                        <div class="metric-label">ms</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value" id="localhost-status-code">-</div>
                        <div class="metric-label">Status</div>
                    </div>
                </div>
            </div>
            
            <div class="service-card">
                <div class="service-header">
                    <div class="service-icon">⚛️</div>
                    <div class="service-title">YARA API</div>
                </div>
                <div class="service-info">
                    <div class="info-row">
                        <span class="info-label">Status:</span>
                        <span>
                            <span class="status-indicator status-checking" id="yara-indicator"></span>
                            <span id="yara-status">Verificando...</span>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">URL:</span>
                        <span class="info-value">{self.yara_api_url}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Puerto:</span>
                        <span class="info-value">{self.yara_api_port}</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Última verificación:</span>
                        <span class="info-value" id="yara-last-check">-</span>
                    </div>
                </div>
                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-value" id="yara-response-time">-</div>
                        <div class="metric-label">ms</div>
                    </div>
                    <div class="metric-card">
                        <div class="metric-value" id="yara-status-code">-</div>
                        <div class="metric-label">Status</div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="controls-section">
            <div class="controls-title">🎛️ Controles del Sistema</div>
            <div class="controls-grid">
                <button class="btn" onclick="checkAllServices()">🔄 Verificar Todo</button>
                <button class="btn btn-success" onclick="startLocalhost()">🌐 Iniciar Localhost</button>
                <button class="btn btn-warning" onclick="testYaraAPI()">⚛️ Probar YARA API</button>
                <button class="btn btn-info" onclick="openLocalhost()">🔗 Abrir Localhost</button>
                <button class="btn btn-danger" onclick="clearLogs()">🗑️ Limpiar Logs</button>
                <button class="btn" onclick="exportLogs()">📥 Exportar Logs</button>
            </div>
        </div>
        
        <div class="log-section">
            <div class="log-header">
                <div class="log-title">📝 Log del Sistema</div>
                <div class="log-controls">
                    <button class="btn" onclick="toggleAutoRefresh()" id="auto-refresh-btn">⏸️ Pausar Auto-refresh</button>
                </div>
            </div>
            <div class="log-content" id="log-content">
                <div class="log-entry">
                    <span class="log-timestamp">[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}]</span>
                    <span class="log-info">🚀 Sistema YARA Optimizado iniciado</span>
                </div>
                <div class="log-entry">
                    <span class="log-timestamp">[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}]</span>
                    <span class="log-info">⚙️ Iniciando verificación de servicios...</span>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>Desarrollado con Quantum Programmer Bot | {datetime.now().year} | v{self.version}</p>
        </div>
    </div>
    
    <script>
        let autoRefreshInterval;
        let refreshTimer = 30;
        let autoRefreshEnabled = true;
        
        function updateTime() {{
            document.getElementById('refresh-timer').textContent = refreshTimer + 's';
        }}
        
        function addLog(message, type = 'info') {{
            const logContent = document.getElementById('log-content');
            const timestamp = new Date().toLocaleString();
            const logEntry = document.createElement('div');
            logEntry.className = 'log-entry';
            
            const typeClass = 'log-' + type;
            logEntry.innerHTML = `
                <span class="log-timestamp">[${{timestamp}}]</span>
                <span class="log-message ${{typeClass}}">${{message}}</span>
            `;
            
            logContent.appendChild(logEntry);
            logContent.scrollTop = logContent.scrollHeight;
        }}
        
        function updateServiceStatus(service, status, message, responseTime = null, statusCode = null) {{
            const indicator = document.getElementById(service + '-indicator');
            const statusText = document.getElementById(service + '-status');
            const lastCheck = document.getElementById(service + '-last-check');
            
            indicator.className = 'status-indicator status-' + status;
            statusText.textContent = message;
            lastCheck.textContent = new Date().toLocaleTimeString();
            
            if (responseTime !== null) {{
                document.getElementById(service + '-response-time').textContent = Math.round(responseTime);
            }}
            
            if (statusCode !== null) {{
                document.getElementById(service + '-status-code').textContent = statusCode;
            }}
        }}
        
        async function checkLocalhost() {{
            try {{
                const startTime = Date.now();
                const response = await fetch('{self.localhost_url}', {{
                    method: 'GET',
                    mode: 'no-cors',
                    cache: 'no-cache'
                }});
                const responseTime = Date.now() - startTime;
                
                updateServiceStatus('localhost', 'online', 'Conectado', responseTime, 200);
                addLog('✅ Localhost verificado exitosamente', 'success');
                return true;
            }} catch (error) {{
                updateServiceStatus('localhost', 'offline', 'Desconectado');
                addLog('❌ Error conectando a localhost: ' + error.message, 'error');
                return false;
            }}
        }}
        
        async function checkYaraAPI() {{
            try {{
                const startTime = Date.now();
                const response = await fetch('{self.yara_api_url}', {{
                    method: 'GET',
                    headers: {{
                        'Content-Type': 'application/json'
                    }}
                }});
                const responseTime = Date.now() - startTime;
                
                if (response.ok) {{
                    const data = await response.json();
                    updateServiceStatus('yara', 'online', 'API Funcionando', responseTime, response.status);
                    addLog('✅ YARA API verificada exitosamente', 'success');
                    return true;
                }} else {{
                    updateServiceStatus('yara', 'offline', 'API Error: ' + response.status);
                    addLog('❌ YARA API error: ' + response.status, 'error');
                    return false;
                }}
            }} catch (error) {{
                updateServiceStatus('yara', 'offline', 'API Desconectada');
                addLog('❌ Error conectando a YARA API: ' + error.message, 'error');
                return false;
            }}
        }}
        
        async function checkAllServices() {{
            addLog('🔄 Iniciando verificación completa de servicios...', 'info');
            
            const localhostOk = await checkLocalhost();
            const yaraOk = await checkYaraAPI();
            
            if (localhostOk && yaraOk) {{
                document.getElementById('overall-status').textContent = 'Todos los servicios online';
                addLog('✅ Todos los servicios verificados exitosamente', 'success');
            }} else if (localhostOk || yaraOk) {{
                document.getElementById('overall-status').textContent = 'Servicios parcialmente online';
                addLog('⚠️ Algunos servicios no están disponibles', 'warning');
            }} else {{
                document.getElementById('overall-status').textContent = 'Servicios offline';
                addLog('❌ Ningún servicio está disponible', 'error');
            }}
        }}
        
        function startLocalhost() {{
            addLog('🌐 Iniciando servidor localhost...', 'info');
            // Aquí se podría implementar la lógica para iniciar localhost
            addLog('💡 Usa el comando: python3 -m http.server 8080', 'info');
        }}
        
        function testYaraAPI() {{
            addLog('⚛️ Probando YARA API...', 'info');
            checkYaraAPI();
        }}
        
        function openLocalhost() {{
            window.open('{self.localhost_url}', '_blank');
            addLog('🌐 Abriendo localhost en nueva pestaña', 'info');
        }}
        
        function clearLogs() {{
            document.getElementById('log-content').innerHTML = '';
            addLog('🗑️ Logs limpiados', 'info');
        }}
        
        function exportLogs() {{
            const logContent = document.getElementById('log-content').innerText;
            const blob = new Blob([logContent], {{ type: 'text/plain' }});
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'yara_system_logs_' + new Date().toISOString().slice(0, 19).replace(/:/g, '-') + '.txt';
            a.click();
            URL.revokeObjectURL(url);
            addLog('📥 Logs exportados exitosamente', 'success');
        }}
        
        function toggleAutoRefresh() {{
            autoRefreshEnabled = !autoRefreshEnabled;
            const btn = document.getElementById('auto-refresh-btn');
            
            if (autoRefreshEnabled) {{
                btn.textContent = '⏸️ Pausar Auto-refresh';
                addLog('🔄 Auto-refresh activado', 'info');
            }} else {{
                btn.textContent = '▶️ Reanudar Auto-refresh';
                addLog('⏸️ Auto-refresh pausado', 'warning');
            }}
        }}
        
        function startAutoRefresh() {{
            autoRefreshInterval = setInterval(() => {{
                if (autoRefreshEnabled) {{
                    refreshTimer--;
                    updateTime();
                    
                    if (refreshTimer <= 0) {{
                        checkAllServices();
                        refreshTimer = 30;
                    }}
                }}
            }}, 1000);
        }}
        
        // Inicialización
        document.addEventListener('DOMContentLoaded', function() {{
            updateTime();
            checkAllServices();
            startAutoRefresh();
            addLog('🚀 Sistema YARA Optimizado cargado completamente', 'success');
        }});
        
        // Limpiar al cerrar
        window.addEventListener('beforeunload', function() {{
            if (autoRefreshInterval) {{
                clearInterval(autoRefreshInterval);
            }}
        }});
    </script>
</body>
</html>
"""
        
        with open(self.panel_file, 'w', encoding='utf-8') as f:
            f.write(html_content)
        
        return self.panel_file
    
    def start_localhost_server(self):
        """Inicia el servidor localhost optimizado"""
        try:
            # Intentar diferentes métodos para iniciar localhost
            methods = [
                f"python3 -m http.server {self.localhost_port}",
                f"python -m http.server {self.localhost_port}",
                f"python3 -m SimpleHTTPServer {self.localhost_port}",
                f"python -m SimpleHTTPServer {self.localhost_port}"
            ]
            
            for method in methods:
                try:
                    print(f"🔄 Intentando iniciar localhost con: {method}")
                    process = subprocess.Popen(
                        method.split(),
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        cwd=os.getcwd()
                    )
                    
                    # Verificar si el proceso se inició correctamente
                    time.sleep(2)
                    if process.poll() is None:
                        self.processes.append(process)
                        print(f"✅ Localhost iniciado exitosamente en puerto {self.localhost_port}")
                        return True
                    else:
                        print(f"❌ Falló método: {method}")
                        
                except Exception as e:
                    print(f"❌ Error con método {method}: {e}")
                    continue
            
            print("❌ No se pudo iniciar localhost con ningún método")
            return False
            
        except Exception as e:
            print(f"❌ Error iniciando localhost: {e}")
            return False
    
    def check_localhost(self):
        """Verifica el estado del localhost"""
        try:
            response = requests.get(self.localhost_url, timeout=5)
            return {
                "status": "online",
                "message": f"Localhost respondiendo (Status: {response.status_code})",
                "response_time": response.elapsed.total_seconds() * 1000,
                "status_code": response.status_code
            }
        except requests.exceptions.ConnectionError:
            return {
                "status": "offline", 
                "message": "Localhost no disponible - Conexión rechazada",
                "response_time": None,
                "status_code": None
            }
        except requests.exceptions.Timeout:
            return {
                "status": "timeout",
                "message": "Localhost no responde - Timeout",
                "response_time": None,
                "status_code": None
            }
        except Exception as e:
            return {
                "status": "error",
                "message": f"Error verificando localhost: {e}",
                "response_time": None,
                "status_code": None
            }
    
    def check_yara_api(self):
        """Verifica el estado de la API de YARA"""
        try:
            response = requests.get(self.yara_api_url, timeout=5)
            if response.status_code == 200:
                return {
                    "status": "online",
                    "message": f"YARA API funcionando (Status: {response.status_code})",
                    "response_time": response.elapsed.total_seconds() * 1000,
                    "status_code": response.status_code,
                    "data": response.json() if response.headers.get('content-type', '').startswith('application/json') else response.text
                }
            else:
                return {
                    "status": "error",
                    "message": f"YARA API error (Status: {response.status_code})",
                    "response_time": response.elapsed.total_seconds() * 1000,
                    "status_code": response.status_code
                }
        except requests.exceptions.ConnectionError:
            return {
                "status": "offline",
                "message": "YARA API no disponible - Conexión rechazada",
                "response_time": None,
                "status_code": None
            }
        except requests.exceptions.Timeout:
            return {
                "status": "timeout", 
                "message": "YARA API no responde - Timeout",
                "response_time": None,
                "status_code": None
            }
        except Exception as e:
            return {
                "status": "error",
                "message": f"Error verificando YARA API: {e}",
                "response_time": None,
                "status_code": None
            }
    
    def open_optimized_panel(self):
        """Abre el panel optimizado en el navegador"""
        try:
            # Crear el archivo HTML
            html_file = self.create_optimized_panel()
            file_path = os.path.abspath(html_file)
            
            # Abrir en el navegador
            webbrowser.open(f"file://{file_path}")
            
            return {
                "success": True,
                "message": f"✅ Panel optimizado abierto en el navegador",
                "file": html_file,
                "path": file_path
            }
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error abriendo panel optimizado: {e}"
            }
    
    def verify_all_services(self):
        """Verifica todos los servicios"""
        print("🔄 Verificando todos los servicios...")
        
        localhost_result = self.check_localhost()
        yara_result = self.check_yara_api()
        
        print(f"\n🌐 Localhost ({self.localhost_url}):")
        print(f"   Status: {localhost_result['status']}")
        print(f"   Mensaje: {localhost_result['message']}")
        if localhost_result.get('response_time'):
            print(f"   Tiempo de respuesta: {localhost_result['response_time']:.2f}ms")
        
        print(f"\n⚛️ YARA API ({self.yara_api_url}):")
        print(f"   Status: {yara_result['status']}")
        print(f"   Mensaje: {yara_result['message']}")
        if yara_result.get('response_time'):
            print(f"   Tiempo de respuesta: {yara_result['response_time']:.2f}ms")
        
        overall_status = "online" if localhost_result["status"] == "online" and yara_result["status"] == "online" else "partial"
        
        return {
            "localhost": localhost_result,
            "yara_api": yara_result,
            "overall_status": overall_status
        }
    
    def cleanup(self):
        """Limpia los procesos al cerrar"""
        print("\n🧹 Limpiando procesos...")
        for process in self.processes:
            try:
                process.terminate()
                process.wait(timeout=5)
            except:
                try:
                    process.kill()
                except:
                    pass
        print("✅ Limpieza completada")
    
    def run_optimized_system(self):
        """Ejecuta el sistema optimizado completo"""
        print(f"🚀 {self.system_name} v{self.version}")
        print("=" * 60)
        
        try:
            # 1. Iniciar localhost
            print("🌐 Paso 1: Iniciando servidor localhost...")
            localhost_started = self.start_localhost_server()
            
            if localhost_started:
                print("✅ Localhost iniciado exitosamente")
            else:
                print("⚠️ No se pudo iniciar localhost automáticamente")
                print("💡 Puedes iniciarlo manualmente con: python3 -m http.server 8080")
            
            # 2. Crear y abrir panel
            print("\n📊 Paso 2: Creando panel comercial optimizado...")
            panel_result = self.open_optimized_panel()
            
            if panel_result['success']:
                print(f"✅ {panel_result['message']}")
                print(f"📁 Archivo: {panel_result['file']}")
            else:
                print(f"❌ {panel_result['message']}")
            
            # 3. Verificar servicios
            print("\n🔍 Paso 3: Verificando servicios...")
            services = self.verify_all_services()
            
            # 4. Mostrar resumen
            print("\n📋 Resumen del Sistema:")
            print(f"   🌐 Localhost: {services['localhost']['status']}")
            print(f"   ⚛️ YARA API: {services['yara_api']['status']}")
            print(f"   📊 Estado general: {services['overall_status']}")
            
            print(f"\n🎯 Panel disponible en: {panel_result.get('path', 'N/A')}")
            print("💡 El panel se actualiza automáticamente cada 30 segundos")
            print("🔧 Usa los controles del panel para interactuar con los servicios")
            
            # Mantener el sistema corriendo
            print("\n⏳ Sistema corriendo... Presiona Ctrl+C para salir")
            try:
                while self.running:
                    time.sleep(1)
            except KeyboardInterrupt:
                print("\n🛑 Deteniendo sistema...")
                self.running = False
                
        except Exception as e:
            print(f"❌ Error en el sistema: {e}")
        finally:
            self.cleanup()

def main():
    """Función principal"""
    system = YaraOptimizedSystem()
    
    # Configurar manejo de señales para limpieza
    def signal_handler(sig, frame):
        print("\n🛑 Señal de interrupción recibida...")
        system.running = False
        system.cleanup()
        sys.exit(0)
    
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    
    system.run_optimized_system()

if __name__ == "__main__":
    main()