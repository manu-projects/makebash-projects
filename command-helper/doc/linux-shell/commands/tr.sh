## CATEGORIA: operaciones con archivos
## DESCRIPCION: -

# transformar todo el texto a mayúsculas
echo "clojure for the brave and true.pdf" | tr 'a-z' 'A-Z'
echo "clojure for the brave and true.pdf" | tr '[:lower:]' '[:upper:]'
echo "clojure for the brave and true.pdf" | sed -E 's/(.+)/\U\1/' # en una regex compleja dificultaría la lectura

# transformar todo el texto a minúsculas
echo "CLOJURE for the BRAVE and true.pdf" | tr 'A-Z' 'a-z'
echo "CLOJURE for the BRAVE and true.pdf" | tr '[:upper:]' '[:lower:]'
echo "CLOJURE for the BRAVE and TRUE.pdf" | sed -E 's/(.+)/\L\1/' # en una regex compleja dificultaría la lectura

# sustituir espacios por guiones (comando tr Vs comando sed)
echo "clojure for the brave and true.pdf" | tr ' ' '-'
echo "clojure for the brave and true.pdf" | sed 's/ /-/g'

# sustituir las vocales (comando tr Vs comando sed)
echo "clojure for the brave and true.pdf" | tr 'aeiou' 'x'
echo "clojure for the brave and true.pdf" | sed 's/[aeiou]/x/g'

# sustituir distintos caracteres.. (comando tr Vs comando sed)
# (Ej. los espacios por guiones, las mayúsculas por minúsculas)
echo "CLOJURE for the BRAVE and TRUE.pdf" | tr ' [A-Z]' '-[a-z]' # más entendible
echo "CLOJURE for the BRAVE and TRUE.pdf" | sed -E 's/[[:space:]]/\-/g; s/(.+)/\L\1/'

# sustituir palabras diferentes..
# Nota: el comando tr opera sobre caracteres no sobre strings, el comando sed sería el más adecuado para esta tarea
echo "clojure for the brave and true.pdf"  | sed 's/clojure/javascript/g; s/brave/false/g'

# eliminar espacios en blanco (comando tr Vs comando sed)
echo "clojure for the brave and true.pdf" | tr --delete ' '
echo "clojure for the brave and true.pdf" | tr -d ' '

echo "clojure for the brave and true.pdf" | sed 's/ //g'
echo "clojure for the brave and true.pdf" | sed 's/[[:space:]]//g'

# remover todos los caracteres que NO sean legibles
# Nota: el [:print:] del comando sed no es tan eficiente para éste objetivo, NO logra el mismo resultado
head -n1 /dev/urandom | tr --complement --delete '[:print:]\n'
head -n1 /dev/urandom | tr -cd '[:print:]\n'

# sustituir cualquier caracter que no sea alfanumérico (comando tr Vs comando sed)
# Nota: en una regex ^[expresion] hace de complemento, por tanto sustituimos todo lo que no sea esa expresion
echo "clojure for the brave and true.pdf" | tr --complement '[:alnum:]' '-'
echo "clojure for the brave and true.pdf" | tr -c '[:alnum:]' '-'

echo "clojure for the brave and true.pdf" | sed 's/[^[:alnum:]]/-/g'

# remover caracteres repetidos
# (Ej. nombre de archivos con exceso de guiones o espaciado)
echo "clojure--for---the-brave-and-----true.pdf" | tr --squeeze-repeats '-'
echo "clojure--for---the-brave-and-----true.pdf" | tr -s '-'

echo "clojure for    the brave   and       true.pdf" | tr --squeze-repeats '[:space:]'
echo "clojure for    the brave   and       true.pdf" | tr -s '[:space:]'
