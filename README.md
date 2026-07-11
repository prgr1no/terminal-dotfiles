<div align="center">

# 🐉 Terminal Dotfiles

**kitty · zsh · Starship · yazi — todo en [Dracula](https://draculatheme.com)**

Configuración de terminal moderna y ligera, sin frameworks pesados.

![shell](https://img.shields.io/badge/shell-zsh-89e051?logo=gnu-bash&logoColor=white)
![terminal](https://img.shields.io/badge/terminal-kitty-9b59b6)
![prompt](https://img.shields.io/badge/prompt-starship-DD0B78?logo=starship&logoColor=white)
![theme](https://img.shields.io/badge/theme-Dracula-bd93f9)
![license](https://img.shields.io/badge/license-MIT-blue)

<img src="docs/preview.svg" alt="Vista previa de la terminal" width="720">

</div>

## ✨ Qué incluye

- **kitty** — emulador de terminal GPU con transparencia (+ blur en KDE/Wayland), tema Dracula, Nerd Font y ~47 atajos.
- **zsh** — shell interactiva sin Oh My Zsh: autosugerencias, resaltado de sintaxis, historial compartido.
- **Starship** — prompt Dracula con usuario, host, ruta, rama Git y código de error.
- **yazi** — explorador de archivos en Rust con **vista previa de imágenes** por el protocolo gráfico de kitty.
- **Herramientas modernas** — `bat` (cat), `eza` (ls), `fzf`, `fd`, `ripgrep`, `zoxide`, `duf`, `ncdu`.
- **Paleta Dracula compartida** para bat, fzf, ripgrep, eza/ls, less, Starship y btop.

## ⚡ Instalación rápida (un solo curl)

```bash
curl -fsSL https://raw.githubusercontent.com/prgr1no/terminal-dotfiles/main/bootstrap.sh | bash
```

Instala las herramientas (kitty, zsh, Starship, yazi, fzf, fd, ripgrep, bat, eza, zoxide + Hack Nerd Font) en **Ubuntu/Debian (apt)** o **Fedora (dnf)**, y copia las configuraciones. Es idempotente: puedes volver a lanzarlo sin miedo. Pedirá `sudo` para los paquetes del sistema.

> ¿Prefieres revisar antes lo que hace? Es lo razonable con cualquier `curl | bash`:
> ```bash
> curl -fsSLO https://raw.githubusercontent.com/prgr1no/terminal-dotfiles/main/bootstrap.sh
> less bootstrap.sh && bash bootstrap.sh
> ```

## 📄 Atajos

Chuleta completa de kitty, zsh y yazi en **[docs/cheatsheet.md](docs/cheatsheet.md)**.

## 📁 Estructura

```text
dotfiles/          bashrc · zshrc
config/            kitty · yazi · starship · terminal-kit · ripgrep · btop
docs/              terminal-kit.md · cheatsheet.md
bin/               install.sh
```

## 🚀 Instalación manual

Si ya tienes las herramientas y solo quieres las configuraciones:

```bash
git clone https://github.com/prgr1no/terminal-dotfiles ~/terminal-dotfiles
cd ~/terminal-dotfiles
bash bin/install.sh      # hace backup de lo existente antes de reemplazar
```

Abre una terminal nueva (o kitty) para aplicar los cambios.

## 🔧 Requisitos

Las configs esperan estas herramientas (en el sistema o en `~/.local/bin`):

| Herramienta | Para qué | Fuente |
|---|---|---|
| **kitty** | emulador de terminal | `dnf/apt install kitty` o el [instalador oficial](https://sw.kovidgoyal.net/kitty/binary/) |
| **zsh · starship · fzf · fd · ripgrep · bat · eza · zoxide** | shell y utilidades | gestor de paquetes o binarios de usuario |
| **yazi** | explorador con vista de imágenes | [sxyazi/yazi](https://github.com/sxyazi/yazi) |
| **Una Nerd Font** | iconos de eza/starship | [Nerd Fonts](https://www.nerdfonts.com/) (p. ej. Hack) |

## 🎨 Tema

**Dracula** en todo: kitty, prompt, yazi, `LS_COLORS`, fzf, bat, ripgrep y btop.

`#282a36` fondo · `#f8f8f2` texto · `#bd93f9` morado · `#50fa7b` verde · `#8be9fd` cian · `#ff79c6` rosa

## 🆘 Volver a bash

```bash
TERMINAL_KIT_DISABLE_ZSH=1 bash
```

## 📜 Licencia

[MIT](LICENSE).
