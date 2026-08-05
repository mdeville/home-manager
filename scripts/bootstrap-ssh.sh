#!/usr/bin/env bash
set -euo pipefail

OP_VAULT="Employee"
OP_ITEM="nix-ssh-key"

KEY_PATH="$HOME/.ssh/id_ed25519"

if ! op account list --format=json 2>/dev/null | jq -e 'length > 0' >/dev/null; then
  echo "No 1Password account configured on this device yet."
  echo "You will be prompted for your sign-in address, email, Secret Key, and password."
  op account add
fi

eval "$(op signin)"

if [ -f "$KEY_PATH" ]; then
  echo "Key already present at $KEY_PATH, skipping fetch."
else
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  op read --out-file "$KEY_PATH" --file-mode 0600 \
    "op://${OP_VAULT}/${OP_ITEM}/private key?ssh-format=openssh"
  echo "Wrote $KEY_PATH"
fi

echo "Done. Run 'nix run' when ready."
