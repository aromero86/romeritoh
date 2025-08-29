#!/bin/bash

# =============================================================================
# Romeritoh's Arch Linux Setup Script
# =============================================================================
# Script principal para configurar Arch Linux con Hyprland
# Autor: Romeritoh
# Fecha: 28 de Agosto 2025
# =============================================================================

set -e  # Salir si algún comando falla

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para logging
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

info() {
    echo -e "${BLUE}[INFO] $1${NC}"
}

# Banner
clear
echo -e "${BLUE}"
echo "================================================================="
echo "    Romeritoh's Arch Linux Configuration Script"
echo "================================================================="
echo -e "${NC}"

# Verificar que estamos en Arch Linux
if ! command -v pacman &> /dev/null; then
    error "Este script está diseñado para Arch Linux"
    exit 1
fi

# Verificar que el script se ejecuta como root o con sudo
if [[ $EUID -eq 0 ]]; then
    warning "Ejecutándose como root"
else
    info "Ejecutándose como usuario normal (recomendado)"
fi

# Directorio base del script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$SCRIPT_DIR/scripts"

# Verificar que existe el directorio scripts
if [ ! -d "$SCRIPTS_DIR" ]; then
    error "No se encontró el directorio scripts en $SCRIPTS_DIR"
    exit 1
fi

# Función para ejecutar scripts
execute_script() {
    local script_name="$1"
    local script_path="$SCRIPTS_DIR/$script_name"
    
    if [ -f "$script_path" ]; then
        log "Ejecutando $script_name..."
        chmod +x "$script_path"
        bash "$script_path"
        if [ $? -eq 0 ]; then
            log "✓ $script_name completado exitosamente"
        else
            error "✗ Error ejecutando $script_name"
            exit 1
        fi
    else
        error "Script $script_name no encontrado en $script_path"
        exit 1
    fi
}

# Función principal - Instalación automática
main() {
    log "Iniciando configuración automática de Romeritoh's Arch..."
    
    read -p "¿Continuar con la instalación? (y/N): " confirm
    case $confirm in
        [yY]|[yY][eE][sS])
            log "Iniciando instalación..."
            ;;
        *)
            log "Instalación cancelada"
            exit 0
            ;;
    esac
    
    # Ejecutar todos los scripts de configuración
    execute_script "font.sh"
    execute_script "kitty.sh"
    execute_script "hyprland.sh"
    execute_script "hyprpaper.sh"
    execute_script "git.sh"
    execute_script "nvm.sh"
    execute_script "chromium.sh"
    execute_script "vscode.sh"
    
    log "¡Configuración finalizada!"
}

# Ejecutar función principal
main

log "¡Configuración completada!"
