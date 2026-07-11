# Terminal Dotfiles

Configuración de terminal moderna, ligera y sin frameworks pesados: **kitty + zsh + Starship + yazi**, con tema **Dracula** en toda la pila.

![shell](https://img.shields.io/badge/shell-zsh-89e051)
![terminal](https://img.shields.io/badge/terminal-kitty-9b59b6)
![theme](https://img.shields.io/badge/theme-Dracula-bd93f9)
![license](https://img.shields.io/badge/license-MIT-blue)

## ✨ Qué incluye

- **kitty** — emulador de terminal GPU con transparencia (+ blur en KDE/Wayland), tema Dracula, Nerd Font y ~47 atajos.
- **zsh** — shell interactiva sin Oh My Zsh: autosugerencias, resaltado de sintaxis, historial compartido.
- **Starship** — prompt Dracula con usuario, host, ruta, rama Git y código de error.
- **yazi** — explorador de archivos en Rust con **vista previa de imágenes** por el protocolo gráfico de kitty.
- **Herramientas modernas** — `bat` (cat), `eza` (ls), `fzf`, `fd`, `ripgrep`, `zoxide`, `duf`, `ncdu`.
- **Paleta Dracula compartida** para bat, fzf, ripgrep, eza/ls, less, Starship y btop.

## 📄 Atajos

Chuleta completa de kitty, zsh y yazi en **[docs/cheatsheet.md](docs/cheatsheet.md)**.

## 📁 Estructura

```text
dotfiles/
  bashrc          # handoff a zsh + fallback bash
  zshrc           # zsh: alias, funciones, fzf, zoxide, starship, yazi
config/
  kitty/          # kitty.conf + dracula.conf
  yazi/           # yazi.toml + theme.toml (Dracula)
  starship/       # starship.toml
  terminal-kit/   # palette.sh (paleta Dracula compartida)
  ripgrep/        # config
  btop/           # btop.conf + tema Dracula
docs/
  terminal-kit.md # documentación de la terminal
  cheatsheet.md   # chuleta de atajos
bin/
  install.sh      # copia las configs a su sitio (con backup)
```

## 🚀 Instalación

```bash
git clone https://github.com/prgr1no/terminal-dotfiles ~/terminal-dotfiles
cd ~/terminal-dotfiles
bash bin/install.sh      # hace backup de lo existente antes de reemplazar
```

Abre una terminal nueva (o kitty) para aplicar los cambios.

## 🔧 Requisitos

Las configs esperan estas herramientas disponibles (en el sistema o en `~/.local/bin`):

- **kitty** — `sudo dnf install kitty` / `sudo apt install kitty`, o el [instalador oficial](https://sw.kovidgoyal.net/kitty/binary/) en `~/.local`.
- **zsh, starship, fzf, fd, ripgrep, bat, eza, zoxide** — desde el gestor de paquetes o binarios de usuario.
- **yazi** — explorador de archivos ([sxyazi/yazi](https://github.com/sxyazi/yazi)).
- **Una Nerd Font** — p. ej. [Hack Nerd Font](https://www.nerdfonts.com/) (para los iconos de eza/starship).

## 🎨 Tema

**Dracula** en todo: kitty, prompt, yazi, `LS_COLORS`, fzf, bat, ripgrep y btop.
Fondo `#282a36` · texto `#f8f8f2` · morado `#bd93f9` · verde `#50fa7b` · cian `#8be9fd`.

## 🆘 Volver a bash

Para abrir bash sin saltar automáticamente a zsh:

```bash
TERMINAL_KIT_DISABLE_ZSH=1 bash
```

## 📜 Licencia

[MIT](LICENSE).
