#!/bin/bash

# =============================================================================
# Kitty Terminal Installation and Configuration Script
# =============================================================================
# Script para instalar y configurar Kitty terminal en Arch Linux
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
    echo -e "${GREEN}[KITTY] $1${NC}"
}

error() {
    echo -e "${RED}[KITTY ERROR] $1${NC}"
}

info() {
    echo -e "${BLUE}[KITTY INFO] $1${NC}"
}

log "Iniciando instalación y configuración de Kitty..."

# Instalar Kitty
log "Instalando Kitty..."
sudo pacman -S --needed --noconfirm kitty

# Crear configuración de Kitty
log "Creando configuración de Kitty..."
mkdir -p ~/.config/kitty

cat > ~/.config/kitty/kitty.conf << 'EOF'
# Kitty Configuration - Romeritoh

# Font settings
font_family CaskaydiaCove Nerd Font
bold_font auto
italic_font auto
bold_italic_font auto
font_size 11.0

# Cursor
cursor_shape block
cursor_beam_thickness 1.5
cursor_underline_thickness 2.0
cursor_blink_interval 0.5
cursor_stop_blinking_after 15.0

# Scrollback
scrollback_lines 2000
scrollback_pager less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER
scrollback_pager_history_size 0

# Mouse
mouse_hide_wait 3.0
url_color #0087bd
url_style curly
open_url_modifiers kitty_mod
open_url_with default
url_prefixes http https file ftp gemini irc gopher mailto news git
detect_urls yes

# Performance tuning
repaint_delay 10
input_delay 3
sync_to_monitor yes

# Terminal bell
enable_audio_bell no
visual_bell_duration 0.0

# Window layout
remember_window_size yes
initial_window_width 640
initial_window_height 400
window_resize_step_cells 2
window_resize_step_lines 2
window_border_width 0.5pt
draw_minimal_borders yes
window_margin_width 0
single_window_margin_width -1
window_padding_width 10
placement_strategy center
active_border_color #00ff00
inactive_border_color #cccccc
bell_border_color #ff5a00
inactive_text_alpha 1.0

# Tab bar
tab_bar_edge bottom
tab_bar_margin_width 0.0
tab_bar_style fade
tab_bar_min_tabs 2
tab_switch_strategy previous
tab_fade 0.25 0.5 0.75 1
tab_separator " ┇"
tab_title_template "{title}"
active_tab_title_template none
active_tab_foreground #000
active_tab_background #eee
active_tab_font_style bold-italic
inactive_tab_foreground #444
inactive_tab_background #999
inactive_tab_font_style normal

# Color scheme (default)
foreground #dddddd
background #000000
selection_foreground #000000
selection_background #fffacd

# The 16 terminal colors
color0 #000000
color1 #cc0403
color2 #19cb00
color3 #cecb00
color4 #001cd1
color5 #cb1ed1
color6 #0dcdcd
color7 #e5e5e5
color8 #4d4d4d
color9 #f2201f
color10 #23fd00
color11 #fffd00
color12 #0026ff
color13 #fd28ff
color14 #14ffff
color15 #ffffff

# Advanced
shell .
editor .
close_on_child_death no
allow_remote_control yes
update_check_interval 24
startup_session none
clipboard_control write-clipboard write-primary
term xterm-kitty
EOF

log "✓ Kitty instalado y configurado con Cascadia Code Nerd Font"
info "Configuración guardada en ~/.config/kitty/kitty.conf"