## CATEGORIA: operaciones con la (stdin) y (stdout)
## DESCRIPCION: a

# transformar texto a mayúsculas
echo "clojure for the brave and true.pdf" | tr 'a-z' 'A-Z' # a-z toma un rango de caracteres
echo "clojure for the brave and true.pdf" | tr '[:lower:]' '[:upper:]' # utilizamos Clases de Caracteres
echo "clojure for the brave and true.pdf" | sed -E 's/(.+)/\U\1/' # en una regex compleja haría dificil la lectura

# transformar texto a minúsculas
echo "CLOJURE for the BRAVE and true.pdf" | tr 'A-Z' 'a-z'
echo "CLOJURE for the BRAVE and true.pdf" | tr '[:upper:]' '[:lower:]'
echo "CLOJURE for the BRAVE and TRUE.pdf" | sed -E 's/(.+)/\L\1/' # en una regex compleja dificultaría la lectura

# sustituir espacios por guiones (comando tr Vs comando sed)
echo "clojure for the brave and true.pdf" | tr ' ' '-'
echo "clojure for the brave and true.pdf" | sed 's/ /-/g'

# listar los directorios de la variable de entorno PATH con saltos de linea  (comando tr Vs comando sed)
echo ${PATH} | tr ':' '\n'
echo ${PATH} | sed 's/:/\n/g'

# transformar hipervínculo de markdown a orgmode (comando tr Vs comando sed)
echo "[Guía de ORG Mode](https://orgmode.org/guide)" | tr '()' '[]' | sed -E 's/(.*)/[\1]/' # hará desastres en un archivo markdown
echo "[Guía de ORG Mode](https://orgmode.org/guide)" | sed -E 's/\((.*)\)/[\1]/; s/(.*)/[\1]/'
echo "[Guía de ORG Mode](https://orgmode.org/guide)" | sed -E 's/\[(.*)\]\((.*)\)/[[\1][\2]]/' # menos probable de fallar

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
# Nota: en una regex ^[EXP] hace de Complemento, buscamos todo lo que no coincida con EXP
echo "clojure for the brave and true.pdf" | tr --complement '[:alnum:]' '-'
echo "clojure for the brave and true.pdf" | tr -c '[:alnum:]' '-'

echo "clojure for the brave and true.pdf" | sed 's/[^[:alnum:]]/-/g'

# remover caracteres repetidos
# (Ej. nombre de archivos con exceso de guiones o espaciado)
echo "clojure--for---the-brave-and-----true.pdf" | tr --squeeze-repeats '-'
echo "clojure--for---the-brave-and-----true.pdf" | tr -s '-'

echo "clojure for    the brave   and       true.pdf" | tr --squeze-repeats '[:space:]'
echo "clojure for    the brave   and       true.pdf" | tr -s '[:space:]'
