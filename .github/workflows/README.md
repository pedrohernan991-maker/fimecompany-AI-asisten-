# GitHub Actions - Deployment Automático

Este archivo configura el deployment automático de FIME COMPANY a cPanel.

## ¿Qué hace?

Cada vez que hagas `git push` a la rama `main`, automáticamente:
1. Toma todos los archivos de `public_html/`
2. Los sube a tu servidor cPanel vía FTP
3. Actualiza el sitio web automáticamente

## Configuración necesaria

### Paso 1: Agregar el Secret en GitHub

1. Ve a tu repositorio en GitHub
2. Click en **Settings** (Configuración)
3. En el menú izquierdo, click en **Secrets and variables** → **Actions**
4. Click en **New repository secret**
5. Crea el secret:
   - **Name:** `FTP_PASSWORD`
   - **Value:** Tu contraseña de cPanel
6. Click en **Add secret**

### Paso 2: Hacer push de estos archivos

```bash
git add .
git commit -m "Configurar deployment automático a cPanel"
git push origin main
```

### Paso 3: Verificar que funciona

1. Ve a tu repositorio en GitHub
2. Click en la pestaña **Actions**
3. Verás el workflow corriendo
4. Espera a que termine (círculo verde ✓)
5. Tu sitio estará actualizado en: https://fimecompany.com

## Información de conexión

- **Servidor FTP:** ftp.fimecompany.com
- **Usuario:** fimecomp
- **Contraseña:** (configurada en Secrets)
- **Carpeta local:** ./public_html/
- **Carpeta servidor:** ./public_html/

## Ventajas

✅ Deployment automático
✅ No necesitas FileZilla
✅ Actualización instantánea al hacer push
✅ Historial de deployments
✅ Notificaciones de errores

## Ejecutar manualmente

También puedes ejecutar el deployment manualmente:
1. Ve a **Actions** en GitHub
2. Click en **Deploy to cPanel via FTP**
3. Click en **Run workflow**
4. Selecciona la rama `main`
5. Click en **Run workflow**

¡Listo! 🚀
