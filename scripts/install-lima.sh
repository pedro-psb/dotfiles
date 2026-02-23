#!/bin/bash

set -euo pipefail

PACKAGE_NAME=lima
VERSION=$(curl -fsSL https://api.github.com/repos/lima-vm/lima/releases/latest | jq -r .tag_name)
PACKAGE_SRC="https://github.com/lima-vm/lima/releases/download/${VERSION}/lima-${VERSION:1}-$(uname -s)-$(uname -m).tar.gz"
TARGET_DIR="/usr/local/stow/$PACKAGE_NAME"
mkdir -p "$TARGET_DIR"
curl -fsSL "$PACKAGE_SRC" | tar Cxzvm "$TARGET_DIR"
stow -d /usr/local/stow "$PACKAGE_NAME"
