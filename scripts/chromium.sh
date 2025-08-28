#!/bin/bash

# =============================================================================
# Chromium Installation Script
# =============================================================================
# Script para instalar Chromium en Arch Linux
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
    echo -e "${GREEN}[CHROMIUM] $1${NC}"
}

error() {
    echo -e "${RED}[CHROMIUM ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[CHROMIUM INFO] $1${NC}"
}

log "Iniciando instalación de Chromium..."

# Instalar Chromium
log "Instalando Chromium..."
sudo pacman -S --needed --noconfirm chromium

log "✓ Chromium instalado correctamente"
