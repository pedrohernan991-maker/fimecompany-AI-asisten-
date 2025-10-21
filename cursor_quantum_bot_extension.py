#!/usr/bin/env python3
"""
Extensión Quantum Bot para Cursor Chat
Permite usar el Quantum Programmer Bot directamente desde el chat de Cursor
"""

import json
import os
import sys
import subprocess
from pathlib import Path

class CursorQuantumBotExtension:
    def __init__(self):
        self.bot_path = os.path.join(os.getcwd(), "quantum_programmer_bot.py")
        self.extension_name = "Quantum Programmer Bot"
        self.version = "1.0.0"
        
    def create_cursor_extension_config(self):
        """Crea la configuración de extensión para Cursor"""
        
        # Configuración para Cursor
        cursor_config = {
            "name": "Quantum Programmer Bot",
            "version": self.version,
            "description": "Bot programador con IA cuántica integrada para Cursor",
            "author": "Quantum Bot Team",
            "main": "cursor_quantum_bot_extension.py",
            "commands": {
                "quantum_hello": {
                    "description": "Crear Hello World cuántico",
                    "action": "create_quantum_hello"
                },
                "quantum_entangle": {
                    "description": "Crear circuito de entrelazamiento cuántico",
                    "action": "create_quantum_entangle"
                },
                "quantum_grover": {
                    "description": "Crear algoritmo de Grover",
                    "action": "create_quantum_grover"
                },
                "quantum_simulate": {
                    "description": "Simular circuito cuántico",
                    "action": "simulate_quantum_circuit"
                },
                "code_generate": {
                    "description": "Generar código en lenguaje específico",
                    "action": "generate_code"
                },
                "analyze_code": {
                    "description": "Analizar código y obtener métricas",
                    "action": "analyze_code"
                },
                "yara_panel": {
                    "description": "Abrir panel comercial HTML con verificación de localhost y YARA API",
                    "action": "open_yara_panel"
                },
                "yara_optimized": {
                    "description": "Sistema optimizado: inicia localhost, abre panel y verifica YARA API",
                    "action": "run_yara_optimized_system"
                },
                "create_file": {
                    "description": "Crear nuevo archivo",
                    "action": "create_file"
                },
                "list_files": {
                    "description": "Listar archivos del proyecto",
                    "action": "list_files"
                }
            }
        }
        
        # Guardar configuración
        with open("cursor_quantum_bot_config.json", "w") as f:
            json.dump(cursor_config, f, indent=2)
        
        return cursor_config
    
    def create_quantum_hello(self, **kwargs):
        """Crea un Hello World cuántico"""
        code = '''# Hello World Cuántico
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister, execute, Aer

# Crear un circuito cuántico
qr = QuantumRegister(1)
cr = ClassicalRegister(1)
circuit = QuantumCircuit(qr, cr)

# Aplicar una puerta Hadamard
circuit.h(qr[0])

# Medir el qubit
circuit.measure(qr[0], cr[0])

# Ejecutar el circuito
backend = Aer.get_backend('qasm_simulator')
job = execute(circuit, backend, shots=1000)
result = job.result()
counts = result.get_counts(circuit)

print("Resultados del Hello World Cuántico:")
print(counts)

# Visualizar el circuito
print("\\nCircuito cuántico:")
print(circuit.draw())
'''
        
        with open("hello_quantum.py", "w") as f:
            f.write(code)
        
        return {
            "success": True,
            "message": "✅ Hello World cuántico creado en hello_quantum.py",
            "file": "hello_quantum.py",
            "code": code
        }
    
    def create_quantum_entangle(self, **kwargs):
        """Crea un circuito de entrelazamiento cuántico"""
        code = '''# Entrelazamiento Cuántico
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister, execute, Aer

# Crear un circuito con 2 qubits
qr = QuantumRegister(2)
cr = ClassicalRegister(2)
circuit = QuantumCircuit(qr, cr)

# Crear estado de Bell (entrelazamiento)
circuit.h(qr[0])  # Aplicar Hadamard al primer qubit
circuit.cx(qr[0], qr[1])  # CNOT gate

# Medir ambos qubits
circuit.measure(qr[0], cr[0])
circuit.measure(qr[1], cr[1])

# Ejecutar el circuito
backend = Aer.get_backend('qasm_simulator')
job = execute(circuit, backend, shots=1000)
result = job.result()
counts = result.get_counts(circuit)

print("Resultados del Entrelazamiento Cuántico:")
print(counts)

# Visualizar el circuito
print("\\nCircuito cuántico:")
print(circuit.draw())
'''
        
        with open("entanglement.py", "w") as f:
            f.write(code)
        
        return {
            "success": True,
            "message": "✅ Circuito de entrelazamiento creado en entanglement.py",
            "file": "entanglement.py",
            "code": code
        }
    
    def create_quantum_grover(self, **kwargs):
        """Crea el algoritmo de Grover"""
        code = '''# Algoritmo de Grover
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister, execute, Aer
from qiskit.quantum_info import Statevector
import numpy as np

def grover_algorithm(n_qubits, target):
    """Implementa el algoritmo de Grover"""
    qr = QuantumRegister(n_qubits)
    cr = ClassicalRegister(n_qubits)
    circuit = QuantumCircuit(qr, cr)
    
    # Inicialización
    for i in range(n_qubits):
        circuit.h(qr[i])
    
    # Iteraciones de Grover
    iterations = int(np.pi/4 * np.sqrt(2**n_qubits))
    
    for _ in range(iterations):
        # Oracle (marca el estado objetivo)
        for i in range(n_qubits):
            if not (target >> i) & 1:
                circuit.x(qr[i])
        
        circuit.cz(qr[0], qr[1])
        
        for i in range(n_qubits):
            if not (target >> i) & 1:
                circuit.x(qr[i])
        
        # Difusión
        for i in range(n_qubits):
            circuit.h(qr[i])
            circuit.x(qr[i])
        
        circuit.cz(qr[0], qr[1])
        
        for i in range(n_qubits):
            circuit.x(qr[i])
            circuit.h(qr[i])
    
    # Medir
    circuit.measure(qr, cr)
    
    return circuit

# Ejemplo de uso
circuit = grover_algorithm(2, 3)  # Buscar estado |11>
backend = Aer.get_backend('qasm_simulator')
job = execute(circuit, backend, shots=1000)
result = job.result()
counts = result.get_counts(circuit)

print("Resultados del Algoritmo de Grover:")
print(counts)

# Visualizar el circuito
print("\\nCircuito cuántico:")
print(circuit.draw())
'''
        
        with open("grover.py", "w") as f:
            f.write(code)
        
        return {
            "success": True,
            "message": "✅ Algoritmo de Grover creado en grover.py",
            "file": "grover.py",
            "code": code
        }
    
    def simulate_quantum_circuit(self, filename="hello_quantum.py", **kwargs):
        """Simula un circuito cuántico"""
        try:
            if not os.path.exists(filename):
                return {
                    "success": False,
                    "message": f"❌ El archivo {filename} no existe"
                }
            
            result = subprocess.run([sys.executable, filename], 
                                  capture_output=True, text=True, cwd=os.getcwd())
            
            if result.returncode == 0:
                return {
                    "success": True,
                    "message": "✅ Simulación ejecutada exitosamente",
                    "output": result.stdout,
                    "file": filename
                }
            else:
                return {
                    "success": False,
                    "message": "❌ Error en la simulación",
                    "error": result.stderr
                }
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error al ejecutar simulación: {e}"
            }
    
    def generate_code(self, language="python", description="Código generado", **kwargs):
        """Genera código en el lenguaje especificado"""
        templates = {
            "python": f'''# Código Python generado por Quantum Programmer Bot
# Descripción: {description}

def main():
    """Función principal"""
    print("¡Hola desde Quantum Programmer Bot!")
    # Tu código aquí

if __name__ == "__main__":
    main()
''',
            "javascript": f'''// Código JavaScript generado por Quantum Programmer Bot
// Descripción: {description}

function main() {{
    console.log("¡Hola desde Quantum Programmer Bot!");
    // Tu código aquí
}}

main();
''',
            "java": f'''// Código Java generado por Quantum Programmer Bot
// Descripción: {description}

public class Main {{
    public static void main(String[] args) {{
        System.out.println("¡Hola desde Quantum Programmer Bot!");
        // Tu código aquí
    }}
}}
'''
        }
        
        code = templates.get(language.lower(), "Lenguaje no soportado")
        filename = f"generated_{language}.{language if language != 'python' else 'py'}"
        
        with open(filename, "w") as f:
            f.write(code)
        
        return {
            "success": True,
            "message": f"✅ Código {language} generado en {filename}",
            "file": filename,
            "code": code
        }
    
    def analyze_code(self, filename, **kwargs):
        """Analiza código y proporciona métricas"""
        try:
            if not os.path.exists(filename):
                return {
                    "success": False,
                    "message": f"❌ El archivo {filename} no existe"
                }
            
            with open(filename, 'r', encoding='utf-8') as f:
                content = f.read()
            
            lines = content.split('\n')
            total_lines = len(lines)
            non_empty_lines = len([line for line in lines if line.strip()])
            comment_lines = len([line for line in lines if line.strip().startswith('#') or line.strip().startswith('//')])
            
            analysis = {
                "success": True,
                "message": f"📊 Análisis de código: {filename}",
                "metrics": {
                    "total_lines": total_lines,
                    "code_lines": non_empty_lines,
                    "comment_lines": comment_lines,
                    "comment_ratio": comment_lines/max(non_empty_lines, 1)
                }
            }
            
            return analysis
            
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error en análisis: {e}"
            }
    
    def create_file(self, filename, content="", **kwargs):
        """Crea un nuevo archivo"""
        try:
            with open(filename, 'w', encoding='utf-8') as f:
                f.write(content)
            
            return {
                "success": True,
                "message": f"✅ Archivo '{filename}' creado exitosamente",
                "file": filename
            }
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error al crear archivo: {e}"
            }
    
    def list_files(self, **kwargs):
        """Lista archivos del proyecto"""
        try:
            files = []
            for root, dirs, filenames in os.walk(os.getcwd()):
                for filename in filenames:
                    if not filename.startswith('.') and not filename.endswith('.pyc'):
                        rel_path = os.path.relpath(os.path.join(root, filename), os.getcwd())
                        files.append(rel_path)
            
            return {
                "success": True,
                "message": "📁 Archivos del proyecto:",
                "files": sorted(files)
            }
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error al listar archivos: {e}"
            }
    
    def open_yara_panel(self, **kwargs):
        """Abre el panel comercial HTML con verificación de localhost y YARA API"""
        try:
            from yara_commercial_panel import YaraCommercialPanel
            
            panel = YaraCommercialPanel()
            result = panel.open_panel()
            
            if result['success']:
                # Verificar servicios
                services = panel.verify_services()
                
                return {
                    "success": True,
                    "message": f"✅ {result['message']}",
                    "file": result['file'],
                    "path": result['path'],
                    "services": services
                }
            else:
                return {
                    "success": False,
                    "message": result['message']
                }
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error abriendo panel YARA: {e}"
            }
    
    def run_yara_optimized_system(self, **kwargs):
        """Ejecuta el sistema YARA optimizado completo"""
        try:
            from yara_optimized_system import YaraOptimizedSystem
            
            system = YaraOptimizedSystem()
            
            # Iniciar localhost
            localhost_started = system.start_localhost_server()
            
            # Abrir panel
            panel_result = system.open_optimized_panel()
            
            # Verificar servicios
            services = system.verify_all_services()
            
            return {
                "success": True,
                "message": "✅ Sistema YARA optimizado iniciado exitosamente",
                "localhost_started": localhost_started,
                "panel": panel_result,
                "services": services
            }
        except Exception as e:
            return {
                "success": False,
                "message": f"❌ Error ejecutando sistema YARA optimizado: {e}"
            }
    
    def process_command(self, command, **kwargs):
        """Procesa comandos del chat"""
        if command in self.create_cursor_extension_config()["commands"]:
            action = self.create_cursor_extension_config()["commands"][command]["action"]
            method = getattr(self, action, None)
            if method:
                return method(**kwargs)
        
        return {
            "success": False,
            "message": f"❌ Comando no reconocido: {command}"
        }

# Instancia global del bot
quantum_bot = CursorQuantumBotExtension()

def main():
    """Función principal para usar desde Cursor"""
    if len(sys.argv) > 1:
        command = sys.argv[1]
        kwargs = {}
        
        # Procesar argumentos adicionales
        for i in range(2, len(sys.argv), 2):
            if i + 1 < len(sys.argv):
                kwargs[sys.argv[i].lstrip('-')] = sys.argv[i + 1]
        
        result = quantum_bot.process_command(command, **kwargs)
        print(json.dumps(result, indent=2))
    else:
        print("Quantum Programmer Bot Extension para Cursor")
        print("Comandos disponibles:")
        for cmd, info in quantum_bot.create_cursor_extension_config()["commands"].items():
            print(f"  {cmd}: {info['description']}")

if __name__ == "__main__":
    main()