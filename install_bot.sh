#!/bin/bash

# Script de instalación para Quantum Programmer Bot
echo "🚀 Instalando Quantum Programmer Bot para Cursor..."

# Verificar si Python está instalado
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 no está instalado. Por favor instala Python3 primero."
    exit 1
fi

# Verificar si pip está instalado
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 no está instalado. Por favor instala pip3 primero."
    exit 1
fi

# Instalar dependencias
echo "📦 Instalando dependencias..."
pip3 install -r requirements.txt

# Hacer el script ejecutable
chmod +x quantum_programmer_bot.py

# Crear alias para fácil acceso
echo "🔗 Creando alias para fácil acceso..."
echo 'alias quantum-bot="python3 $(pwd)/quantum_programmer_bot.py"' >> ~/.bashrc
echo 'alias qbot="python3 $(pwd)/quantum_programmer_bot.py"' >> ~/.bashrc

# Crear script de inicio rápido
cat > start_quantum_bot.sh << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
python3 quantum_programmer_bot.py
EOF

chmod +x start_quantum_bot.sh

echo "✅ Instalación completada!"
echo ""
echo "🎉 Para usar el bot:"
echo "  1. Ejecuta: python3 quantum_programmer_bot.py"
echo "  2. O usa el alias: quantum-bot"
echo "  3. O ejecuta: ./start_quantum_bot.sh"
echo ""
echo "💡 Reinicia tu terminal o ejecuta 'source ~/.bashrc' para usar los alias"