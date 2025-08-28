#!/bin/bash

# =============================================================================
# VSCode Installation Script
# =============================================================================
# Script para instalar Visual Studio Code en Arch Linux
# Parte del sistema modular de Romeritoh
# =============================================================================

set -e

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

info "Instalando Visual Studio Code..."

# Instalar VSCode desde repositorios oficiales
sudo pacman -S --needed --noconfirm code

log "✓ Visual Studio Code instalado correctamente"