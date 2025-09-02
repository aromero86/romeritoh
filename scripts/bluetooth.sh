#!/bin/bash

# =============================================================================
# Bluetooth Installation Script
# =============================================================================
# Script para instalar y configurar Bluetooth completo en Arch Linux
# Incluye bluetuith (TUI), waybar widget y servicios necesarios
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
    echo -e "${GREEN}[BLUETOOTH] $1${NC}"
}

error() {
    echo -e "${RED}[BLUETOOTH ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[BLUETOOTH INFO] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[BLUETOOTH WARN] $1${NC}"
}

log "Iniciando instalación completa de Bluetooth..."

# Instalar paquetes de Bluetooth
log "Instalando paquetes de Bluetooth..."
sudo pacman -S --needed --noconfirm bluez bluez-utils bluez-tools

# Instalar bluetuith (TUI para Bluetooth) desde AUR
log "Instalando bluetuith (interfaz TUI para Bluetooth)..."
sudo -u "$REAL_USER" yay -S --noconfirm --removemake --cleanafter bluetuith

# Instalar paquetes adicionales útiles
log "Instalando paquetes adicionales de Bluetooth..."
sudo pacman -S --needed --noconfirm pulseaudio-bluetooth pavucontrol

# Habilitar e iniciar servicios de Bluetooth
log "Habilitando e iniciando servicio bluetooth..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Configurar Bluetooth para auto-encendido
log "Configurando Bluetooth para encendido automático..."
sudo sed -i 's/#AutoEnable=false/AutoEnable=true/' /etc/bluetooth/main.conf

# Agregar usuario al grupo lp para acceso completo a Bluetooth
log "Agregando usuario al grupo lp para acceso a Bluetooth..."
sudo usermod -a -G lp $USER

# Verificar estado del servicio
log "Verificando estado del servicio bluetooth..."
if systemctl is-active --quiet bluetooth; then
    info "✓ Servicio bluetooth activo y funcionando"
else
    warn "⚠ El servicio bluetooth no está activo"
fi

# Mostrar comandos útiles
info "Comandos útiles:"
info "  • bluetuith          - TUI completo para gestión de Bluetooth"
info "  • bluetoothctl       - CLI de Bluetooth (scan on, pair, connect)"
info "  • pavucontrol        - Control de audio Bluetooth (GUI)"

log "✓ Bluetooth instalado y configurado correctamente"
log "✓ Reinicia la sesión para aplicar todos los permisos de grupo"
warn "Nota: Usa 'bluetuith' para una interfaz TUI completa de Bluetooth"