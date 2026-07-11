# Terminal Kit

Documentacion de la terminal moderna configurada para `prgr1no`.

Ruta del repo (ejemplo):

```text
~/terminal-dotfiles
```

## Resumen

Se ha montado una experiencia de terminal basada en Zsh, Starship y estilo Dracula, ligera y sin frameworks grandes como Oh My Zsh.

La terminal queda preparada para:

- Usar Zsh como shell principal al abrir una terminal interactiva.
- Mostrar un prompt Starship estilo Dracula con usuario, maquina, ruta, rama Git y codigo de error.
- Predecir comandos mientras escribes.
- Marcar visualmente comandos validos, comandos mal escritos, rutas y aliases.
- Usar `bat` como sustituto bonito de `cat`.
- Buscar en historial y archivos con `fzf`.
- Buscar archivos con `fd`.
- Listar carpetas con `exa`.
- Saltar entre carpetas con memoria usando `zoxide`.

## Archivos modificados

- `/home/prgr1no/.bashrc`
- `/home/prgr1no/.zshrc`

Se crearon copias de seguridad automaticas con nombres similares a:

- `/home/prgr1no/.bashrc.terminal-kit.bak.YYYYMMDD-HHMMSS`
- `/home/prgr1no/.zshrc.terminal-kit.bak.YYYYMMDD-HHMMSS`

## Instalacion local

No se pudo instalar globalmente con `sudo`, porque este entorno bloquea la elevacion de permisos.

En su lugar, las herramientas se instalaron dentro del usuario:

- Binarios faciles de ejecutar: `/home/prgr1no/.local/bin`
- Paquetes descargados: `/home/prgr1no/.local/terminal-kit/packages`
- Arbol local extraido: `/home/prgr1no/.local/terminal-kit/root`

Esto evita tocar el sistema global y mantiene todo reversible desde el usuario.

## Herramientas instaladas

- `zsh`: shell principal.
- `zsh-autosuggestions`: sugerencias predictivas en gris.
- `zsh-syntax-highlighting`: colorea comandos correctos y marca errores.
- `fzf`: buscador interactivo para historial, archivos y carpetas.
- `bat`: visor de archivos con color, tema Dracula y numeros/contexto si se usa directamente.
- `fd`: busqueda de archivos mas comoda que `find`.
- `exa`: listado moderno de archivos.
- `zoxide`: salto inteligente entre carpetas.
- `starship`: prompt moderno, rapido y configurable.
- `palette.sh`: paleta compartida Terminal Kit/Dracula para unificar colores.
- `rg`: busqueda rapida de texto respetando `.gitignore`.
- `duf`: alternativa moderna a `df`.
- `ncdu`: explorador interactivo de espacio en disco.
- `nmap`: inventario y diagnostico de red autorizado.
- `traceroute`: rutas de red.
- `iperf3`: pruebas de rendimiento de red.
- `shellcheck`: analisis de scripts shell.
- `direnv`: variables de entorno por proyecto/carpeta.
- `jo`: crear JSON desde terminal.

## Comportamiento de arranque

`.bashrc` incluye un bloque llamado:

```bash
# >>> terminal-kit zsh handoff >>>
```

Ese bloque hace que una terminal Bash interactiva salte automaticamente a:

```bash
/home/prgr1no/.local/bin/zsh
```

No intercepta comandos no interactivos tipo `bash -ic '...'`, para no romper scripts ni automatizaciones.

## Interruptor de emergencia

Para abrir Bash sin saltar a Zsh:

```bash
TERMINAL_KIT_DISABLE_ZSH=1 bash
```

## Alias principales

En Zsh:

```bash
alias ls='exa --group-directories-first --icons'
alias ll='exa -la --group-directories-first --icons'
alias la='exa -a --group-directories-first --icons'
alias tree='exa --tree --level=2 --group-directories-first --icons'
alias cat='bat --paging=never'
alias less='bat'
alias search='rg --smart-case --hidden --glob "!.git/*"'
alias ports='ss -tulpn'
alias listen='ss -ltnp'
alias myip='ip -br addr'
alias routes='ip route'
alias dns='dig +short'
alias disks='duf'
alias space='ncdu'
alias json='jq'
alias json-new='jo'
```

Tambien se conservaron aliases existentes:

```bash
```

En Bash de emergencia tambien se dejo:

```bash
export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/.local/terminal-kit/root/usr/lib/x86_64-linux-gnu${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
alias cat='bat --paging=never'
```

## `bat` como `cat`

`cat` apunta a:

```bash
bat --paging=never
```

Eso significa que puedes escribir:

```bash
cat archivo.txt
```

y veras la salida con colores de `bat`, pero sin abrir paginador. Es decir, se comporta como `cat` para imprimir en pantalla.

Si quieres usar el `cat` original del sistema en algun momento:

```bash
command cat archivo.txt
```

## Atajos utiles

- `Ctrl+R`: buscar en el historial con `fzf`.
- Flecha arriba/abajo: navegar historial segun lo que ya empezaste a escribir.
- `z nombre`: saltar a una carpeta visitada antes que coincida con `nombre`.
- `mkcd carpeta`: crear carpeta y entrar en ella.
- `take carpeta`: alias funcional de `mkcd`.
- `extract archivo.zip`: extraer archivos comunes segun extension.
- `search texto`: buscar texto con `ripgrep`.
- `disks`: ver discos con `duf`.
- `space`: abrir `ncdu` para investigar uso de disco.
- `ports`: ver puertos TCP/UDP y procesos.
- `listen`: ver sockets TCP escuchando.
- `dns dominio`: consulta DNS corta con `dig +short`.

## Funciones de red y ciberseguridad defensiva

Estas funciones estan pensadas para sistemas propios o entornos donde tengas autorizacion:

```bash
scan-host <host-o-red-autorizada>
ping-sweep <red-autorizada>
web-headers <url>
cert-info <host:puerto>
```

Ejemplos:

```bash
scan-host 192.168.1.10
ping-sweep 192.168.1.0/24
web-headers https://example.com
cert-info example.com:443
```

## Tema

`bat` usa:

```bash
BAT_THEME="Dracula"
```

El prompt ahora lo gestiona Starship con configuracion en:

```text
/home/prgr1no/.config/starship.toml
```

La copia versionada vive en:

```text
~/terminal-dotfiles/config/starship/starship.toml
```

Usa colores inspirados en Dracula:

- Verde para usuario/maquina.
- Cian para ruta.
- Rosa para Git.
- Rojo para errores.
- Morado para el prompt.

## Paleta Compartida

La paleta central vive en:

```text
/home/prgr1no/.config/terminal-kit/palette.sh
```

La copia versionada vive en:

```text
~/terminal-dotfiles/config/terminal-kit/palette.sh
```

Desde ahi se coordinan:

- `BAT_THEME=Dracula`
- colores de `fzf`
- colores de `ripgrep`
- `LS_COLORS`
- `EXA_COLORS`
- tema de `btop`

Limitacion: no todas las aplicaciones leen el mismo formato. Las que soportan hex usan la paleta exacta; las que solo soportan colores ANSI usan equivalentes.

## Verificacion realizada

Se comprobo que cargan correctamente:

- Zsh `5.8.1`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `bat 0.19.0`
- `fd 8.3.1`
- `fzf 0.29`
- `exa`
- `zoxide`
- `rg`
- `duf`
- `ncdu`
- `nmap`
- `traceroute`
- `iperf3`
- `shellcheck`
- `direnv`
- `jo`

Tambien se comprobo que:

- Una terminal interactiva salta de Bash a Zsh.
- Los comandos no interactivos de Bash no quedan interceptados.
- `ll` funciona con la version de `exa` disponible.
- `cat` queda como alias de `bat --paging=never`.

## Por que no Oh My Zsh

No se instalo Oh My Zsh. La configuracion se hizo con piezas especificas y ligeras.

Motivo:

- Menos carga.
- Menos magia.
- Menos dependencias externas.
- Mas facil de entender y revertir.
- Se mantienen las funciones importantes: prediccion, resaltado, tema, historial, busqueda y calidad de vida.

## Siguiente mejora recomendada

El siguiente paso razonable seria instalar `starship` como prompt moderno.

Ventajas:

- Rapido.
- Muy configurable.
- Compatible con muchos lenguajes y herramientas.
- Facil de activar o quitar.

Se prefirio no instalarlo aun porque no estaba disponible directamente en los paquetes consultados de Ubuntu 22.04 y conviene hacerlo con una fuente clara.
