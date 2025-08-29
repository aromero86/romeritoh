#!/bin/bash

# =============================================================================
# SDDM + Chili Theme Installation and Configuration Script  
# =============================================================================
# Script para instalar y configurar SDDM con tema Chili
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
    echo -e "${GREEN}[SDDM] $1${NC}"
}

error() {
    echo -e "${RED}[SDDM ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[SDDM INFO] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[SDDM WARN] $1${NC}"
}

log "Configurando SDDM con tema Chili..."

# Verificar si ya hay un display manager activo
info "Verificando display managers existentes..."
ACTIVE_DM=$(systemctl list-unit-files --type=service | grep -E "(gdm|sddm|lightdm|greetd).*enabled" || true)

if [[ -n "$ACTIVE_DM" ]]; then
    warn "Display manager activo detectado:"
    echo -e "${YELLOW}$ACTIVE_DM${NC}"
    warn "Deshabilitando display managers existentes..."
    
    # Deshabilitar display managers comunes
    for dm in gdm lightdm greetd; do
        if systemctl is-enabled "$dm" 2>/dev/null | grep -q "enabled"; then
            info "Deshabilitando $dm..."
            sudo systemctl disable "$dm" 2>/dev/null || true
        fi
    done
fi

# Instalar SDDM y dependencias
log "Instalando SDDM y dependencias..."
sudo pacman -S --needed --noconfirm sddm qt5-graphicaleffects qt5-svg qt5-quickcontrols qt5-quickcontrols2

# Crear directorios necesarios
log "Creando directorios de configuración..."
sudo mkdir -p /etc/sddm.conf.d
sudo mkdir -p /usr/share/sddm/themes

# Descargar tema Chili
log "Descargando tema Chili para SDDM..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Descargar desde GitHub (repositorio oficial del tema)
curl -L -o chili-theme.tar.gz "https://github.com/MarianArlt/sddm-chili/archive/refs/heads/master.tar.gz"
tar -xzf chili-theme.tar.gz

# Copiar tema al directorio de SDDM
sudo cp -r sddm-chili-master /usr/share/sddm/themes/chili
sudo chmod -R 755 /usr/share/sddm/themes/chili

# Limpiar archivos temporales
cd /
rm -rf "$TEMP_DIR"

# Configurar SDDM para usar el tema Chili
log "Configurando SDDM con tema Chili..."
sudo tee /etc/sddm.conf.d/theme.conf > /dev/null << 'EOF'
[Theme]
Current=chili

[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
EOF

# Habilitar SDDM
log "Habilitando SDDM service..."
sudo systemctl enable sddm

# Información final
# Configurar fondo personalizado
log "Configurando fondo personalizado (astronaut.jpg)..."

# Verificar que el wallpaper existe
if [ -f "$HOME/Pictures/astronaut.jpg" ]; then
    info "Copiando astronaut.jpg al tema chili..."
    sudo cp "$HOME/Pictures/astronaut.jpg" /usr/share/sddm/themes/chili/
    
    # Hacer backup de la configuración original
    if [ ! -f /usr/share/sddm/themes/chili/theme.conf.backup ]; then
        info "Creando backup de theme.conf..."
        sudo cp /usr/share/sddm/themes/chili/theme.conf /usr/share/sddm/themes/chili/theme.conf.backup
    fi
    
    # Modificar configuración del tema para usar astronaut.jpg
    info "Configurando astronaut.jpg como fondo..."
    sudo sed -i 's/^background=.*/background=astronaut.jpg/' /usr/share/sddm/themes/chili/theme.conf
    
    # Centrar texto del password input
    info "Configurando texto centrado en campos de entrada..."
    echo 'PasswordFieldCentered=true' | sudo tee -a /usr/share/sddm/themes/chili/theme.conf > /dev/null
    echo 'UserFieldCentered=true' | sudo tee -a /usr/share/sddm/themes/chili/theme.conf > /dev/null
    
    # Verificar que el cambio se aplicó
    if grep -q "background=astronaut.jpg" /usr/share/sddm/themes/chili/theme.conf; then
        log "✓ Fondo personalizado configurado correctamente"
    else
        error "No se pudo configurar el fondo personalizado"
    fi
else
    warn "astronaut.jpg no encontrado en ~/Pictures - usando fondo por defecto del tema"
fi

log "✓ SDDM con tema Chili instalado y configurado correctamente"
info "Configuración aplicada:"
info "  • Display Manager: SDDM"
info "  • Tema: Chili (moderno y elegante)"
info "  • Fondo: astronaut.jpg personalizado"
info "  • Texto centrado en campos de entrada"
info "  • Sesión por defecto: Hyprland disponible"
info "  • Configuración: /etc/sddm.conf.d/theme.conf"
info "  • Ubicación del tema: /usr/share/sddm/themes/chili"

warn "IMPORTANTE: El nuevo display manager se activará en el próximo reinicio"
warn "Para aplicar ahora: sudo systemctl start sddm (cerrará la sesión actual)"

log "SDDM con tema Chili y fondo personalizado configurado exitosamente!"