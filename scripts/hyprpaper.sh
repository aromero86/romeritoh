#!/bin/bash

# =============================================================================
# Wallpaper Configuration Script
# =============================================================================
# Script para configurar fondo de pantalla en Hyprland en Arch Linux
# Parte del setup de Romeritoh
# =============================================================================

set -e

# Obtener directorio del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[WALLPAPER] $1${NC}"
}

error() {
    echo -e "${RED}[WALLPAPER ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[WALLPAPER INFO] $1${NC}"
}

log "Iniciando configuración de wallpaper..."

# Instalar hyprpaper para manejar wallpapers
log "Instalando hyprpaper..."
sudo pacman -S --needed --noconfirm hyprpaper

# Crear directorio Pictures si no existe
log "Creando directorio ~/Pictures..."
mkdir -p ~/Pictures

# Copiar imagen de astronaut desde assets
ASTRONAUT_SOURCE="$REPO_DIR/assets/astronaut.jpg"
ASTRONAUT_DEST="$HOME/Pictures/astronaut.jpg"

if [ -f "$ASTRONAUT_SOURCE" ]; then
    log "Copiando astronaut.jpg a ~/Pictures..."
    cp "$ASTRONAUT_SOURCE" "$ASTRONAUT_DEST"
    info "Imagen copiada a $ASTRONAUT_DEST"
else
    error "No se encontró la imagen en $ASTRONAUT_SOURCE"
    exit 1
fi

# Crear configuración de hyprpaper
log "Creando hyprpaper.conf..."
mkdir -p ~/.config/hypr

cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
# Wallpaper Configuration - Romeritoh

#################
### WALLPAPER ###
#################

# Preload wallpaper
preload = ~/Pictures/astronaut.jpg

# Set wallpaper for all monitors
wallpaper = ,~/Pictures/astronaut.jpg

# Enable splash screen
splash = true

# Disable IPC for better performance
ipc = off
EOF

log "✓ Configuración de hyprpaper completada"