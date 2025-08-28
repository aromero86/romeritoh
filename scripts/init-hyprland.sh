#!/bin/bash

# =============================================================================
# Hyprland Initialization Script
# =============================================================================
# Script para instalar y configurar Hyprland en Arch Linux
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
    echo -e "${GREEN}[HYPRLAND] $1${NC}"
}

error() {
    echo -e "${RED}[HYPRLAND ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[HYPRLAND INFO] $1${NC}"
}

log "Iniciando configuración de Hyprland..."

# Aquí iremos añadiendo paso a paso lo que me vayas diciendo

log "✓ Script de Hyprland listo para construir paso a paso"
