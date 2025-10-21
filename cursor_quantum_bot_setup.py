#!/usr/bin/env python3
"""
Script de configuración para integrar Quantum Bot con Cursor Chat
"""

import json
import os
import sys
from pathlib import Path

def create_cursor_workspace_settings():
    """Crea configuración para el workspace de Cursor"""
    
    # Crear directorio .vscode si no existe
    vscode_dir = Path(".vscode")
    vscode_dir.mkdir(exist_ok=True)
    
    # Configuración de settings para Cursor
    settings = {
        "quantum-bot.enabled": True,
        "quantum-bot.auto-start": True,
        "quantum-bot.workspace": os.getcwd(),
        "quantum-bot.python-path": sys.executable,
        "quantum-bot.extension-path": os.path.join(os.getcwd(), "cursor_quantum_bot_extension.py"),
        "python.defaultInterpreterPath": sys.executable,
        "python.terminal.activateEnvironment": True
    }
    
    settings_file = vscode_dir / "settings.json"
    with open(settings_file, 'w') as f:
        json.dump(settings, f, indent=2)
    
    return settings_file

def create_cursor_tasks():
    """Crea tareas de Cursor para el Quantum Bot"""
    
    tasks = {
        "version": "2.0.0",
        "tasks": [
            {
                "label": "Quantum Bot: Hello World",
                "type": "shell",
                "command": f"{sys.executable}",
                "args": ["cursor_quantum_bot_extension.py", "quantum_hello"],
                "group": "build",
                "presentation": {
                    "echo": True,
                    "reveal": "always",
                    "focus": False,
                    "panel": "new"
                },
                "problemMatcher": []
            },
            {
                "label": "Quantum Bot: Entrelazamiento",
                "type": "shell",
                "command": f"{sys.executable}",
                "args": ["cursor_quantum_bot_extension.py", "quantum_entangle"],
                "group": "build",
                "presentation": {
                    "echo": True,
                    "reveal": "always",
                    "focus": False,
                    "panel": "new"
                },
                "problemMatcher": []
            },
            {
                "label": "Quantum Bot: Algoritmo de Grover",
                "type": "shell",
                "command": f"{sys.executable}",
                "args": ["cursor_quantum_bot_extension.py", "quantum_grover"],
                "group": "build",
                "presentation": {
                    "echo": True,
                    "reveal": "always",
                    "focus": False,
                    "panel": "new"
                },
                "problemMatcher": []
            },
            {
                "label": "Quantum Bot: Simular Circuito",
                "type": "shell",
                "command": f"{sys.executable}",
                "args": ["cursor_quantum_bot_extension.py", "quantum_simulate", "--filename", "hello_quantum.py"],
                "group": "build",
                "presentation": {
                    "echo": True,
                    "reveal": "always",
                    "focus": False,
                    "panel": "new"
                },
                "problemMatcher": []
            },
            {
                "label": "Quantum Bot: Generar Código Python",
                "type": "shell",
                "command": f"{sys.executable}",
                "args": ["cursor_quantum_bot_extension.py", "code_generate", "--language", "python", "--description", "Código generado"],
                "group": "build",
                "presentation": {
                    "echo": True,
                    "reveal": "always",
                    "focus": False,
                    "panel": "new"
                },
                "problemMatcher": []
            },
            {
                "label": "Quantum Bot: Listar Archivos",
                "type": "shell",
                "command": f"{sys.executable}",
                "args": ["cursor_quantum_bot_extension.py", "list_files"],
                "group": "build",
                "presentation": {
                    "echo": True,
                    "reveal": "always",
                    "focus": False,
                    "panel": "new"
                },
                "problemMatcher": []
            }
        ]
    }
    
    vscode_dir = Path(".vscode")
    vscode_dir.mkdir(exist_ok=True)
    
    tasks_file = vscode_dir / "tasks.json"
    with open(tasks_file, 'w') as f:
        json.dump(tasks, f, indent=2)
    
    return tasks_file

def create_cursor_snippets():
    """Crea snippets para Cursor"""
    
    snippets = {
        "Quantum Bot Commands": {
            "scope": "python,javascript,java",
            "prefix": "qbot",
            "body": [
                "# Quantum Bot Command",
                "python3 cursor_quantum_bot_extension.py ${1:command}",
                "",
                "# Comandos disponibles:",
                "# quantum_hello - Crear Hello World cuántico",
                "# quantum_entangle - Crear entrelazamiento cuántico", 
                "# quantum_grover - Crear algoritmo de Grover",
                "# quantum_simulate - Simular circuito cuántico",
                "# code_generate - Generar código",
                "# analyze_code - Analizar código",
                "# list_files - Listar archivos"
            ],
            "description": "Quantum Bot Command"
        },
        "Quantum Hello World": {
            "scope": "python",
            "prefix": "qhello",
            "body": [
                "# Hello World Cuántico",
                "from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister, execute, Aer",
                "",
                "# Crear un circuito cuántico",
                "qr = QuantumRegister(1)",
                "cr = ClassicalRegister(1)",
                "circuit = QuantumCircuit(qr, cr)",
                "",
                "# Aplicar una puerta Hadamard",
                "circuit.h(qr[0])",
                "",
                "# Medir el qubit",
                "circuit.measure(qr[0], cr[0])",
                "",
                "# Ejecutar el circuito",
                "backend = Aer.get_backend('qasm_simulator')",
                "job = execute(circuit, backend, shots=1000)",
                "result = job.result()",
                "counts = result.get_counts(circuit)",
                "",
                "print(\"Resultados del Hello World Cuántico:\")",
                "print(counts)"
            ],
            "description": "Hello World Cuántico con Qiskit"
        }
    }
    
    vscode_dir = Path(".vscode")
    vscode_dir.mkdir(exist_ok=True)
    
    snippets_file = vscode_dir / "quantum_bot.code-snippets"
    with open(snippets_file, 'w') as f:
        json.dump(snippets, f, indent=2)
    
    return snippets_file

def create_cursor_launch_config():
    """Crea configuración de debug para Cursor"""
    
    launch_config = {
        "version": "0.2.0",
        "configurations": [
            {
                "name": "Quantum Bot Extension",
                "type": "python",
                "request": "launch",
                "program": "cursor_quantum_bot_extension.py",
                "args": ["quantum_hello"],
                "console": "integratedTerminal",
                "cwd": "${workspaceFolder}",
                "env": {
                    "PYTHONPATH": "${workspaceFolder}"
                }
            },
            {
                "name": "Quantum Bot Terminal",
                "type": "python",
                "request": "launch",
                "program": "quantum_programmer_bot.py",
                "console": "integratedTerminal",
                "cwd": "${workspaceFolder}",
                "env": {
                    "PYTHONPATH": "${workspaceFolder}"
                }
            }
        ]
    }
    
    vscode_dir = Path(".vscode")
    vscode_dir.mkdir(exist_ok=True)
    
    launch_file = vscode_dir / "launch.json"
    with open(launch_file, 'w') as f:
        json.dump(launch_config, f, indent=2)
    
    return launch_file

def create_cursor_commands():
    """Crea comandos personalizados para Cursor"""
    
    commands = {
        "title": "Quantum Bot Commands",
        "commands": [
            {
                "command": "quantum-bot.hello",
                "title": "Quantum Bot: Hello World",
                "category": "Quantum Bot",
                "description": "Crear Hello World cuántico"
            },
            {
                "command": "quantum-bot.entangle", 
                "title": "Quantum Bot: Entrelazamiento",
                "category": "Quantum Bot",
                "description": "Crear circuito de entrelazamiento cuántico"
            },
            {
                "command": "quantum-bot.grover",
                "title": "Quantum Bot: Algoritmo de Grover", 
                "category": "Quantum Bot",
                "description": "Crear algoritmo de Grover"
            },
            {
                "command": "quantum-bot.simulate",
                "title": "Quantum Bot: Simular Circuito",
                "category": "Quantum Bot", 
                "description": "Simular circuito cuántico"
            },
            {
                "command": "quantum-bot.generate",
                "title": "Quantum Bot: Generar Código",
                "category": "Quantum Bot",
                "description": "Generar código en lenguaje específico"
            },
            {
                "command": "quantum-bot.analyze",
                "title": "Quantum Bot: Analizar Código",
                "category": "Quantum Bot",
                "description": "Analizar código y obtener métricas"
            }
        ]
    }
    
    vscode_dir = Path(".vscode")
    vscode_dir.mkdir(exist_ok=True)
    
    commands_file = vscode_dir / "commands.json"
    with open(commands_file, 'w') as f:
        json.dump(commands, f, indent=2)
    
    return commands_file

def main():
    """Función principal de configuración"""
    print("🚀 Configurando Quantum Bot para Cursor...")
    
    # Crear configuraciones
    settings_file = create_cursor_workspace_settings()
    tasks_file = create_cursor_tasks()
    snippets_file = create_cursor_snippets()
    launch_file = create_cursor_launch_config()
    commands_file = create_cursor_commands()
    
    print("✅ Configuración completada!")
    print(f"📁 Archivos creados:")
    print(f"  - {settings_file}")
    print(f"  - {tasks_file}")
    print(f"  - {snippets_file}")
    print(f"  - {launch_file}")
    print(f"  - {commands_file}")
    
    print("\n🎯 Cómo usar Quantum Bot en Cursor:")
    print("1. Reinicia Cursor para cargar la configuración")
    print("2. Usa Ctrl+Shift+P y busca 'Quantum Bot'")
    print("3. O usa los snippets: escribe 'qbot' o 'qhello'")
    print("4. O ejecuta las tareas desde Terminal > Run Task")
    
    print("\n💡 Comandos disponibles:")
    print("  - quantum_hello: Crear Hello World cuántico")
    print("  - quantum_entangle: Crear entrelazamiento cuántico")
    print("  - quantum_grover: Crear algoritmo de Grover")
    print("  - quantum_simulate: Simular circuito cuántico")
    print("  - code_generate: Generar código")
    print("  - analyze_code: Analizar código")

if __name__ == "__main__":
    main()