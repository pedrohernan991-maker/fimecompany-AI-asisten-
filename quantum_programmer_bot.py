#!/usr/bin/env python3
"""
Quantum Programmer Bot para Cursor
Un bot programador que integra con Cursor y permite probar IA cuántica
"""

import os
import sys
import json
import subprocess
import argparse
from datetime import datetime
from typing import Dict, List, Optional, Any
import asyncio
import aiofiles
import requests
from pathlib import Path

class QuantumProgrammerBot:
    def __init__(self):
        self.name = "Quantum Programmer Bot"
        self.version = "1.0.0"
        self.cursor_workspace = os.getcwd()
        self.config_file = os.path.join(self.cursor_workspace, ".quantum_bot_config.json")
        self.load_config()
        
    def load_config(self):
        """Carga la configuración del bot"""
        default_config = {
            "quantum_api_key": "",
            "cursor_integration": True,
            "auto_save": True,
            "debug_mode": False,
            "preferred_language": "python",
            "quantum_simulator": "qiskit"
        }
        
        if os.path.exists(self.config_file):
            try:
                with open(self.config_file, 'r') as f:
                    self.config = json.load(f)
            except:
                self.config = default_config
        else:
            self.config = default_config
            self.save_config()
    
    def save_config(self):
        """Guarda la configuración del bot"""
        with open(self.config_file, 'w') as f:
            json.dump(self.config, f, indent=2)
    
    def print_banner(self):
        """Muestra el banner del bot"""
        banner = f"""
╔══════════════════════════════════════════════════════════════╗
║                    {self.name} v{self.version}                    ║
║                                                              ║
║  🤖 Bot Programador para Cursor                              ║
║  ⚛️  Integración con IA Cuántica                            ║
║  💻 Herramientas de Desarrollo Avanzadas                    ║
╚══════════════════════════════════════════════════════════════╝
        """
        print(banner)
    
    def print_help(self):
        """Muestra la ayuda del bot"""
        help_text = """
🔧 COMANDOS DISPONIBLES:

📁 GESTIÓN DE ARCHIVOS:
  create <archivo>     - Crear nuevo archivo
  edit <archivo>       - Editar archivo existente
  delete <archivo>     - Eliminar archivo
  list                 - Listar archivos del proyecto
  search <texto>       - Buscar texto en archivos

⚛️  IA CUÁNTICA:
  quantum <comando>    - Ejecutar comandos cuánticos
  qcircuit <archivo>   - Crear circuito cuántico
  qsimulate <archivo>  - Simular circuito cuántico
  qoptimize <archivo>  - Optimizar algoritmo cuántico

💻 PROGRAMACIÓN:
  code <lenguaje>      - Generar código en lenguaje específico
  debug <archivo>      - Depurar archivo
  test <archivo>       - Ejecutar tests
  refactor <archivo>   - Refactorizar código

🔧 CURSOR INTEGRATION:
  cursor <comando>     - Comandos específicos de Cursor
  workspace <accion>   - Gestionar workspace
  git <comando>        - Comandos Git integrados

📊 ANÁLISIS:
  analyze <archivo>    - Analizar código
  metrics <proyecto>   - Métricas del proyecto
  complexity <archivo> - Análisis de complejidad

⚙️  CONFIGURACIÓN:
  config <opción>      - Configurar bot
  install <paquete>    - Instalar dependencias
  update              - Actualizar bot

❓ AYUDA:
  help                - Mostrar esta ayuda
  exit                - Salir del bot
  clear               - Limpiar pantalla
        """
        print(help_text)
    
    def create_file(self, filename: str, content: str = ""):
        """Crea un nuevo archivo"""
        try:
            filepath = os.path.join(self.cursor_workspace, filename)
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ Archivo '{filename}' creado exitosamente")
            return True
        except Exception as e:
            print(f"❌ Error al crear archivo: {e}")
            return False
    
    def edit_file(self, filename: str, content: str):
        """Edita un archivo existente"""
        try:
            filepath = os.path.join(self.cursor_workspace, filename)
            if not os.path.exists(filepath):
                print(f"❌ El archivo '{filename}' no existe")
                return False
            
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"✅ Archivo '{filename}' editado exitosamente")
            return True
        except Exception as e:
            print(f"❌ Error al editar archivo: {e}")
            return False
    
    def read_file(self, filename: str) -> str:
        """Lee el contenido de un archivo"""
        try:
            filepath = os.path.join(self.cursor_workspace, filename)
            with open(filepath, 'r', encoding='utf-8') as f:
                return f.read()
        except Exception as e:
            print(f"❌ Error al leer archivo: {e}")
            return ""
    
    def list_files(self):
        """Lista archivos del proyecto"""
        try:
            files = []
            for root, dirs, filenames in os.walk(self.cursor_workspace):
                for filename in filenames:
                    if not filename.startswith('.'):
                        rel_path = os.path.relpath(os.path.join(root, filename), self.cursor_workspace)
                        files.append(rel_path)
            
            if files:
                print("📁 Archivos del proyecto:")
                for file in sorted(files):
                    print(f"  📄 {file}")
            else:
                print("📁 No se encontraron archivos en el proyecto")
        except Exception as e:
            print(f"❌ Error al listar archivos: {e}")
    
    def search_in_files(self, search_term: str):
        """Busca texto en archivos"""
        try:
            results = []
            for root, dirs, filenames in os.walk(self.cursor_workspace):
                for filename in filenames:
                    if not filename.startswith('.'):
                        filepath = os.path.join(root, filename)
                        try:
                            with open(filepath, 'r', encoding='utf-8') as f:
                                content = f.read()
                                if search_term.lower() in content.lower():
                                    lines = content.split('\n')
                                    for i, line in enumerate(lines):
                                        if search_term.lower() in line.lower():
                                            rel_path = os.path.relpath(filepath, self.cursor_workspace)
                                            results.append((rel_path, i+1, line.strip()))
                        except:
                            continue
            
            if results:
                print(f"🔍 Resultados para '{search_term}':")
                for filepath, line_num, line_content in results[:20]:  # Limitar a 20 resultados
                    print(f"  📄 {filepath}:{line_num} - {line_content}")
            else:
                print(f"🔍 No se encontraron resultados para '{search_term}'")
        except Exception as e:
            print(f"❌ Error en búsqueda: {e}")
    
    def generate_quantum_code(self, algorithm: str) -> str:
        """Genera código cuántico"""
        quantum_templates = {
            "hello_world": '''
# Hello World Cuántico
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
''',
            "entanglement": '''
# Entrelazamiento Cuántico
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
''',
            "grover": '''
# Algoritmo de Grover
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
'''
        }
        
        return quantum_templates.get(algorithm, "Algoritmo cuántico no encontrado")
    
    def create_quantum_circuit(self, filename: str, algorithm: str = "hello_world"):
        """Crea un circuito cuántico"""
        code = self.generate_quantum_code(algorithm)
        return self.create_file(filename, code)
    
    def run_quantum_simulation(self, filename: str):
        """Ejecuta una simulación cuántica"""
        try:
            print(f"⚛️  Ejecutando simulación cuántica: {filename}")
            result = subprocess.run([sys.executable, filename], 
                                  capture_output=True, text=True, cwd=self.cursor_workspace)
            
            if result.returncode == 0:
                print("✅ Simulación ejecutada exitosamente:")
                print(result.stdout)
            else:
                print("❌ Error en la simulación:")
                print(result.stderr)
        except Exception as e:
            print(f"❌ Error al ejecutar simulación: {e}")
    
    def generate_code(self, language: str, description: str) -> str:
        """Genera código en el lenguaje especificado"""
        templates = {
            "python": f'''
# Código Python generado por Quantum Programmer Bot
# Descripción: {description}

def main():
    """Función principal"""
    print("¡Hola desde Quantum Programmer Bot!")
    # Tu código aquí

if __name__ == "__main__":
    main()
''',
            "javascript": f'''
// Código JavaScript generado por Quantum Programmer Bot
// Descripción: {description}

function main() {{
    console.log("¡Hola desde Quantum Programmer Bot!");
    // Tu código aquí
}}

main();
''',
            "java": f'''
// Código Java generado por Quantum Programmer Bot
// Descripción: {description}

public class Main {{
    public static void main(String[] args) {{
        System.out.println("¡Hola desde Quantum Programmer Bot!");
        // Tu código aquí
    }}
}}
'''
        }
        
        return templates.get(language.lower(), "Lenguaje no soportado")
    
    def analyze_code(self, filename: str):
        """Analiza código y proporciona métricas"""
        try:
            content = self.read_file(filename)
            if not content:
                return
            
            lines = content.split('\n')
            total_lines = len(lines)
            non_empty_lines = len([line for line in lines if line.strip()])
            comment_lines = len([line for line in lines if line.strip().startswith('#') or line.strip().startswith('//')])
            
            print(f"📊 Análisis de código: {filename}")
            print(f"  📏 Líneas totales: {total_lines}")
            print(f"  📝 Líneas de código: {non_empty_lines}")
            print(f"  💬 Líneas de comentarios: {comment_lines}")
            print(f"  📈 Ratio comentarios/código: {comment_lines/max(non_empty_lines, 1):.2f}")
            
        except Exception as e:
            print(f"❌ Error en análisis: {e}")
    
    def run_cursor_command(self, command: str):
        """Ejecuta comandos específicos de Cursor"""
        cursor_commands = {
            "open": "cursor .",
            "new_file": "cursor --new-window",
            "settings": "cursor --settings",
            "extensions": "cursor --list-extensions"
        }
        
        if command in cursor_commands:
            try:
                subprocess.run(cursor_commands[command], shell=True, cwd=self.cursor_workspace)
                print(f"✅ Comando Cursor ejecutado: {command}")
            except Exception as e:
                print(f"❌ Error al ejecutar comando Cursor: {e}")
        else:
            print(f"❌ Comando Cursor no reconocido: {command}")
    
    def install_dependency(self, package: str):
        """Instala dependencias"""
        try:
            print(f"📦 Instalando {package}...")
            result = subprocess.run([sys.executable, "-m", "pip", "install", package], 
                                  capture_output=True, text=True)
            
            if result.returncode == 0:
                print(f"✅ {package} instalado exitosamente")
            else:
                print(f"❌ Error al instalar {package}: {result.stderr}")
        except Exception as e:
            print(f"❌ Error en instalación: {e}")
    
    def process_command(self, command: str):
        """Procesa comandos del usuario"""
        parts = command.strip().split()
        if not parts:
            return
        
        cmd = parts[0].lower()
        args = parts[1:] if len(parts) > 1 else []
        
        if cmd == "help":
            self.print_help()
        
        elif cmd == "exit":
            print("👋 ¡Hasta luego! Quantum Programmer Bot se despide.")
            sys.exit(0)
        
        elif cmd == "clear":
            os.system('clear' if os.name == 'posix' else 'cls')
        
        elif cmd == "create":
            if args:
                filename = args[0]
                content = input("💬 Ingresa el contenido del archivo (termina con Ctrl+D):\n")
                self.create_file(filename, content)
            else:
                print("❌ Especifica el nombre del archivo")
        
        elif cmd == "edit":
            if args:
                filename = args[0]
                content = self.read_file(filename)
                if content:
                    print(f"📝 Editando {filename}:")
                    print(content)
                    new_content = input("💬 Nuevo contenido (termina con Ctrl+D):\n")
                    self.edit_file(filename, new_content)
            else:
                print("❌ Especifica el nombre del archivo")
        
        elif cmd == "list":
            self.list_files()
        
        elif cmd == "search":
            if args:
                search_term = " ".join(args)
                self.search_in_files(search_term)
            else:
                print("❌ Especifica el término de búsqueda")
        
        elif cmd == "quantum":
            if args:
                subcmd = args[0].lower()
                if subcmd == "hello":
                    self.create_quantum_circuit("hello_quantum.py", "hello_world")
                elif subcmd == "entangle":
                    self.create_quantum_circuit("entanglement.py", "entanglement")
                elif subcmd == "grover":
                    self.create_quantum_circuit("grover.py", "grover")
                else:
                    print("❌ Comando cuántico no reconocido")
            else:
                print("⚛️  Comandos cuánticos disponibles: hello, entangle, grover")
        
        elif cmd == "qsimulate":
            if args:
                self.run_quantum_simulation(args[0])
            else:
                print("❌ Especifica el archivo a simular")
        
        elif cmd == "code":
            if args:
                language = args[0]
                description = " ".join(args[1:]) if len(args) > 1 else "Código generado"
                code = self.generate_code(language, description)
                filename = f"generated_{language}.{language if language != 'python' else 'py'}"
                self.create_file(filename, code)
            else:
                print("❌ Especifica el lenguaje de programación")
        
        elif cmd == "analyze":
            if args:
                self.analyze_code(args[0])
            else:
                print("❌ Especifica el archivo a analizar")
        
        elif cmd == "cursor":
            if args:
                self.run_cursor_command(args[0])
            else:
                print("🔧 Comandos Cursor disponibles: open, new_file, settings, extensions")
        
        elif cmd == "install":
            if args:
                self.install_dependency(args[0])
            else:
                print("❌ Especifica el paquete a instalar")
        
        elif cmd == "config":
            if args:
                option = args[0].lower()
                if option == "show":
                    print("⚙️  Configuración actual:")
                    for key, value in self.config.items():
                        print(f"  {key}: {value}")
                elif option == "reset":
                    self.config = {
                        "quantum_api_key": "",
                        "cursor_integration": True,
                        "auto_save": True,
                        "debug_mode": False,
                        "preferred_language": "python",
                        "quantum_simulator": "qiskit"
                    }
                    self.save_config()
                    print("✅ Configuración restablecida")
            else:
                print("⚙️  Opciones de configuración: show, reset")
        
        else:
            print(f"❌ Comando no reconocido: {cmd}")
            print("💡 Escribe 'help' para ver comandos disponibles")
    
    def run(self):
        """Ejecuta el bot en modo interactivo"""
        self.print_banner()
        print("🚀 Quantum Programmer Bot iniciado. Escribe 'help' para ver comandos disponibles.")
        print(f"📁 Workspace: {self.cursor_workspace}")
        print()
        
        while True:
            try:
                command = input("🤖 quantum-bot> ").strip()
                if command:
                    self.process_command(command)
                    print()  # Línea en blanco para separar comandos
            except KeyboardInterrupt:
                print("\n👋 ¡Hasta luego! Quantum Programmer Bot se despide.")
                break
            except EOFError:
                print("\n👋 ¡Hasta luego! Quantum Programmer Bot se despide.")
                break
            except Exception as e:
                print(f"❌ Error inesperado: {e}")

def main():
    """Función principal"""
    parser = argparse.ArgumentParser(description="Quantum Programmer Bot para Cursor")
    parser.add_argument("--version", action="version", version="1.0.0")
    parser.add_argument("--config", help="Archivo de configuración personalizado")
    
    args = parser.parse_args()
    
    bot = QuantumProgrammerBot()
    bot.run()

if __name__ == "__main__":
    main()