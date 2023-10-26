# (GUI) "Graphical User Interface" - Interfáz Gráfica de Usuario
- menos eficiente en términos de velocidad (requiere más recursos del sistema, Ej. RAM)
- por lo general obtenemos menos información
- el Usuario interactúa con una Ventana ó Cajas de diálogo
# (CLI) Command Line Interface - Interfáz de linea de comandos basado en texto
- más eficiente en términos de velocidad (requiere menos recursos del sistema, Ej. RAM)
- obtenemos información más precisa

1. el Usuario interactúa con una Terminal
2. la Terminal interactúa con la Shell (sh, bash, zsh, fish, ..) que tengamos por default
3. la Shell hace de intérprete (interpreta los comandos enviados por el usuario) y se lo comunica con el Sistema operativo (Linux)
# Observaciones (sobre la Terminal)
## una Consola Virtual en modo texto (TTY)
- emula una consola física, ocupa toda la pantalla, no tiene interfáz gráfica (Ej. /dev/tty1, /dev/tty2, ..)
## una Consola Virtual gráfica (terminal virtual ó PTY ó Pseudo terminal)
- son los Emuladores de Terminales (xterm, Konsole, ..) "emulan" en una ventana una terminal en modo texto
- se abre desde de un (WM) Window Manager (Ej. xfwm, mutter, ..) ó.. (DE) Desktop Environment ó  (Ej. Gnome, xfce4, KDE, ..)
- interactúa con el Display Server (Ej. el Sistema de Ventanas X, conocido por X11 ó Xorg)
