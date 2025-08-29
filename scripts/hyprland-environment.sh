#!/bin/bash

# =============================================================================
# Hyprland Environment Variables Configuration Script
# =============================================================================
# Script para configurar variables de entorno en Hyprland
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
    echo -e "${GREEN}[ENVIRONMENT] $1${NC}"
}

error() {
    echo -e "${RED}[ENVIRONMENT ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[ENVIRONMENT INFO] $1${NC}"
}

log "Iniciando configuración de variables de entorno..."

# Crear configuración de environment variables
log "Creando environment.conf..."
mkdir -p ~/.config/hypr

cat > ~/.config/hypr/environment.conf << 'EOF'
# Environment Variables Configuration - Romeritoh

#############################
### ENVIRONMENT VARIABLES ###
#############################

# See https://wiki.hypr.land/Configuring/Environment-variables/

env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24
EOF

log "✓ Configuración de variables de entorno completada"