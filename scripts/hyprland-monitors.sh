#!/bin/bash

# =============================================================================
# Hyprland Monitors Configuration Script
# =============================================================================
# Script para configurar monitores en Hyprland
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
    echo -e "${GREEN}[MONITORS] $1${NC}"
}

error() {
    echo -e "${RED}[MONITORS ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[MONITORS INFO] $1${NC}"
}

log "Iniciando configuración de monitores..."

# Crear configuración de monitors
log "Creando monitors.conf..."
mkdir -p ~/.config/hypr

cat > ~/.config/hypr/monitors.conf << 'EOF'
# Monitors Configuration - Romeritoh

################
### MONITORS ###
################

# See https://wiki.hypr.land/Configuring/Monitors/
monitor=,preferred,auto,auto
EOF

log "✓ Configuración de monitores completada"