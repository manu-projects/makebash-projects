## CATEGORIA: clasificar comando
## DESCRIPCION: describir comando

# imprimir por pantalla el comando y el parámetro que recibió de xargs
echo "libros" | xargs --verbose mkdir
echo "libros" | xargs -t mkdir

# pasar un parámetro a varios comandos
# - la opción -I de xargs, permite asignarle un símbolo al parámetro redireccionado por el operador pipe a xargs
echo "libros" | xargs -I % sh -c "mkdir %; touch %"

# buscar archivos por su extensión y moverlos a otra ruta
# - la opción --verbose de xargs, hará que se imprima (utilizando el comando echo) varias operaciones mv (de cada archivo que encontró el comando find)
find ./documentos -type f -name "*.txt" | xargs --verbose -I % mv % ./backup
