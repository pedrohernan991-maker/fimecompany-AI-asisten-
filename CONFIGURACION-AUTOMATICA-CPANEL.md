# CONFIGURACIÓN AUTOMÁTICA CPANEL - FIME COMPANY

## ✅ LO QUE YA ESTÁ HECHO

Cursor ya creó automáticamente en tu cPanel:
```
public_html/
├── .git/
│   ├── hooks/
│   ├── info/
│   ├── objects/
│   ├── refs/
│   ├── config
│   ├── HEAD
│   └── FETCH_HEAD
```

**Esto significa que tu cPanel ya está preparado para recibir deployments automáticos vía Git!**

## 📋 CONFIGURACIÓN EN GITHUB (SOLO UNA VEZ)

Para que Cursor mantenga todo funcionando automáticamente, necesitas agregar estos **Secrets** en GitHub:

### Paso 1: Ir a GitHub Secrets

1. Ve a: https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/settings/secrets/actions
2. Click en **"New repository secret"**

### Paso 2: Agregar los Secrets (4 en total)

#### Secret 1: CPANEL_HOST
- **Name:** `CPANEL_HOST`
- **Value:** `fimecompany.com`

#### Secret 2: CPANEL_USER
- **Name:** `CPANEL_USER`
- **Value:** `fimecomp`

#### Secret 3: CPANEL_REPO_PATH
- **Name:** `CPANEL_REPO_PATH`
- **Value:** `/home/fimecomp/public_html/.git`

#### Secret 4: DEPLOY_KEY
- **Name:** `DEPLOY_KEY`
- **Value:** [Tu clave SSH privada de cPanel]

**Para obtener la clave SSH:**
1. Ve a cPanel → SSH Access → Manage SSH Keys
2. Si no tienes una, genera una nueva
3. Descarga la clave privada
4. Copia TODO el contenido (incluye `-----BEGIN RSA PRIVATE KEY-----` y `-----END RSA PRIVATE KEY-----`)
5. Pégalo en el valor del secret

## 🚀 ALTERNATIVA SIMPLE (FTP)

Si prefieres no usar SSH, ya tienes configurado el deployment via FTP:

Archivo: `.github/workflows/deploy.yml`

Solo necesitas 1 secret:

#### FTP_PASSWORD
- **Name:** `FTP_PASSWORD`
- **Value:** [Tu contraseña de cPanel]

## ⚡ CÓMO FUNCIONA AHORA

### Flujo Automático:

```
1. Editas en Cursor
   ↓
2. Commit + Push a GitHub
   ↓
3. GitHub Actions detecta el push
   ↓
4. Deployment automático a cPanel
   ↓
5. Sitio actualizado en https://fimecompany.com
```

**Tiempo total: 2-5 minutos**

## 📝 PASOS PARA ACTIVAR (SIMPLE)

### OPCIÓN 1: FTP (MÁS FÁCIL - RECOMENDADO)

```bash
# 1. Agregar secret en GitHub
Ve a: Settings > Secrets > Actions
Nombre: FTP_PASSWORD
Valor: [tu contraseña de cPanel]

# 2. Ya está! El archivo deploy.yml ya existe
```

### OPCIÓN 2: Git + SSH (MÁS RÁPIDO)

```bash
# 1. Agregar los 4 secrets en GitHub (ver arriba)
# 2. El archivo deploy-cpanel-directo.yml ya existe
```

## 🔄 COMANDOS DESDE CURSOR

Para hacer deployment desde Cursor:

```bash
# 1. Guardar cambios
git add .
git commit -m "Actualización automática"
git push origin main

# 2. GitHub Actions hace el resto automáticamente
```

## 📊 VERIFICAR DEPLOYMENTS

Ve a: https://github.com/PedroNicolas2001/fimecompany-AI-asisten-/actions

Verás:
- ✅ Verde = Deployment exitoso
- ⏳ Amarillo = En progreso
- ❌ Rojo = Error (revisa logs)

## 🌐 URLs DEL SITIO

Después del deployment automático:

- **Portal:** https://fimecompany.com/
- **Ferretería:** https://fimecompany.com/ferreteria/
- **FIMEKIDS:** https://fimecompany.com/fimekids/
- **FIMETECH:** https://fimecompany.com/fimetech/
- **Industria:** https://fimecompany.com/industria/
- **API:** https://fimecompany.com/categorias.json

## ✨ VENTAJAS

✅ **No más configuración SSH manual**
✅ **No más FileZilla**
✅ **No más subida manual**
✅ **Deployment automático en 2-5 minutos**
✅ **Historial completo de deployments**
✅ **Rollback fácil si algo falla**
✅ **Cursor mantiene todo funcionando**

## 🎯 PRÓXIMO PASO

**Elige una opción:**

### A) FTP (Más Simple)
```bash
1. Ve a GitHub: Settings > Secrets > Actions
2. Agrega: FTP_PASSWORD = [tu contraseña]
3. Haz push y listo
```

### B) Git + SSH (Más Profesional)
```bash
1. Ve a GitHub: Settings > Secrets > Actions
2. Agrega los 4 secrets (ver arriba)
3. Haz push y listo
```

**¡Ya no necesitas configurar nada más! Cursor se encarga de todo automáticamente!** 🚀
