#!/bin/bash

# =============================================================================
# ZSH and Oh My ZSH Installation Script
# =============================================================================
# Script para instalar ZSH y Oh My ZSH en Arch Linux
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
    echo -e "${GREEN}[ZSH] $1${NC}"
}

error() {
    echo -e "${RED}[ZSH ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[ZSH INFO] $1${NC}"
}

warning() {
    echo -e "${YELLOW}[ZSH WARNING] $1${NC}"
}

log "Iniciando instalación de ZSH y Oh My ZSH..."

# Instalar ZSH y figlet
log "Instalando ZSH y figlet..."
sudo pacman -S --needed --noconfirm zsh figlet

# Instalar Oh My ZSH
log "Instalando Oh My ZSH..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    info "Oh My ZSH instalado correctamente"
else
    warning "Oh My ZSH ya está instalado"
fi

# Descargar fuentes de figlet
log "Descargando fuentes de figlet..."
if [ ! -d "$HOME/.romeritoh/figlet" ]; then
    mkdir -p "$HOME/.romeritoh"
    git clone https://github.com/xero/figlet-fonts.git "$HOME/.romeritoh/figlet"
    info "Fuentes de figlet descargadas en ~/.romeritoh/figlet"
else
    warning "Fuentes de figlet ya están descargadas"
fi

# Configurar NVM en .zshrc
log "Configurando NVM en ZSH..."
if [ -f "$HOME/.zshrc" ]; then
    # Verificar si NVM ya está configurado
    if ! grep -q "NVM_DIR" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# NVM configuration" >> "$HOME/.zshrc"
        echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zshrc"
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> "$HOME/.zshrc"
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> "$HOME/.zshrc"
        info "NVM configurado en .zshrc"
    else
        info "NVM ya está configurado en .zshrc"
    fi
else
    warning ".zshrc no encontrado, se creará automáticamente al cambiar a ZSH"
fi

# Configurar aliases y funciones personalizadas
log "Configurando aliases y funciones personalizadas..."
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "# Custom aliases and functions" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# Custom aliases and functions" >> "$HOME/.zshrc"
        echo "# Clear with figlet" >> "$HOME/.zshrc"
        echo "alias clear='command clear && figlet \"Romeritoh\" -f \"miniwi\" -d ~/.romeritoh/figlet/ -w 120 && export AFTER_FIGLET=1'" >> "$HOME/.zshrc"
        echo "" >> "$HOME/.zshrc"
        echo "# Uncomment the next line to make micro editor always run with 0 padding" >> "$HOME/.zshrc"
        echo "# This alias automatically calls kitty_with_no_padding function before launching micro" >> "$HOME/.zshrc"
        echo "# alias micro='kitty_with_no_padding micro'" >> "$HOME/.zshrc"
        echo "" >> "$HOME/.zshrc"
        echo "# Kitty padding function" >> "$HOME/.zshrc"
        echo "kitty_with_no_padding() {" >> "$HOME/.zshrc"
        echo "    kitty @ set-spacing padding=0" >> "$HOME/.zshrc"
        echo "    if [ \$# -gt 0 ]; then" >> "$HOME/.zshrc"
        echo "        \"\$@\"" >> "$HOME/.zshrc"
        echo "        kitty @ set-spacing padding=10" >> "$HOME/.zshrc"
        echo "    fi" >> "$HOME/.zshrc"
        echo "}" >> "$HOME/.zshrc"
        info "Aliases y funciones personalizadas configuradas en .zshrc"
    else
        info "Configuración personalizada ya existe en .zshrc"
    fi
fi

# Configurar función precmd para espaciado de prompts
log "Configurando espaciado de prompts..."
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "# Add blank line before prompt" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "# Add blank line before prompt (except first one and after figlet)" >> "$HOME/.zshrc"
        echo "precmd() {" >> "$HOME/.zshrc"
        echo "    if [[ -n \"\$PROMPT_INITIALIZED\" && -z \"\$AFTER_FIGLET\" ]]; then" >> "$HOME/.zshrc"
        echo "        echo" >> "$HOME/.zshrc"
        echo "    else" >> "$HOME/.zshrc"
        echo "        export PROMPT_INITIALIZED=1" >> "$HOME/.zshrc"
        echo "        export AFTER_FIGLET=\"\"" >> "$HOME/.zshrc"
        echo "    fi" >> "$HOME/.zshrc"
        echo "}" >> "$HOME/.zshrc"
        info "Función precmd configurada en .zshrc"
    else
        info "Función precmd ya está configurada en .zshrc"
    fi
fi

# Agregar clear con figlet al final del .zshrc
log "Configurando clear con figlet de bienvenida..."
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q "^clear$" "$HOME/.zshrc"; then
        echo "" >> "$HOME/.zshrc"
        echo "clear" >> "$HOME/.zshrc"
        echo "" >> "$HOME/.zshrc"
        echo "export AFTER_FIGLET=1" >> "$HOME/.zshrc"
        info "Clear con figlet de bienvenida configurado en .zshrc"
    else
        info "Clear con figlet de bienvenida ya está configurado en .zshrc"
    fi
fi

# Cambiar shell por defecto a ZSH
log "Configurando ZSH como shell por defecto..."
if [ "$SHELL" != "/usr/bin/zsh" ]; then
    chsh -s /usr/bin/zsh
    info "Shell cambiado a ZSH. Reinicia la sesión para aplicar los cambios"
else
    info "ZSH ya es tu shell por defecto"
fi

log "✓ ZSH, Oh My ZSH y figlet instalados y configurados correctamente"
info "NVM, figlet y configuración personalizada incluidas en .zshrc"
info "Fuentes de figlet descargadas en ~/.romeritoh/figlet/"
info "Reinicia tu terminal o ejecuta 'zsh' para comenzar a usar ZSH"