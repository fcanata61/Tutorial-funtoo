#!/bin/bash
# Script: my-funtoo-sync.sh
# Atualiza o meta-repo do Funtoo com ebuilds do Gentoo

set -e

GENTOO_REPO="/var/tmp/gentoo-ebuilds"
MY_REPO="/var/git/my-funtoo-meta-repo"

echo "==> Atualizando repositório Gentoo..."
if [ -d "$GENTOO_REPO/.git" ]; then
    cd "$GENTOO_REPO"
    git fetch origin
    git reset --hard origin/master
else
    git clone https://github.com/gentoo/gentoo.git "$GENTOO_REPO"
fi

echo "==> Atualizando meta-repo customizado..."

# Core Kit
rm -rf $MY_REPO/core-kit/sys-libs $MY_REPO/core-kit/sys-devel
cp -r $GENTOO_REPO/sys-libs $MY_REPO/core-kit/
cp -r $GENTOO_REPO/sys-devel $MY_REPO/core-kit/

# Python Kit
rm -rf $MY_REPO/python-kit/dev-lang
cp -r $GENTOO_REPO/dev-lang/python* $MY_REPO/python-kit/

# Desktop Kit
rm -rf $MY_REPO/desktop-kit/x11-base $MY_REPO/desktop-kit/x11-libs
cp -r $GENTOO_REPO/x11-base $MY_REPO/desktop-kit/
cp -r $GENTOO_REPO/x11-libs $MY_REPO/desktop-kit/

# Media Kit
rm -rf $MY_REPO/media-kit/media-libs $MY_REPO/media-kit/media-video $MY_REPO/media-kit/media-sound
cp -r $GENTOO_REPO/media-libs $MY_REPO/media-kit/
cp -r $GENTOO_REPO/media-video $MY_REPO/media-kit/
cp -r $GENTOO_REPO/media-sound $MY_REPO/media-kit/

# Net Kit
rm -rf $MY_REPO/net-kit/net-libs $MY_REPO/net-kit/net-misc
cp -r $GENTOO_REPO/net-libs $MY_REPO/net-kit/
cp -r $GENTOO_REPO/net-misc $MY_REPO/net-kit/

# Dev Kit
rm -rf $MY_REPO/dev-kit/dev-util $MY_REPO/dev-kit/dev-db $MY_REPO/dev-kit/dev-php
cp -r $GENTOO_REPO/dev-util $MY_REPO/dev-kit/
cp -r $GENTOO_REPO/dev-db $MY_REPO/dev-kit/
cp -r $GENTOO_REPO/dev-php $MY_REPO/dev-kit/

# Comitar alterações
cd $MY_REPO
git add .
git commit -m "Sync: atualizando ebuilds Gentoo para kits (data: $(date +%F %T))" || true

echo "==> Sincronização concluída!"
