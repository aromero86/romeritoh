#!/bin/bash

# =============================================================================
# Waybar Installation Script
# =============================================================================
# Script para instalar Waybar para Wayland en Arch Linux
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
    echo -e "${GREEN}[WAYBAR] $1${NC}"
}

error() {
    echo -e "${RED}[WAYBAR ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[WAYBAR INFO] $1${NC}"
}

log "Iniciando instalación de Waybar..."

# Instalar waybar
log "Instalando waybar..."
sudo pacman -S --needed --noconfirm waybar

log "✓ Waybar instalado correctamente"