#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
stamp="$(date +%Y%m%d-%H%M%S)"

install_dotfile() {
  local source_file="$1"
  local target_file="$2"

  if [ -e "$target_file" ]; then
    cp "$target_file" "$target_file.bak.$stamp"
    printf 'Backup creado: %s\n' "$target_file.bak.$stamp"
  fi

  cp "$source_file" "$target_file"
  printf 'Instalado: %s\n' "$target_file"
}

install_dotfile "$repo_dir/dotfiles/bashrc" "$HOME/.bashrc"
install_dotfile "$repo_dir/dotfiles/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config"
install_dotfile "$repo_dir/config/starship/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/terminal-kit" "$HOME/.config/ripgrep" "$HOME/.config/btop/themes"
install_dotfile "$repo_dir/config/terminal-kit/palette.sh" "$HOME/.config/terminal-kit/palette.sh"
install_dotfile "$repo_dir/config/ripgrep/config" "$HOME/.config/ripgrep/config"
install_dotfile "$repo_dir/config/btop/btop.conf" "$HOME/.config/btop/btop.conf"
install_dotfile "$repo_dir/config/btop/themes/terminal-kit-dracula.theme" "$HOME/.config/btop/themes/terminal-kit-dracula.theme"

mkdir -p "$HOME/.config/kitty" "$HOME/.config/yazi"
install_dotfile "$repo_dir/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
install_dotfile "$repo_dir/config/kitty/dracula.conf" "$HOME/.config/kitty/dracula.conf"
install_dotfile "$repo_dir/config/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
install_dotfile "$repo_dir/config/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"

if [ ! -x "$HOME/.local/bin/zsh" ]; then
  printf '\nAviso: no existe %s\n' "$HOME/.local/bin/zsh"
  printf 'La configuracion esta instalada, pero falta instalar el kit local de herramientas.\n'
fi

if ! command -v kitty >/dev/null 2>&1; then
  printf '\nAviso: kitty no esta instalado (sudo dnf install kitty / apt install kitty).\n'
fi

if [ ! -x "$HOME/.local/bin/yazi" ]; then
  printf '\nAviso: yazi no esta en %s (explorador de archivos con vista de imagenes).\n' "$HOME/.local/bin/yazi"
fi

printf '\nListo. Abre una terminal nueva para usar la configuracion.\n'

