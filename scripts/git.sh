#!/bin/bash

# =============================================================================
# Git Installation Script
# =============================================================================
# Script para instalar Git en Arch Linux
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
    echo -e "${GREEN}[GIT] $1${NC}"
}

error() {
    echo -e "${RED}[GIT ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[GIT INFO] $1${NC}"
}

log "Iniciando instalación de Git..."

# Instalar Git
log "Instalando Git..."
sudo pacman -S --needed --noconfirm git

log "✓ Git instalado correctamente"