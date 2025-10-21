# 🤖 Quantum Programmer Bot para Cursor

Un bot programador avanzado que integra con Cursor y permite experimentar con IA cuántica directamente desde la terminal.

## ✨ Características

- 🤖 **Bot Programador Inteligente**: Comandos para crear, editar y gestionar archivos
- ⚛️ **IA Cuántica Integrada**: Simulaciones y algoritmos cuánticos con Qiskit
- 💻 **Integración con Cursor**: Comandos específicos para trabajar con Cursor
- 🔧 **Herramientas de Desarrollo**: Análisis de código, debugging, refactoring
- 📊 **Métricas y Análisis**: Análisis de complejidad y métricas de proyecto
- 🎯 **Multi-lenguaje**: Soporte para Python, JavaScript, Java y más

## 🚀 Instalación Rápida

### Opción 1: Instalación Automática
```bash
chmod +x install_bot.sh
./install_bot.sh
```

### Opción 2: Instalación Manual
```bash
# Instalar dependencias
pip3 install -r requirements.txt

# Hacer ejecutable
chmod +x quantum_programmer_bot.py

# Ejecutar
python3 quantum_programmer_bot.py
```

## 🎮 Uso

### Iniciar el Bot
```bash
python3 quantum_programmer_bot.py
# o usar el alias (después de la instalación)
quantum-bot
```

### Comandos Principales

#### 📁 Gestión de Archivos
```bash
create archivo.py          # Crear nuevo archivo
edit archivo.py            # Editar archivo existente
list                       # Listar archivos del proyecto
search "texto"             # Buscar texto en archivos
```

#### ⚛️ IA Cuántica
```bash
quantum hello              # Crear Hello World cuántico
quantum entangle           # Crear circuito de entrelazamiento
quantum grover             # Crear algoritmo de Grover
qsimulate archivo.py       # Ejecutar simulación cuántica
```

#### 💻 Programación
```bash
code python "descripción"  # Generar código Python
code javascript "desc"     # Generar código JavaScript
analyze archivo.py         # Analizar código
```

#### 🔧 Cursor Integration
```bash
cursor open                # Abrir Cursor en el workspace
cursor new_file            # Nueva ventana de Cursor
cursor settings            # Abrir configuración de Cursor
```

## 🧪 Ejemplos de IA Cuántica

### Hello World Cuántico
```python
# Generado con: quantum hello
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister, execute, Aer

qr = QuantumRegister(1)
cr = ClassicalRegister(1)
circuit = QuantumCircuit(qr, cr)

circuit.h(qr[0])  # Puerta Hadamard
circuit.measure(qr[0], cr[0])

backend = Aer.get_backend('qasm_simulator')
job = execute(circuit, backend, shots=1000)
result = job.result()
counts = result.get_counts(circuit)

print("Resultados:", counts)
```

### Entrelazamiento Cuántico
```python
# Generado con: quantum entangle
from qiskit import QuantumCircuit, QuantumRegister, ClassicalRegister, execute, Aer

qr = QuantumRegister(2)
cr = ClassicalRegister(2)
circuit = QuantumCircuit(qr, cr)

circuit.h(qr[0])      # Hadamard
circuit.cx(qr[0], qr[1])  # CNOT

circuit.measure(qr[0], cr[0])
circuit.measure(qr[1], cr[1])

# Ejecutar y mostrar resultados...
```

## ⚙️ Configuración

El bot crea un archivo `.quantum_bot_config.json` con las siguientes opciones:

```json
{
  "quantum_api_key": "",
  "cursor_integration": true,
  "auto_save": true,
  "debug_mode": false,
  "preferred_language": "python",
  "quantum_simulator": "qiskit"
}
```

### Comandos de Configuración
```bash
config show                 # Mostrar configuración actual
config reset               # Restablecer configuración
```

## 🔧 Dependencias

- **Qiskit**: Framework principal para computación cuántica
- **NumPy**: Cálculos numéricos
- **Matplotlib**: Visualización de datos
- **Requests**: Comunicación con APIs
- **aiofiles**: Operaciones de archivo asíncronas

## 🎯 Casos de Uso

1. **Desarrollo Rápido**: Crear y editar archivos desde la terminal
2. **Experimentación Cuántica**: Probar algoritmos cuánticos sin configuración compleja
3. **Análisis de Código**: Obtener métricas y análisis de proyectos
4. **Integración Cursor**: Trabajar directamente con Cursor desde la terminal
5. **Aprendizaje**: Experimentar con diferentes lenguajes y conceptos cuánticos

## 🚨 Solución de Problemas

### Error de Dependencias
```bash
pip3 install --upgrade pip
pip3 install -r requirements.txt
```

### Error de Permisos
```bash
chmod +x quantum_programmer_bot.py
chmod +x install_bot.sh
```

### Problemas con Qiskit
```bash
pip3 install --upgrade qiskit qiskit-aer
```

## 📝 Notas

- El bot funciona mejor en proyectos de Cursor
- Las simulaciones cuánticas requieren Qiskit instalado
- Los archivos se crean en el directorio actual de trabajo
- El bot mantiene un archivo de configuración local

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! El bot está diseñado para ser extensible y fácil de modificar.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo LICENSE para más detalles.

---

**¡Disfruta programando con IA cuántica! ⚛️🤖**