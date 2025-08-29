#!/bin/bash

# =============================================================================
# Hyprland Initialization Script
# =============================================================================
# Script para instalar y configurar Hyprland en Arch Linux
# Parte del setup de Romeritoh
# =============================================================================

set -e

# Obtener directorio del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[HYPRLAND] $1${NC}"
}

error() {
    echo -e "${RED}[HYPRLAND ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[HYPRLAND INFO] $1${NC}"
}

log "Iniciando configuración de Hyprland..."

# Actualizar el sistema
log "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

# Instalar Hyprland
log "Instalando Hyprland..."
sudo pacman -S --needed --noconfirm hyprland

# Instalar nano
log "Instalando nano..."
sudo pacman -S --needed --noconfirm nano

# Crear estructura modular de configuración
log "Configurando estructura modular..."
mkdir -p ~/.config/hypr

# Crear backup de hyprland.conf existente
if [ -f ~/.config/hypr/hyprland.conf ]; then
    log "Creando backup de hyprland.conf..."
    cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup
    info "Backup guardado en hyprland.conf.backup"
fi

# Crear hyprland.conf nuevo y limpio
log "Creando hyprland.conf nuevo..."
cat > ~/.config/hypr/hyprland.conf << 'EOF'
#
#  ███████████                                                ███   █████             █████     
# ░░███░░░░░███                                              ░░░   ░░███             ░░███      
#  ░███    ░███   ██████  █████████████    ██████  ████████  ████  ███████    ██████  ░███████  
#  ░██████████   ███░░███░░███░░███░░███  ███░░███░░███░░███░░███ ░░░███░    ███░░███ ░███░░███ 
#  ░███░░░░░███ ░███ ░███ ░███ ░███ ░███ ░███████  ░███ ░░░  ░███   ░███    ░███ ░███ ░███ ░███ 
#  ░███    ░███ ░███ ░███ ░███ ░███ ░███ ░███░░░   ░███      ░███   ░███ ███░███ ░███ ░███ ░███ 
#  █████   █████░░██████  █████░███ █████░░██████  █████     █████  ░░█████ ░░██████  ████ █████
# ░░░░░   ░░░░░  ░░░░░░  ░░░░░ ░░░ ░░░░░  ░░░░░░  ░░░░░     ░░░░░    ░░░░░   ░░░░░░  ░░░░ ░░░░░ 
#                                                                                               

source = ~/.config/hypr/monitors.conf
source = ~/.config/hypr/autostart.conf
source = ~/.config/hypr/environment.conf
source = ~/.config/hypr/permissions.conf
source = ~/.config/hypr/look-and-feel.conf
source = ~/.config/hypr/input.conf
source = ~/.config/hypr/keybindings.conf
source = ~/.config/hypr/windows.conf
EOF

# Ejecutar script de waybar
log "Ejecutando instalación de waybar..."
bash "$SCRIPT_DIR/hyprland-waybar.sh"

# Ejecutar scripts de configuración modular
log "Ejecutando configuración de monitores..."
bash "$SCRIPT_DIR/hyprland-monitors.sh"

log "Ejecutando configuración de autostart..."
bash "$SCRIPT_DIR/hyprland-autostart.sh"

log "Ejecutando configuración de variables de entorno..."
bash "$SCRIPT_DIR/hyprland-environment.sh"

log "Ejecutando configuración de permisos..."
bash "$SCRIPT_DIR/hyprland-permissions.sh"

log "Ejecutando configuración de Look and Feel..."
bash "$SCRIPT_DIR/hyprland-lookAndFeel.sh"

log "Ejecutando configuración de dispositivos de entrada..."
bash "$SCRIPT_DIR/hyprland-input.sh"

log "Ejecutando configuración de ventanas y workspaces..."
bash "$SCRIPT_DIR/hyprland-windows.sh"

# Ejecutar script de keybindings
log "Ejecutando configuración de keybindings..."
bash "$SCRIPT_DIR/hyprland-keybindings.sh"

log "✓ Script de Hyprland listo para construir paso a paso"
