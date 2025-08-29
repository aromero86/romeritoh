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

log "Iniciando instalación y configuración de Wofi..."

# Instalar wofi
log "Instalando wofi..."
sudo pacman -S --needed --noconfirm wofi

# Obtener directorio del script para acceder a assets
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/assets"

# Crear directorio de configuración y copiar archivos
log "Configurando wofi..."
mkdir -p ~/.config/wofi
cp "$ASSETS_DIR/wofi/config" ~/.config/wofi/
cp "$ASSETS_DIR/wofi/style.css" ~/.config/wofi/

log "✓ Wofi instalado y configurado correctamente"
info "Configuración copiada desde assets/wofi/ (config + style.css)"