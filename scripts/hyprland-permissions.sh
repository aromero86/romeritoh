#!/bin/bash

# =============================================================================
# Hyprland Permissions Configuration Script
# =============================================================================
# Script para configurar permisos en Hyprland
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
    echo -e "${GREEN}[PERMISSIONS] $1${NC}"
}

error() {
    echo -e "${RED}[PERMISSIONS ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[PERMISSIONS INFO] $1${NC}"
}

log "Iniciando configuración de permisos..."

# Crear configuración de permissions
log "Creando permissions.conf..."
mkdir -p ~/.config/hypr

cat > ~/.config/hypr/permissions.conf << 'EOF'
# Permissions Configuration - Romeritoh

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
EOF

log "✓ Configuración de permisos completada"