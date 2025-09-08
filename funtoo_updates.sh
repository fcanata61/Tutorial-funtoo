#!/bin/bash
# Arquivo: ~/bin/funtoo-updates.sh
# Retorna o número de pacotes que podem ser atualizados

# Atualiza metadados do Portage
emerge --sync --quiet

# Conta pacotes que têm atualização
updates=$(emerge -uDNav @world | grep -c ">>>")

# Exibe na barra (ou terminal)
if [ "$updates" -gt 0 ]; then
    echo " $updates updates"
else
    echo "✓ up-to-date"
fi
