#!/bin/bash

# =============================================================================
# Hyprland Autostart Configuration Script
# =============================================================================
# Script para configurar aplicaciones de inicio automático en Hyprland
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
    echo -e "${GREEN}[AUTOSTART] $1${NC}"
}

error() {
    echo -e "${RED}[AUTOSTART ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[AUTOSTART INFO] $1${NC}"
}

log "Iniciando configuración de autostart..."

# Crear configuración de autostart
log "Creando autostart.conf..."
mkdir -p ~/.config/hypr

cat > ~/.config/hypr/autostart.conf << 'EOF'
# Autostart Configuration - Romeritoh

#################
### AUTOSTART ###
#################

# Autostart necessary processes (like notifications daemons, status bars, etc.)
# Or execute your favorite apps at launch like this:

exec-once = waybar
exec-once = hyprpaper
EOF

log "✓ Configuración de autostart completada"