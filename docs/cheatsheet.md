# 🐱 Cheatsheet — Terminal (kitty + zsh + yazi)

Entorno: **kitty + zsh + starship (Dracula) + yazi**

> En kitty, `mod` = **Ctrl+Shift**. Recargar config de kitty en caliente: **Ctrl+Shift+F5**.

---

## 🪟 kitty — ventanas, pestañas y navegación

| Atajo | Acción |
|-------|--------|
| `mod + Enter` | Nueva ventana (split) en el directorio actual |
| `mod + W` | Cerrar ventana (split) |
| `mod + ]` / `mod + [` | Ventana siguiente / anterior |
| `mod + F` / `mod + B` | Mover ventana adelante / atrás |
| `Ctrl+Alt + ← ↑ ↓ →` | Saltar a la ventana en esa dirección |
| `mod + R` | Modo redimensionar ventana |
| `mod + L` | Cambiar de layout (splits/stack/tall/fat/grid) |
| `mod + T` | Nueva pestaña en el directorio actual |
| `mod + Q` | Cerrar pestaña |
| `mod + ← ` / `mod + →` | Pestaña anterior / siguiente |
| `mod + ,` / `mod + .` | Mover pestaña |
| `mod + Alt + T` | Renombrar pestaña |
| `mod + N` | Nueva ventana del sistema (nueva ventana de kitty) |

## ⌨️ kitty — texto, scroll y utilidades

| Atajo | Acción |
|-------|--------|
| `mod + C` / `mod + V` | Copiar / pegar |
| `mod + K` / `mod + J` | Subir / bajar una línea |
| `mod + RePág` / `mod + AvPág` | Subir / bajar una página |
| `mod + Inicio` / `mod + Fin` | Ir arriba / abajo del scrollback |
| `mod + H` | Abrir el scrollback en el pager (less con colores) |
| `mod + =` / `mod + -` | Aumentar / reducir tamaño de fuente |
| `mod + 0` | Restablecer tamaño de fuente |
| `mod + U` | Insertar carácter Unicode (emoji, símbolos) |
| `mod + Supr` | Limpiar y resetear la terminal |
| `mod + F2` | Editar `kitty.conf` |
| `mod + F5` | Recargar la config |
| `mod + F6` | Volcar la config efectiva (debug) |

## 🌫️ kitty — transparencia en vivo

Pulsa `mod + A` y luego:

| Tecla | Acción |
|-------|--------|
| `M` | Más opaco (+0.05) |
| `L` | Más transparente (−0.05) |
| `1` | Opaco total |
| `D` | Valor por defecto (0.88) |

## 🔗 kitty — "hints" (URLs, rutas, líneas)

| Atajo | Acción |
|-------|--------|
| `mod + E` | Marcar y abrir una URL de la pantalla |
| `mod + P` luego `F` | Copiar una ruta de fichero |
| `mod + P` luego `L` | Copiar una línea |
| `mod + P` luego `H` | Copiar un hash (git, sha…) |
| `mod + P` luego `N` | Copiar número de línea |

---

## 🗂️ yazi — explorador de archivos

Ábrelo con **`y`** (al salir te deja en la carpeta navegada) o **`fm`** / **`explorer`**.

| Tecla | Acción |
|-------|--------|
| `h j k l` / flechas | Navegar (izq/abajo/arriba/entrar) |
| `Enter` / `l` | Abrir fichero / entrar en carpeta |
| `gg` / `G` | Ir al principio / final |
| `q` | Salir (y `cd` a la carpeta actual con `y`) · `Q` sale sin `cd` |
| `Espacio` | Seleccionar / deseleccionar |
| `v` | Modo selección visual |
| `y` / `x` / `p` | Copiar / cortar / pegar |
| `d` / `D` | Enviar a papelera / borrar permanente |
| `a` / `r` | Crear fichero-carpeta / renombrar |
| `.` | Mostrar / ocultar ficheros ocultos |
| `/` · `n` / `N` | Buscar · siguiente / anterior |
| `s` | Buscar por contenido (rg) · `f` filtrar |
| `t` · `1`…`9` | Nueva pestaña · cambiar de pestaña |
| `z` / `Z` | Saltar con zoxide / fzf |
| `~` | Ayuda (todas las teclas) |

> 🖼️ **Imágenes, PDF y vídeo se previsualizan solos** en el panel derecho (protocolo gráfico de kitty).

## 🖼️ Ver imágenes en la terminal

| Comando | Acción |
|---------|--------|
| `icat foto.png` | Muestra la imagen dentro de la terminal |
| `img foto.png` | Igual que `icat` |

---

## 🐚 zsh — alias y funciones (terminal-kit)

### Listado y ficheros
| Alias | Equivale a |
|-------|-----------|
| `ls` / `ll` / `la` | `exa` con iconos (normal / detallado / con ocultos) |
| `tree` | `exa --tree --level=2` |
| `cat` | `bat` (con colores, sin paginar) |
| `less` | `bat` |
| `search <txt>` | `rg --smart-case --hidden` |

### Red y sistema
| Alias | Acción |
|-------|--------|
| `myip` | IPs de las interfaces (`ip -br addr`) |
| `routes` / `dns <host>` | Rutas / resolución DNS |
| `ports` / `listen` | Puertos abiertos / a la escucha (`ss`) |
| `disks` / `space` | Uso de discos (`duf`) / uso por carpetas (`ncdu`) |
| `json` / `json-new` | `jq` / `jo` |
| `please` | Repite el último comando con `sudo` |
| `path` | Muestra el `PATH`, una ruta por línea |

### Funciones
| Función | Acción |
|---------|--------|
| `mkcd <dir>` / `take <dir>` | Crea la carpeta y entra en ella |
| `extract <fichero>` | Descomprime cualquier formato (zip, tar.gz, 7z…) |
| `scan-host <host>` | `nmap -sV` (top 1000 puertos) *(uso autorizado)* |
| `ping-sweep <red>` | `nmap -sn` sobre una red *(uso autorizado)* |
| `web-headers <url>` | Cabeceras HTTP (`curl -I -L`) |
| `cert-info <host:puerto>` | Datos del certificado TLS |

### Navegación rápida
| Comando | Acción |
|---------|--------|
| `z <parte-del-nombre>` | Salta a una carpeta frecuente (zoxide) |
| `zi` | Selector interactivo de zoxide |
| `Ctrl + T` | Buscar ficheros con fzf |
| `Ctrl + R` | Buscar en el historial con fzf |
| `Alt + C` | Cambiar de carpeta con fzf |

---

## ✨ Prompt (starship, tema Dracula)

```
usuario@host  ~/ruta  git:rama [estado]  took 2s
>
```

Símbolos de estado git: `*` modificado · `+` en stage · `?` sin seguimiento · `x` borrado · `>` adelantado · `<` atrasado · `!` conflicto.
El `>` de la última línea es morado si el comando anterior fue bien, y rojo (`x`) si falló.

