#!/bin/bash

# =============================================================================
# Hyprland Initialization Script
# =============================================================================
# Script para instalar y configurar Hyprland en Arch Linux
# Parte del setup de Romeritoh
# =============================================================================

set -e

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
cat >> ~/.config/hypr/hyprland.conf << 'EOF'

#################################
### Romeritoh                 ###
#################################
source = ~/.config/hypr/keybindings.conf
EOF

# Crear archivo de keybindings
log "Creando keybindings..."
cat > ~/.config/hypr/keybindings.conf << 'EOF'
# Romeritoh's Keybindings
$mainMod = SUPER
$terminal = kitty

# Terminal
bind = $mainMod, RETURN, exec, $terminal
EOF

log "✓ Script de Hyprland listo para construir paso a paso"
