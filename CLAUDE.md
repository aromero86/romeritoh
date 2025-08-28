# Claude - Documentación del Proyecto

## Intención del Proyecto

Este proyecto busca crear un sistema de scripts modulares para configurar Arch Linux de manera automatizada, específicamente orientado a crear la "distro personalizada" de Romeritoh. El objetivo es tener un conjunto de scripts que permitan instalar y configurar un sistema Arch Linux desde cero con Hyprland como compositor de ventanas.

## Arquitectura del Sistema

### Script Principal
- **`setup.sh`**: Script maestro que orquesta la ejecución de todos los módulos
  - Maneja logging con colores
  - Verifica que se ejecuta en Arch Linux
  - Ejecuta scripts modulares en secuencia
  - Manejo de errores (se detiene si algo falla)

### Scripts Modulares (Carpeta `scripts/`)

#### 1. `init-hyprland.sh`
**Propósito**: Configuración básica de Hyprland y entorno de ventanas Wayland

**Estado actual**: ✅ Funcional básico
- Actualización del sistema (`pacman -Syu`)
- Instalación de Hyprland
- Instalación de Kitty (terminal)
- Instalación de nano (editor)
- Instalación de waybar (barra de estado)
- Creación de estructura modular de configuración
- Archivo de keybindings personalizado con variable `$terminal`

**Keybindings configurados**:
- `Super + Enter`: Abrir terminal (kitty)

#### 2. `nvm.sh`
**Propósito**: Instalación de Node Version Manager y Node.js

**Estado actual**: ✅ Completo
- Instalación de NVM v0.39.4
- Carga de NVM en sesión actual
- Instalación de la última versión de Node.js

#### 3. `chromium.sh`
**Propósito**: Instalación de navegador web

**Estado actual**: ✅ Completo
- Instalación de Chromium desde repositorios oficiales

## Metodología de Trabajo

### Filosofía de Desarrollo
1. **Construcción paso a paso**: Cada comando se valida antes de agregarlo al script
2. **Modularidad**: Cada funcionalidad en un script separado
3. **Confirmación explícita**: Claude propone comandos, el usuario confirma antes de agregar
4. **Testing incremental**: Se puede probar cada parte por separado

### Proceso de Trabajo
1. Claude propone un comando específico
2. Usuario confirma
3. Claude agrega al script correspondiente
4. Se continúa con el siguiente paso

## Configuración Modular de Hyprland

### Estructura de Archivos
```
~/.config/hypr/
├── hyprland.conf           # Configuración principal
└── keybindings.conf        # Keybindings personalizados (Romeritoh)
```

### Sistema de Variables
- `$mainMod = SUPER`: Tecla modificadora principal
- `$terminal = kitty`: Terminal por defecto (reutilizable)

### Integración
El archivo principal `hyprland.conf` incluye la sección personalizada:
```bash
#################################
### Romeritoh                 ###
#################################
source = ~/.config/hypr/keybindings.conf
```

## Gestión de Versiones

Todas las versiones fijadas se documentan en `README.md` para facilitar el mantenimiento y actualizaciones futuras.

## Estado del Proyecto

### ✅ Completado
- Script principal con arquitectura modular
- Hyprland básico funcional
- Terminal (kitty) con keybinding
- NVM y Node.js
- Chromium
- Sistema de configuración modular para Hyprland

### 🚧 En Progreso
- Configuración completa de waybar (funcional pero necesita personalización)

### 📋 Pendiente
- Ver lista de tareas en README.md

## Notas Técnicas

### Colores de Logging
- 🟢 Verde: Operaciones exitosas
- 🔴 Rojo: Errores
- 🔵 Azul: Información
- 🟡 Amarillo: Advertencias

### Consideraciones de Seguridad
- Uso de `set -e` para detener ejecución en errores
- Verificación de sistema Arch Linux
- Uso de `--needed` en pacman para evitar reinstalaciones innecesarias

### Flujo de Testing
El usuario puede probar cada componente individualmente ejecutando Hyprland después de cada modificación para validar cambios incrementalmente.
