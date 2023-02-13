#!/bin/bash
# install essential software in linux

sudo apt install git build-essential
cat << EOF
# manual installations

- obsidian: 
- vscode: https://code.visualstudio.com/docs/setup/linux
- asdf: https://asdf-vm.com/guide/getting-started.html#official-download"
  - asdf plugin add python nodejs rust (may need deps)
- lunarvim
  - nerdfonts
  - neovim
  - lunarvim

EOF
