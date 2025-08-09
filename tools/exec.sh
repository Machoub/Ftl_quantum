#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="${1:-quantum_container}"

# Attendre jusqu'à 60s que Jupyter affiche l’URL
URL=""
for i in {1..60}; do
  URL="$(docker logs "$CONTAINER_NAME" 2>&1 | grep -Eo 'http://[^ ]*:8888(/(tree|lab))?\?token=[^ ]+' | tail -n1 || true)"
  [ -n "$URL" ] && break
  sleep 1
done

if [ -z "$URL" ]; then
  # Si pas de token dans les logs, tente l’URL par défaut
  URL="http://localhost:8888"
  echo "Warning: URL avec token non trouvée, tentative sur $URL"
fi

echo "Jupyter Notebook URL:"
echo "$URL"
command -v xdg-open >/dev/null 2>&1 && xdg-open "$URL" >/dev/null 2>&1 & disown || true