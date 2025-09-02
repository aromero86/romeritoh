#!/bin/bash

# =============================================================================
# Waybar Installation Script
# =============================================================================
# Script para instalar Waybar para Wayland en Arch Linux
# Parte del setup de Romeritoh
# =============================================================================

set -e

# Obtener directorio del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

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

# Instalar waybar y alsa-utils
log "Instalando waybar y alsa-utils..."
sudo pacman -S --needed --noconfirm waybar alsa-utils

# Crear directorio de configuración
log "Creando directorio de configuración..."
mkdir -p ~/.config/waybar

# Copiar archivos de configuración
log "Copiando configuración de waybar..."
cp "$PROJECT_ROOT/assets/waybar/config" ~/.config/waybar/
cp "$PROJECT_ROOT/assets/waybar/styles.css" ~/.config/waybar/

info "Configuración copiada desde assets/waybar/"

log "✓ Waybar instalado y configurado correctamente"