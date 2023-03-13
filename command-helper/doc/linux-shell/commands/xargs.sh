## CATEGORIA: clasificar comando
## DESCRIPCION: describir comando

# imprimir por pantalla el comando y el parámetro que recibió de xargs
echo "libros" | xargs --verbose mkdir
echo "libros" | xargs -t mkdir

# pasar un parámetro a varios comandos
echo "libros" | xargs -I % sh -c "mkdir %; touch %"

# buscar archivos por su extensión y moverlos a otra ruta
find ./documentos -type f -name "*.txt" | xargs --verbose -I % mv % ./backup
