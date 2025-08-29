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

#### 1. Sistema Hyprland (Completamente Modularizado)
**Scripts principales**:
- `hyprland.sh`: Script maestro que orquesta todos los sub-módulos
- `hyprland-monitors.sh`: Configuración de monitores
- `hyprland-autostart.sh`: Aplicaciones de inicio automático  
- `hyprland-environment.sh`: Variables de entorno
- `hyprland-permissions.sh`: Permisos de seguridad
- `hyprland-lookAndFeel.sh`: Estética (gaps, bordes, animaciones, etc.)
- `hyprland-input.sh`: Dispositivos de entrada (teclado US + AltGr internacional)
- `hyprland-windows.sh`: Reglas de ventanas y workspaces
- `hyprland-keybindings.sh`: Atajos de teclado personalizados
- `hyprland-waybar.sh`: Sub-módulo para waybar
- `hyprland-wofi.sh`: Sub-módulo para wofi (launcher)

**Keybindings configurados**:
- `Super + Enter`: Terminal (kitty)
- `Super + Space`: Launcher (wofi)
- `Super + Q`: Cerrar ventana
- `Super + Flechas`: Cambiar foco
- `Super + Shift + Flechas`: Mover ventanas  
- `Super + Alt + Flechas`: Redimensionar ventanas (50px)
- `Super + 1-9`: Cambiar workspace
- `Super + Shift + 1-9`: Mover ventana a workspace

#### 2. `font.sh`
**Propósito**: Instalación de fuentes del sistema

**Estado actual**: ✅ Completo
- Cascadia Code Nerd Font (fuente principal)
- Font Awesome (iconos adicionales)
- Refresco de cache de fuentes

#### 3. `kitty.sh`
**Propósito**: Instalación y configuración de terminal

**Estado actual**: ✅ Completo
- Instalación de Kitty terminal
- Configuración completa con Cascadia Code Nerd Font
- Esquema de colores optimizado
- Configuración de rendimiento y comportamiento

#### 4. `hyprpaper.sh`
**Propósito**: Configuración de wallpaper

**Estado actual**: ✅ Completo
- Instalación de hyprpaper
- Copia de astronaut.jpg a ~/Pictures
- Configuración automática de wallpaper

#### 5. `git.sh`
**Propósito**: Instalación de Git

**Estado actual**: ✅ Completo
- Instalación de Git desde repositorios oficiales

#### 6. `nvm.sh`
**Propósito**: Instalación de Node Version Manager y Node.js

**Estado actual**: ✅ Completo
- Instalación de NVM v0.39.4
- Carga de NVM en sesión actual
- Instalación de la última versión de Node.js

#### 7. `chromium.sh`
**Propósito**: Instalación de navegador web

**Estado actual**: ✅ Completo
- Instalación de Chromium desde repositorios oficiales

#### 8. `vscode.sh`
**Propósito**: Instalación de Visual Studio Code

**Estado actual**: ✅ Completo
- Instalación de VSCode desde repositorios oficiales

#### 9. `greet.sh`
**Propósito**: Display Manager TUI aesthetic (greetd + tuigreet)

**Estado actual**: ✅ Completo
- Instalación de greetd (display manager ligero)
- Configuración de tuigreet (greeter TUI aesthetic)
- Desactivación automática de otros display managers
- Configuración para Hyprland con autenticación por password
- Activación automática en próximo reinicio

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

### Estructura de Archivos Completamente Modularizada
```
~/.config/hypr/
├── hyprland.conf           # Orquestador principal (solo imports)
├── monitors.conf           # Configuración de monitores
├── autostart.conf          # Aplicaciones de inicio
├── environment.conf        # Variables de entorno
├── permissions.conf        # Permisos de seguridad
├── look-and-feel.conf      # Estética y animaciones
├── input.conf              # Dispositivos de entrada
├── keybindings.conf        # Atajos de teclado
├── windows.conf            # Reglas de ventanas
└── hyprpaper.conf          # Configuración de wallpaper
```

### Sistema de Variables
- `$mainMod = SUPER`: Tecla modificadora principal
- `$terminal = kitty`: Terminal por defecto (reutilizable)

### Integración Modular
El archivo principal `hyprland.conf` actúa como orquestador:
```bash
#
#  ███████████                                                ███   █████             █████     
# ░░███░░░░░███                                              ░░░   ░░███             ░░███      
#  ░███    ░███   ██████  █████████████    ██████  ████████  ████  ███████    ██████  ░███████  
#  ░██████████   ███░░███░░███░░███░░███  ███░░███░░███░░███░░███ ░░░███░    ███░░███ ░███░░███ 
#  ░███░░░░░███ ░███ ░███ ░███ ░███ ░███ ░███████  ░███ ░░░  ░███   ░███    ░███ ░███ ░███ ░███ 
#  ░███    ░███ ░███ ░███ ░███ ░███ ░███ ░███░░░   ░███      ░███   ░███ ███░███ ░███ ░███ ░███ 
#  █████   █████░░██████  █████░███ █████░░██████  █████     █████  ░░█████ ░░██████  ████ █████
# ░░░░░   ░░░░░  ░░░░░░  ░░░░░ ░░░ ░░░░░  ░░░░░░  ░░░░░     ░░░░░    ░░░░░   ░░░░░░  ░░░░ ░░░░░ 
#                                                                                               

source = ~/.config/hypr/monitors.conf
source = ~/.config/hypr/autostart.conf
source = ~/.config/hypr/environment.conf
source = ~/.config/hypr/permissions.conf
source = ~/.config/hypr/look-and-feel.conf
source = ~/.config/hypr/input.conf
source = ~/.config/hypr/keybindings.conf
source = ~/.config/hypr/windows.conf
```

## Gestión de Versiones

Todas las versiones fijadas se documentan en `README.md` para facilitar el mantenimiento y actualizaciones futuras.

## Estado del Proyecto

### ✅ Completado
- **Script principal** con arquitectura completamente modular
- **Sistema Hyprland** completamente modularizado en 10 sub-módulos
- **Fuentes del sistema**: Cascadia Code Nerd Font + Font Awesome
- **Terminal Kitty** con configuración completa y fuente optimizada
- **Wallpaper system**: hyprpaper con astronaut.jpg automático
- **Keybindings completos**: foco, movimiento, redimensionado, workspaces
- **Aplicaciones core**: Git, NVM/Node.js, Chromium, VSCode
- **Input system**: Teclado US + AltGr internacional para acentos
- **Waybar y Wofi** integrados como sub-módulos

### 🎯 Sistema Completamente Funcional
- **14 scripts modulares** trabajando en perfecta armonía
- **Configuración cero-dependencias** - todo se instala automáticamente  
- **Separación total de responsabilidades** - cada módulo es independiente
- **Fácil mantenimiento** - cada aspecto en su propio archivo

### 📋 Posibles Mejoras Futuras
- Configuración de waybar personalizada (colores, widgets)
- Temas e iconos del sistema
- Display manager (SDDM)
- Scripts para audio avanzado

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
