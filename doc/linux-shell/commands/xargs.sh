## CATEGORIA: clasificar comando
## DESCRIPCION: describir comando

# Imprimir por pantalla el comando y el parámetro que recibió de xargs
echo "libros" | xargs --verbose mkdir
echo "libros" | xargs -t mkdir

# Pasar un parámetro a varios comandos
#
# - la opción -I de xargs, permite asignarle un símbolo al parámetro redireccionado por el operador pipe a xargs
echo "libros" | xargs -I % sh -c "mkdir %; touch %"

# Buscar archivos por su extensión y moverlos a otra ruta
#
# - la opción --verbose de xargs, hará que se imprima (utilizando el comando echo) varias operaciones mv (de cada archivo que encontró el comando find)
find ./documentos -type f -name "*.txt" \
    | xargs --verbose -I % mv % ./backup

# alternativas para copiar todos los archivos de texto plano a otro directorio
cp --verbose documentos/*.txt backup
rsync --verbose documentos/*.txt backup
