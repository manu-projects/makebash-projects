## CATEGORIA: operaciones con archivos
## DESCRIPCION: leer de la (stdin) e imprimir en la (stdout) lo que escribe en archivos

# 1. Escribir en un archivo e imprimir en pantalla (escribir en STDOUT, file descriptor 1), el resultado de un comando que imprime en pantalla (STDOUT)
#
# - imprimir en pantalla es lo mismo que escribir en (STDOUT, file descriptor 1)
# - la opción --append de tee, agrega el contenido al archivo sin borrar el contenido que tuviese
ping google.com \
    | tee --append ping.txt

ping google.com \
    | tee -a ping.txt

# 2. Escribir en un archivo lo que se escribe en pantalla (STDOUT, file descriptor 1)
#
# - estamos utilizando el operador de redirección >> de la forma 1>>archivo (por default utiliza el fd 1)
# - el operador de redirección >> no imprimir por pantalla (STDOUT) lo que escribe en el archivo, pero lo hace el comando tee
ping google.com \
     >> ping.txt

ping google.com \
     1>> ping.txt

# 3. Redireccionar el resultado de un comando a un archivo y a la pantalla (STDOUT),
# y finalizar su ejecución pasado un tiempo limite
#
# - el comando timeout, envía una señal de interrupción SIGTERM para finalizar la ejecución de los comandos (ping y tee)
timeout 5s ping google.com \
    | tee -a ping.txt

# 4. Redireccionar un resultado a múltiples archivos
echo "TODO: personajes en 3d" \
    | tee --append TODO.md CHANGELOG.md

echo "TODO: sprites livianos" \
    | tee -a TODO.md CHANGELOG.md
