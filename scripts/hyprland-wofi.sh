#!/bin/bash

# =============================================================================
# Wofi Installation Script
# =============================================================================
# Script para instalar Wofi (application launcher) para Hyprland en Arch Linux
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
    echo -e "${GREEN}[WOFI] $1${NC}"
}

error() {
    echo -e "${RED}[WOFI ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[WOFI INFO] $1${NC}"
}

log "Iniciando instalación de Wofi..."

# Instalar wofi
log "Instalando wofi..."
sudo pacman -S --needed --noconfirm wofi

log "✓ Wofi instalado correctamente"