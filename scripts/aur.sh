#!/bin/bash

# =============================================================================
# AUR Helper Installation Script
# =============================================================================
# Script para instalar yay (AUR Helper) en Arch Linux
# Permite acceso a Arch User Repository (AUR)
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
    echo -e "${GREEN}[AUR] $1${NC}"
}

error() {
    echo -e "${RED}[AUR ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[AUR INFO] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[AUR WARN] $1${NC}"
}

log "Iniciando instalación de AUR Helper (yay)..."

# Verificar que estamos en Arch Linux
if ! command -v pacman &> /dev/null; then
    error "Este script solo funciona en Arch Linux"
    exit 1
fi

# Verificar si yay ya está instalado
if command -v yay &> /dev/null; then
    info "yay ya está instalado"
    yay --version
    exit 0
fi

# Obtener el usuario real (no root)
REAL_USER="${SUDO_USER:-$USER}"
if [ "$REAL_USER" = "root" ]; then
    error "No se puede determinar el usuario real. Ejecuta sin sudo."
    exit 1
fi

# Instalar dependencias necesarias para compilar yay
log "Instalando dependencias para compilar yay..."
sudo pacman -S --needed --noconfirm base-devel git

# Crear directorio temporal para la compilación
TEMP_DIR="/tmp/yay-install"
log "Creando directorio temporal en $TEMP_DIR..."
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"
chown "$REAL_USER:$REAL_USER" "$TEMP_DIR"
cd "$TEMP_DIR"

# Clonar repositorio de yay como usuario normal
log "Clonando repositorio de yay desde AUR..."
sudo -u "$REAL_USER" git clone https://aur.archlinux.org/yay.git

# Cambiar al directorio de yay
cd yay

# Compilar e instalar yay como usuario normal
log "Compilando e instalando yay..."
sudo -u "$REAL_USER" makepkg -si --noconfirm

# Limpiar archivos temporales
log "Limpiando archivos temporales..."
cd /
rm -rf "$TEMP_DIR"

# Verificar instalación
if command -v yay &> /dev/null; then
    log "✓ yay instalado correctamente"
    info "Versión instalada: $(yay --version | head -n1)"
    
    # Configurar yay para mejor experiencia
    log "Configurando yay..."
    yay --save --answerdiff None --answerclean None --removemake
    
    info "Comandos útiles de yay:"
    info "  • yay -S <paquete>     - Instalar paquete de AUR"
    info "  • yay -Syu             - Actualizar sistema + AUR"
    info "  • yay -Ss <buscar>     - Buscar paquetes en AUR"
    info "  • yay -Yc              - Limpiar caché de compilación"
    
else
    error "Error en la instalación de yay"
    exit 1
fi

log "✓ AUR Helper (yay) instalado y configurado correctamente"
warn "Ahora puedes instalar paquetes de AUR con: yay -S <nombre_paquete>"