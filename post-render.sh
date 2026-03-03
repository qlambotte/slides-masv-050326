#!/usr/bin/env bash
set -e

# dossier de sortie
mkdir -p _site/assets

# détection automatique de l'URL GH Pages
REPO_URL=$(git config --get remote.origin.url)
REPO_NAME=$(basename -s .git "$REPO_URL")
USER_NAME=$(echo "$REPO_URL" | sed -E 's#.*[:/](.*)/.*#\1#')
GH_URL="https://${USER_NAME}.github.io/${REPO_NAME}/slides.html"

# génération du QR code
echo "🔗 Génération du QR code..."
qrencode -o _site/assets/qrcode.png "$GH_URL"


# génération du PDF avec Decktape
echo "📄 Génération du PDF..."
decktape --chrome-path=$(which chromium) reveal _site/slides.html _site/assets/slides.pdf


echo "✅ PDF et QR code générés avec succès."

