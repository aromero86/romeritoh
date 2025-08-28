#!/bin/bash

# =============================================================================
# Hyprland Initialization Script
# =============================================================================
# Script para instalar y configurar Hyprland en Arch Linux
# Parte del setup de Romeritoh
# =============================================================================

set -e

# Obtener directorio del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[HYPRLAND] $1${NC}"
}

error() {
    echo -e "${RED}[HYPRLAND ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[HYPRLAND INFO] $1${NC}"
}

log "Iniciando configuración de Hyprland..."

# Actualizar el sistema
log "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# Instalar Hyprland
log "Instalando Hyprland..."
sudo pacman -S --needed --noconfirm hyprland

# Instalar terminal
log "Instalando Kitty..."
sudo pacman -S --needed --noconfirm kitty

# Instalar nano
log "Instalando nano..."
sudo pacman -S --needed --noconfirm nano

# Crear estructura modular de configuración
log "Configurando estructura modular..."
mkdir -p ~/.config/hypr

# Crear backup de hyprland.conf existente
if [ -f ~/.config/hypr/hyprland.conf ]; then
    log "Creando backup de hyprland.conf..."
    cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup
    info "Backup guardado en hyprland.conf.backup"
fi

# Crear hyprland.conf nuevo y limpio
log "Creando hyprland.conf nuevo..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
# Hyprland Configuration - Romeritoh

################
### MONITORS ###
################

# See https://wiki.hypr.land/Configuring/Monitors/
monitor=,preferred,auto,auto


#################
### AUTOSTART ###
#################

# Autostart necessary processes (like notifications daemons, status bars, etc.)
# Or execute your favorite apps at launch like this:

exec-once = waybar
exec-once = hyprpaper


#############################
### ENVIRONMENT VARIABLES ###
#############################

# See https://wiki.hypr.land/Configuring/Environment-variables/

env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24

###################
### PERMISSIONS ###
###################

# See https://wiki.hypr.land/Configuring/Permissions/
# Please note permission changes here require a Hyprland restart and are not applied on-the-fly
# for security reasons

# ecosystem {
#   enforce_permissions = 1
# }

# permission = /usr/(bin|local/bin)/grim, screencopy, allow
# permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
# permission = /usr/(bin|local/bin)/hyprpm, plugin, allow



#############
### INPUT ###
#############

# https://wiki.hypr.land/Configuring/Variables/#input
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

    touchpad {
        natural_scroll = false
    }
}

# https://wiki.hypr.land/Configuring/Variables/#gestures
gestures {
    workspace_swipe = false
}

# Example per-device config
# See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
device {
    name = epic-mouse-v1
    sensitivity = -0.5
}


#################################
### Romeritoh                 ###
#################################
source = ~/.config/hypr/look-and-feel.conf
source = ~/.config/hypr/keybindings.conf


##############################
### WINDOWS AND WORKSPACES ###
##############################

# See https://wiki.hypr.land/Configuring/Window-Rules/ for more
# See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

# Example windowrule
# windowrule = float,class:^(kitty)$,title:^(kitty)$

# Ignore maximize requests from apps. You'll probably like this.
windowrule = suppressevent maximize, class:.*

# Fix some dragging issues with XWayland
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
EOF

# Ejecutar script de waybar
log "Ejecutando instalación de waybar..."
bash "$SCRIPT_DIR/hyprland-waybar.sh"

# Ejecutar script de wofi
log "Ejecutando instalación de wofi..."
bash "$SCRIPT_DIR/hyprland-wofi.sh"

# Ejecutar script de look and feel
log "Ejecutando configuración de Look and Feel..."
bash "$SCRIPT_DIR/hyprland-lookAndFeel.sh"

# Ejecutar script de keybindings
log "Ejecutando configuración de keybindings..."
bash "$SCRIPT_DIR/hyprland-keybindings.sh"

log "✓ Script de Hyprland listo para construir paso a paso"
