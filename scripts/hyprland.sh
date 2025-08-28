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

# Instalar waybar
log "Instalando waybar..."
sudo pacman -S --needed --noconfirm waybar

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

# Monitor
monitor=,preferred,auto,auto

# Variables de entorno
env = XCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt5ct

# Input
input {
    kb_layout = us
    follow_mouse = 1
    touchpad {
        natural_scroll = no
    }
    sensitivity = 0
}

# General
general {
    gaps_in = 5
    gaps_out = 20
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}

# Decoration
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
    }
    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animations
animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layout
dwindle {
    pseudotile = yes
    preserve_split = yes
}

# Window rules
windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

#################################
### Romeritoh                 ###
#################################
source = ~/.config/hypr/keybindings.conf
EOF

# Ejecutar script de keybindings
log "Ejecutando configuración de keybindings..."
bash "$SCRIPT_DIR/hyprland-keybindings.sh"

log "✓ Script de Hyprland listo para construir paso a paso"
