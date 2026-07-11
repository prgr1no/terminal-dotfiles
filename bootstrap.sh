#!/usr/bin/env bash
#
# Instalador de terminal-dotfiles (kitty + zsh + Starship + yazi, tema Dracula).
#
#   curl -fsSL https://raw.githubusercontent.com/prgr1no/terminal-dotfiles/main/bootstrap.sh | bash
#
# Instala las herramientas (apt/Ubuntu-Debian o dnf/Fedora) y copia las
# configuraciones. Idempotente: se puede volver a ejecutar sin problema.

set -uo pipefail

REPO_URL="${TERMINAL_DOTFILES_REPO:-https://github.com/prgr1no/terminal-dotfiles}"
CLONE_DIR="${TERMINAL_DOTFILES_DIR:-$HOME/terminal-dotfiles}"

c_info='\033[1;35m'; c_ok='\033[1;32m'; c_warn='\033[1;33m'; c_off='\033[0m'
info() { printf "${c_info}::${c_off} %s\n" "$*"; }
ok()   { printf "${c_ok}✓${c_off}  %s\n" "$*"; }
warn() { printf "${c_warn}!!${c_off} %s\n" "$*" >&2; }
have() { command -v "$1" >/dev/null 2>&1; }

# --- gestor de paquetes + sudo ---------------------------------------------
if have apt-get; then PM=apt
elif have dnf;   then PM=dnf
else PM=""; warn "Solo soporto apt (Debian/Ubuntu) y dnf (Fedora). Instala las herramientas a mano; igualmente copiaré las configs."; fi

SUDO=""
if [ "$(id -u)" -ne 0 ]; then
  if have sudo; then SUDO="sudo"; else warn "Sin sudo: puede que no pueda instalar paquetes del sistema."; fi
fi

pkg_install() {
  [ -n "$PM" ] || return 0
  case "$PM" in
    apt) $SUDO apt-get install -y "$@" ;;
    dnf) $SUDO dnf install -y "$@" ;;
  esac
}

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/fonts"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH";; esac

# --- 1) paquetes del sistema ------------------------------------------------
info "Instalando herramientas del sistema ($PM)…"
case "$PM" in
  apt)
    $SUDO apt-get update -y || warn "apt update falló (sigo)"
    pkg_install git curl unzip fontconfig zsh kitty fzf fd-find ripgrep bat zoxide btop \
                zsh-autosuggestions zsh-syntax-highlighting fonts-hack || warn "Algún paquete apt no se instaló"
    ;;
  dnf)
    pkg_install git curl unzip fontconfig zsh kitty fzf fd-find ripgrep bat zoxide btop eza \
                zsh-autosuggestions zsh-syntax-highlighting || warn "Algún paquete dnf no se instaló"
    ;;
esac

# En Debian/Ubuntu los binarios se llaman batcat / fdfind: enlaces a bat / fd.
have batcat && ! have bat && ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
have fdfind && ! have fd  && ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"

# --- 2) eza (si no está en repos, binario oficial) --------------------------
if ! have eza; then
  info "Instalando eza (binario)…"
  ev="$(curl -fsSL https://api.github.com/repos/eza-community/eza/releases/latest 2>/dev/null | grep -m1 '"tag_name"' | cut -d'"' -f4)"
  if [ -n "${ev:-}" ]; then
    if curl -fL --retry 2 -o /tmp/eza.tar.gz \
        "https://github.com/eza-community/eza/releases/download/${ev}/eza_x86_64-unknown-linux-gnu.tar.gz" 2>/dev/null; then
      tar xf /tmp/eza.tar.gz -C "$HOME/.local/bin" ./eza 2>/dev/null || tar xf /tmp/eza.tar.gz -C "$HOME/.local/bin" eza
      chmod +x "$HOME/.local/bin/eza" 2>/dev/null
      rm -f /tmp/eza.tar.gz
    fi
  fi
  have eza && ok "eza instalado" || warn "No pude instalar eza (los alias ls/ll usarán el que haya)"
fi

# --- 3) Starship ------------------------------------------------------------
if ! have starship; then
  info "Instalando Starship…"
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin" || warn "No pude instalar Starship"
fi

# --- 4) yazi (explorador con vista de imágenes) -----------------------------
if ! have yazi; then
  info "Instalando yazi…"
  yv="$(curl -fsSL https://api.github.com/repos/sxyazi/yazi/releases/latest 2>/dev/null | grep -m1 '"tag_name"' | cut -d'"' -f4)"
  if [ -n "${yv:-}" ] && curl -fL --retry 2 -o /tmp/yazi.zip \
        "https://github.com/sxyazi/yazi/releases/download/${yv}/yazi-x86_64-unknown-linux-musl.zip" 2>/dev/null; then
    rm -rf /tmp/yazi-x && mkdir -p /tmp/yazi-x
    (unzip -oq /tmp/yazi.zip -d /tmp/yazi-x 2>/dev/null) || \
      python3 -c "import zipfile;zipfile.ZipFile('/tmp/yazi.zip').extractall('/tmp/yazi-x')" 2>/dev/null
    yb="$(find /tmp/yazi-x -type f -name yazi 2>/dev/null | head -1)"
    ab="$(find /tmp/yazi-x -type f -name ya   2>/dev/null | head -1)"
    [ -n "$yb" ] && install -m755 "$yb" "$HOME/.local/bin/yazi"
    [ -n "$ab" ] && install -m755 "$ab" "$HOME/.local/bin/ya"
    rm -rf /tmp/yazi.zip /tmp/yazi-x
  fi
  have yazi && ok "yazi instalado" || warn "No pude instalar yazi"
fi

# --- 5) Nerd Font (si no hay ninguna) ---------------------------------------
if ! fc-list 2>/dev/null | grep -qi "Nerd Font"; then
  info "Instalando Hack Nerd Font…"
  if curl -fL --retry 2 -o /tmp/Hack.tar.xz \
      "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz" 2>/dev/null; then
    mkdir -p "$HOME/.local/share/fonts/HackNerdFont"
    tar xf /tmp/Hack.tar.xz -C "$HOME/.local/share/fonts/HackNerdFont" 2>/dev/null
    fc-cache -f "$HOME/.local/share/fonts" >/dev/null 2>&1
    rm -f /tmp/Hack.tar.xz
    ok "Hack Nerd Font instalada"
  else
    warn "No pude descargar la Nerd Font (los iconos podrían no verse)"
  fi
fi

# --- 6) repo + configuraciones ----------------------------------------------
if [ -d "$CLONE_DIR/.git" ]; then
  info "Actualizando repo en $CLONE_DIR…"
  git -C "$CLONE_DIR" pull --ff-only || warn "No pude actualizar el repo (sigo con lo que hay)"
else
  info "Clonando repo en $CLONE_DIR…"
  git clone --depth 1 "$REPO_URL" "$CLONE_DIR" || { warn "No pude clonar el repo"; exit 1; }
fi

info "Copiando configuraciones…"
bash "$CLONE_DIR/bin/install.sh"

printf '\n'
ok "¡Listo! Abre kitty o una terminal nueva."
info "Herramientas: $(for t in kitty zsh starship fzf fd rg bat eza zoxide yazi; do have "$t" && printf '%s ' "$t"; done)"
[ -n "$PM" ] || warn "Recuerda: instala kitty/zsh/etc. a mano en tu distro."
