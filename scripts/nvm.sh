#!/bin/bash

# =============================================================================
# NVM Installation Script
# =============================================================================
# Script para instalar NVM y Node.js en Arch Linux
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
    echo -e "${GREEN}[NVM] $1${NC}"
}

error() {
    echo -e "${RED}[NVM ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[NVM INFO] $1${NC}"
}

log "Iniciando instalación de NVM y Node.js..."

# Instalar Git
log "Instalando Git..."
sudo pacman -S --needed --noconfirm git

# Instalar NVM
log "Instalando NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

# Cargar NVM en la sesión actual
log "Cargando NVM..."
source ~/.bashrc

# Instalar la última versión de Node.js
log "Instalando la última versión de Node.js..."
nvm install node

log "✓ Script de NVM listo para construir paso a paso"
