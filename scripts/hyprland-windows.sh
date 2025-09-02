#!/bin/bash

# =============================================================================
# Hyprland Windows and Workspaces Configuration Script
# =============================================================================
# Script para configurar reglas de ventanas y workspaces en Hyprland
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
    echo -e "${GREEN}[WINDOWS] $1${NC}"
}

error() {
    echo -e "${RED}[WINDOWS ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[WINDOWS INFO] $1${NC}"
}

log "Iniciando configuración de ventanas y workspaces..."

# Crear configuración de windows and workspaces
log "Creando windows.conf..."
mkdir -p ~/.config/hypr

cat > ~/.config/hypr/windows.conf << 'EOF'
# Windows and Workspaces Configuration - Romeritoh

##############################
### WINDOWS AND WORKSPACES ###
##############################

# See https://wiki.hypr.land/Configuring/Window-Rules/ for more
# See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

# Floating window for alsamixer in kitty
windowrule = float,class:^(kitty)$,title:^(alsamixer)$
windowrule = size 800 600,class:^(kitty)$,title:^(alsamixer)$
windowrule = center,class:^(kitty)$,title:^(alsamixer)$

# Ignore maximize requests from apps. You'll probably like this.
windowrule = suppressevent maximize, class:.*

# Fix some dragging issues with XWayland
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
EOF

log "✓ Configuración de ventanas y workspaces completada"