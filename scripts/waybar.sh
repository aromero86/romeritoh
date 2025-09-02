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

# Instalar waybar, alsa-utils, networkmanager, brightnessctl y playerctl
log "Instalando waybar, alsa-utils, networkmanager, brightnessctl y playerctl..."
sudo pacman -S --needed --noconfirm waybar alsa-utils networkmanager brightnessctl playerctl

# Agregar usuario al grupo video para control de brillo
log "Agregando usuario al grupo video para control de brillo..."
sudo usermod -a -G video $USER

# Crear directorio de configuración
log "Creando directorio de configuración..."
mkdir -p ~/.config/waybar

# Copiar archivos de configuración
log "Copiando configuración de waybar..."
cp "$PROJECT_ROOT/assets/waybar/config" ~/.config/waybar/
cp "$PROJECT_ROOT/assets/waybar/styles.css" ~/.config/waybar/

info "Configuración copiada desde assets/waybar/"

# Habilitar e iniciar NetworkManager
log "Habilitando e iniciando NetworkManager..."
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

log "✓ Waybar instalado y configurado correctamente"