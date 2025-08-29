#!/bin/bash

# =============================================================================
# greetd + tuigreet Installation and Configuration Script
# =============================================================================
# Script para instalar y configurar greetd con tuigreet (TUI greeter)
# Parte del sistema modular de Romeritoh
# =============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[GREET] $1${NC}"
}

error() {
    echo -e "${RED}[GREET ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[GREET INFO] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[GREET WARN] $1${NC}"
}

log "Configurando greetd + tuigreet (TUI Display Manager)..."

# Verificar si ya hay un display manager activo
info "Verificando display managers existentes..."
ACTIVE_DM=$(systemctl list-unit-files --type=service | grep -E "(gdm|sddm|lightdm|greetd).*enabled" || true)

if [[ -n "$ACTIVE_DM" ]]; then
    warn "Display manager activo detectado:"
    echo -e "${YELLOW}$ACTIVE_DM${NC}"
    warn "Deshabilitando display managers existentes..."
    
    # Deshabilitar display managers comunes
    for dm in gdm sddm lightdm; do
        if systemctl is-enabled "$dm" 2>/dev/null | grep -q "enabled"; then
            info "Deshabilitando $dm..."
            sudo systemctl disable "$dm" 2>/dev/null || true
        fi
    done
fi

# Instalar greetd y tuigreet
log "Instalando greetd y tuigreet..."
sudo pacman -S --needed greetd greetd-tuigreet

# Crear directorio de configuración
sudo mkdir -p /etc/greetd

# Configurar greetd
log "Creando configuración de greetd..."
sudo tee /etc/greetd/config.toml > /dev/null << 'EOF'
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --remember --remember-user-session --asterisks"
user = "greeter"

[initial_session]
command = "Hyprland"
user = "angel"
EOF

# Configurar greetd (siempre pide password)
log "Configurando greetd para solicitar password siempre..."

sudo tee /etc/greetd/config.toml > /dev/null << 'EOF'
[terminal]
vt = 1

[default_session]
command = "tuigreet --time --remember --remember-user-session --asterisks --greeting 'Welcome to Romeritoh Arch Setup'"
user = "greeter"
EOF

# Añadir usuario greeter al grupo video (para acceso a framebuffer)
log "Configurando permisos para greeter..."
sudo usermod -a -G video greeter 2>/dev/null || sudo useradd -r -g greeter -G video -s /sbin/nologin greeter

# Habilitar greetd
log "Habilitando greetd service..."
sudo systemctl enable greetd

# Crear archivo de configuración para tuigreet (opcional)
log "Creando configuración adicional para tuigreet..."
sudo mkdir -p /etc/greetd
sudo tee /etc/greetd/tuigreet.toml > /dev/null << 'EOF'
[general]
time_format = "%H:%M"
asterisks = true
remember = true
remember_user_session = true

[style]
title = "Romeritoh Arch Setup"
greeting = "Welcome back!"
EOF

# Información final
log "✓ greetd + tuigreet instalado y configurado correctamente"
info "Configuración aplicada:"
info "  • Display Manager: greetd"
info "  • Greeter: tuigreet (TUI aesthetic)"
info "  • Sesión por defecto: Hyprland disponible"
info "  • Autenticación: Siempre solicita password"
info "  • Greeting personalizado activado"

warn "IMPORTANTE: El nuevo display manager se activará en el próximo reinicio"
warn "Para aplicar ahora: sudo systemctl start greetd (cerrará la sesión actual)"

log "greetd + tuigreet configurado exitosamente!"