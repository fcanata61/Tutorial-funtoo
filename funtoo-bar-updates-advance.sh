#!/bin/bash
# Arquivo: ~/bin/funtoo-bar-updates-advanced.sh
# Script avançado para barra de WM (i3, polybar, lemonbar)
# Mostra updates de pacotes sem travar a barra

CACHE_FILE="$HOME/.cache/funtoo_updates.txt"
TOOLTIP_FILE="$HOME/.cache/funtoo_updates_tooltip.txt"

COLOR_OK="%{F#00FF00}"      # verde
COLOR_UPDATES="%{F#FF0000}" # vermelho
COLOR_RESET="%{F-}"

# Atualiza cache do Portage em background a cada hora
if [ ! -f "$CACHE_FILE" ] || [ $(find "$CACHE_FILE" -mmin +60) ]; then
    (emerge --sync --quiet && emerge -uDNav @world | grep ">>>" > "$TOOLTIP_FILE") &
fi

# Lê número de updates da última execução
if [ -f "$TOOLTIP_FILE" ]; then
    updates=$(wc -l < "$TOOLTIP_FILE")
else
    updates=0
fi

# Mostra no formato barra
if [ "$updates" -gt 0 ]; then
    echo "${COLOR_UPDATES} $updates updates${COLOR_RESET}"
else
    echo "${COLOR_OK}✓ up-to-date${COLOR_RESET}"
fi

# Opcional: polybar suporta tooltip se o módulo estiver configurado
# Basta configurar exec-hover para mostrar conteúdo de TOOLTIP_FILE
