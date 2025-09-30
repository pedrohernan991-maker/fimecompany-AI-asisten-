# 🏢 FIME COMPANY - Portal Corporativo

## 📋 Descripción
Portal corporativo de FIME COMPANY con todas las divisiones y servicios especializados.

## 🏗️ Estructura del Proyecto

```
fimecompany-AI-asisten-/
├── public_html/              # Archivos para cPanel
│   ├── index.html           # Página principal
│   ├── ferreteria/          # División Ferretería
│   ├── fimetech/           # División FimeTech
│   ├── fimekids/           # División FimeKids
│   ├── industria/          # División Industria
│   └── styles.css          # Estilos unificados
├── .github/workflows/       # GitHub Actions
│   └── deploy.yml          # Despliegue automático
└── [otros archivos...]
```

## 🚀 Despliegue Automático

El repositorio está configurado con GitHub Actions para despliegue automático a cPanel:

- **Trigger**: Push a `main` o `master`
- **Método**: FTP Deploy Action
- **Destino**: `fimecompany.com/public_html/`

## 📱 Divisiones

### 🔧 Ferretería Industrial Metálica del Este
- **Teléfono**: 829-440-9136
- **Especialidad**: Materiales de construcción metálica
- **URL**: `/ferreteria/`

### 💻 FimeTech
- **Especialidad**: Tecnología de vanguardia
- **URL**: `/fimetech/`

### 👶 FimeKids
- **Especialidad**: Soluciones infantiles
- **URL**: `/fimekids/`

### 🏭 Industria
- **Especialidad**: Soluciones industriales
- **URL**: `/industria/`

## 👨‍💼 CEO
**Pedro Nicolás Hernández Lizardo**

## 💰 Monetización
- Google AdSense activo en todas las páginas
- ID: `ca-pub-7619200532568255`

## 🔧 Configuración

### Secrets de GitHub (requeridos):
- `CPANEL_PASSWORD`: Contraseña de cPanel

### Flujo de Trabajo:
1. Editar archivos en Cursor
2. Commit y Push a GitHub
3. GitHub Actions despliega automáticamente a cPanel

## 📞 Contacto
- **Email**: info@fimecompany.com
- **Ferretería**: 829-440-9136
- **Web**: https://fimecompany.com

---
© 2024 FIME COMPANY. Todos los derechos reservados.