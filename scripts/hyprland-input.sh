#!/bin/bash

# =============================================================================
# Hyprland Input Configuration Script
# =============================================================================
# Script para configurar dispositivos de entrada en Hyprland
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
    echo -e "${GREEN}[INPUT] $1${NC}"
}

error() {
    echo -e "${RED}[INPUT ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[INPUT INFO] $1${NC}"
}

log "Iniciando configuración de dispositivos de entrada..."

# Crear configuración de input
log "Creando input.conf..."
mkdir -p ~/.config/hypr

cat > ~/.config/hypr/input.conf << 'EOF'
# Input Configuration - Romeritoh

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
EOF

log "✓ Configuración de dispositivos de entrada completada"