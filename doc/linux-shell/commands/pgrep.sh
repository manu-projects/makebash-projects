## CATEGORIA: información sobre los Procesos
## DESCRIPCION: describir comando
## NOTAS SUGERIDAS: tty-pts

# Obtener pid de un proceso (de cualquier usuario logeado)
pgrep firefox

# Listar todos los procesos de la forma (pid, nombre) asociados a una Terminal (llamadas TTY ó Consola Virtual)
#
# - útil cuando uno usuario ó diferentes usuarios se conectan al mismo Sistema a través de diferentes terminales (tty1, tty2, ...)
#
pgrep --terminal tty2 --list-name
pgrep -t tty2 -l

# Obtener de un usuario logeado, el pid de un proceso específico
pgrep --euid jelou firefox
pgrep -u jelou firefox

# Contar la cantidad de procesos de un usuario
pgrep --count --euid jelou
pgrep -c -u jelou

# Listar todos los procesos (pid, nombre) asociados a un usuario
pgrep --euid jelou --list-name
pgrep -u jelou -l

# Listar todos los procesos (pid, comando) asociados a un usuario
pgrep --euid jelou --list-full
pgrep -u jelou -a

# Listar el proceso más reciente (pid, nombre) asociado a un usuario
pgrep --euid jelou --newest --list-name
pgrep -u jelou -n -l

# Listar el proceso más antiguo (pid, nombre) asociado a un usuario
pgrep --euid jelou --oldest --list-name
pgrep -u jelou -o -l
