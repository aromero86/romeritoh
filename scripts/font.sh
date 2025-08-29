#!/bin/bash

# =============================================================================
# Font Installation Script
# =============================================================================
# Script para instalar fuentes necesarias en Arch Linux
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
    echo -e "${GREEN}[FONT] $1${NC}"
}

error() {
    echo -e "${RED}[FONT ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[FONT INFO] $1${NC}"
}

log "Iniciando instalación de fuentes..."

# Instalar Cascadia Code Nerd Font
log "Instalando Cascadia Code Nerd Font..."
sudo pacman -S --needed --noconfirm ttf-cascadia-code-nerd

# Instalar Font Awesome (para iconos adicionales)
log "Instalando Font Awesome..."
sudo pacman -S --needed --noconfirm ttf-font-awesome

# Refrescar cache de fuentes
log "Refrescando cache de fuentes..."
fc-cache -fv

log "✓ Fuentes instaladas correctamente"
info "Cascadia Code Nerd Font disponible como 'CaskaydiaCove Nerd Font'"
info "Reinicia las aplicaciones para ver los cambios"