#!/bin/bash
# Arquivo: ~/bin/funtoo-bar-updates.sh
# Mostra no estilo barra: número de pacotes a atualizar
# Funciona para polybar, i3status, lemonbar etc.

# Configura cores ANSI (opcional)
COLOR_OK="%{F#00FF00}"      # verde
COLOR_UPDATES="%{F#FF0000}" # vermelho
COLOR_RESET="%{F-}"

# Atualiza cache do Portage (rápido)
emerge --metadata --quiet

# Conta pacotes que têm atualização
updates=$(emerge -uDNav @world | grep -c ">>>")

# Mostra no formato barra
if [ "$updates" -gt 0 ]; then
    echo "${COLOR_UPDATES} $updates updates${COLOR_RESET}"
else
    echo "${COLOR_OK}✓ up-to-date${COLOR_RESET}"
fi
