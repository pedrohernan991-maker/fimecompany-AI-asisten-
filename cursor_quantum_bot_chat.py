#!/usr/bin/env python3
"""
Quantum Bot Chat Interface para Cursor
Interfaz de chat que simula la experiencia de chat de Cursor
"""

import json
import os
import sys
import subprocess
from datetime import datetime
from cursor_quantum_bot_extension import quantum_bot

class CursorQuantumBotChat:
    def __init__(self):
        self.bot_name = "Quantum Programmer Bot"
        self.version = "1.0.0"
        self.chat_history = []
        
    def print_chat_header(self):
        """Imprime el encabezado del chat"""
        print("=" * 80)
        print(f"🤖 {self.bot_name} v{self.version} - Chat Interface")
        print("=" * 80)
        print("💬 Escribe mensajes como si estuvieras en el chat de Cursor")
        print("⚛️  Comandos cuánticos disponibles: hello, entangle, grover, simulate")
        print("💻 Comandos de programación: generate, analyze, create, list")
        print("❓ Escribe 'help' para ver todos los comandos")
        print("🚪 Escribe 'exit' para salir")
        print("=" * 80)
        print()
    
    def process_user_message(self, message):
        """Procesa el mensaje del usuario"""
        message_lower = message.lower().strip()
        
        # Comandos de ayuda
        if message_lower in ['help', 'ayuda', 'comandos']:
            return self.show_help()
        
        # Comandos de salida
        if message_lower in ['exit', 'salir', 'quit', 'bye']:
            return {"type": "exit", "message": "👋 ¡Hasta luego! Quantum Bot se despide."}
        
        # Comandos cuánticos
        if any(word in message_lower for word in ['hello', 'hola', 'cuántico', 'quantum']):
            if 'hello' in message_lower or 'hola' in message_lower:
                return self.execute_quantum_command('quantum_hello')
        
        if any(word in message_lower for word in ['entangle', 'entrelazamiento', 'bell']):
            return self.execute_quantum_command('quantum_entangle')
        
        if any(word in message_lower for word in ['grover', 'búsqueda', 'search']):
            return self.execute_quantum_command('quantum_grover')
        
        if any(word in message_lower for word in ['simulate', 'simular', 'ejecutar', 'run']):
            return self.execute_quantum_command('quantum_simulate')
        
        # Comandos de programación
        if any(word in message_lower for word in ['generate', 'generar', 'código', 'code']):
            language = 'python'
            if 'javascript' in message_lower or 'js' in message_lower:
                language = 'javascript'
            elif 'java' in message_lower:
                language = 'java'
            return self.execute_programming_command('code_generate', language=language)
        
        if any(word in message_lower for word in ['analyze', 'analizar', 'métricas', 'metrics']):
            return self.execute_programming_command('analyze_code')
        
        if any(word in message_lower for word in ['create', 'crear', 'nuevo', 'new']):
            return self.execute_programming_command('create_file')
        
        if any(word in message_lower for word in ['list', 'listar', 'archivos', 'files']):
            return self.execute_programming_command('list_files')
        
        # Respuesta por defecto
        return {
            "type": "response",
            "message": f"🤖 No entiendo '{message}'. Escribe 'help' para ver comandos disponibles.",
            "suggestions": [
                "quantum hello - Crear Hello World cuántico",
                "quantum entangle - Crear entrelazamiento cuántico", 
                "generate python - Generar código Python",
                "analyze - Analizar código",
                "list - Listar archivos"
            ]
        }
    
    def execute_quantum_command(self, command):
        """Ejecuta un comando cuántico"""
        try:
            result = quantum_bot.process_command(command)
            
            if result.get('success'):
                return {
                    "type": "quantum",
                    "message": result['message'],
                    "file": result.get('file'),
                    "code": result.get('code', ''),
                    "output": result.get('output', '')
                }
            else:
                return {
                    "type": "error",
                    "message": result['message']
                }
        except Exception as e:
            return {
                "type": "error", 
                "message": f"❌ Error al ejecutar comando cuántico: {e}"
            }
    
    def execute_programming_command(self, command, **kwargs):
        """Ejecuta un comando de programación"""
        try:
            result = quantum_bot.process_command(command, **kwargs)
            
            if result.get('success'):
                return {
                    "type": "programming",
                    "message": result['message'],
                    "file": result.get('file'),
                    "code": result.get('code', ''),
                    "data": result.get('metrics', result.get('files', []))
                }
            else:
                return {
                    "type": "error",
                    "message": result['message']
                }
        except Exception as e:
            return {
                "type": "error",
                "message": f"❌ Error al ejecutar comando de programación: {e}"
            }
    
    def show_help(self):
        """Muestra la ayuda"""
        help_text = {
            "type": "help",
            "message": "🔧 Comandos disponibles:",
            "commands": {
                "⚛️ IA Cuántica": [
                    "quantum hello - Crear Hello World cuántico",
                    "quantum entangle - Crear entrelazamiento cuántico",
                    "quantum grover - Crear algoritmo de Grover",
                    "quantum simulate - Simular circuito cuántico"
                ],
                "💻 Programación": [
                    "generate python - Generar código Python",
                    "generate javascript - Generar código JavaScript", 
                    "generate java - Generar código Java",
                    "analyze - Analizar código y métricas",
                    "create - Crear nuevo archivo",
                    "list - Listar archivos del proyecto"
                ],
                "❓ Ayuda": [
                    "help - Mostrar esta ayuda",
                    "exit - Salir del chat"
                ]
            }
        }
        return help_text
    
    def format_response(self, response):
        """Formatea la respuesta para mostrar en el chat"""
        if response['type'] == 'exit':
            print(f"\n{response['message']}")
            return False
        
        elif response['type'] == 'help':
            print(f"\n🤖 {response['message']}")
            for category, commands in response['commands'].items():
                print(f"\n{category}")
                for cmd in commands:
                    print(f"  • {cmd}")
            print()
            return True
        
        elif response['type'] == 'quantum':
            print(f"\n⚛️ {response['message']}")
            if response.get('file'):
                print(f"📁 Archivo creado: {response['file']}")
            if response.get('output'):
                print(f"📊 Resultado:")
                print(response['output'])
            print()
            return True
        
        elif response['type'] == 'programming':
            print(f"\n💻 {response['message']}")
            if response.get('file'):
                print(f"📁 Archivo: {response['file']}")
            if response.get('data'):
                if isinstance(response['data'], dict):
                    print("📊 Métricas:")
                    for key, value in response['data'].items():
                        print(f"  {key}: {value}")
                elif isinstance(response['data'], list):
                    print("📁 Archivos:")
                    for file in response['data'][:10]:  # Mostrar solo los primeros 10
                        print(f"  📄 {file}")
            print()
            return True
        
        elif response['type'] == 'error':
            print(f"\n❌ {response['message']}")
            print()
            return True
        
        else:
            print(f"\n🤖 {response['message']}")
            if response.get('suggestions'):
                print("💡 Sugerencias:")
                for suggestion in response['suggestions']:
                    print(f"  • {suggestion}")
            print()
            return True
    
    def run_chat(self):
        """Ejecuta el chat interactivo"""
        self.print_chat_header()
        
        while True:
            try:
                # Mostrar prompt
                print("👤 Tú: ", end="", flush=True)
                user_input = input().strip()
                
                if not user_input:
                    continue
                
                # Procesar mensaje
                response = self.process_user_message(user_input)
                
                # Guardar en historial
                self.chat_history.append({
                    "timestamp": datetime.now().isoformat(),
                    "user": user_input,
                    "bot": response
                })
                
                # Mostrar respuesta
                continue_chat = self.format_response(response)
                
                if not continue_chat:
                    break
                    
            except KeyboardInterrupt:
                print("\n\n👋 ¡Hasta luego! Quantum Bot se despide.")
                break
            except EOFError:
                print("\n\n👋 ¡Hasta luego! Quantum Bot se despide.")
                break
            except Exception as e:
                print(f"\n❌ Error inesperado: {e}")
                print("💡 Intenta escribir 'help' para ver comandos disponibles")

def main():
    """Función principal"""
    chat = CursorQuantumBotChat()
    chat.run_chat()

if __name__ == "__main__":
    main()