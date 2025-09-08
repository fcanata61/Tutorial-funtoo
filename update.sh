#!/bin/bash
emerge --sync
updates=$(emerge -uDNav @world | grep ">>>")

if [ -n "$updates" ]; then
    echo "Pacotes com atualização disponíveis:"
    echo "$updates"
fi
