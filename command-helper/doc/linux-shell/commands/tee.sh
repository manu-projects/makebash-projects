## CATEGORIA: operaciones con archivos
## DESCRIPCION: leer de la (stdin) e imprimir en la (stdout) lo que escribe en archivos

# imprimir por la (stdout) Salida Estandar el resultado que redirecciona de un comando a un archivo
# (lo agrega sin borrar el contenido actual del archivo)
ping google.com | tee --append ping.txt
ping google.com | tee -a ping.txt

# redireccionar el resultado de un comando, sin imprimir el resultado por pantalla (stdout, standard output)
ping google.com >> ping.txt

# idem pero asignamos un tiempo límite de 5 segundos,
# luego envía una señal de interrupción SIGTERM para finalizar la ejecución de los comandos (ping y tee)
timeout 5s ping google.com | tee -a ping.txt

# redireccionar un resultado a múltiples archivos
echo "TODO: personajes en 3d" | tee --append TODO.md TODO.md
echo "TODO: sprites livianos" | tee -a TODO.md CHANGELOG.md
