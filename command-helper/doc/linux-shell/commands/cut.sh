## CATEGORIA: clasificar comando
## DESCRIPCION: describir comando

# Listar el nombre de usuario de las cuentas del sistema que tengan la Shell Bash por default
#
# - la opción --fields de cut, indicamos que columnas queremos imprimir separadas por comas (en este ej. sólo la primera)
# - la opción --delimiter, indicamos el símbolo que delimita las columnas del archivo a mostrar (en este caso los :)
# - comando grep, filtramos las lineas del archivo que incluya ese string
grep "/bin/bash" /etc/passwd | cut --delimiter=':' --fields=1
grep "/bin/bash" /etc/passwd | cut -d ':' -f 1

# lo mismo que antes, pero.. si queremos mostrar columnas específicas
grep "/bin/bash" /etc/passwd | cut --delimiter=':' --fields=1,2,5,6

# Listar las cuentas del sistema que tengan la Shell Bash por default
#
# - la opcion --fields de cut, permite un rango de columnas (en este ejemplo desde la columna 1 hasta la 6)
grep "/bin/bash" /etc/passwd | cut --delimiter=':' --fields=1-6
grep "/bin/bash" /etc/passwd | cut -d ':' -f 1-6

# Reemplazar el delimitador de columna
grep "/bin/bash" /etc/passwd | cut --delimiter=':' --fields=1-6 --output-delimiter=','

# Mostrar los 10 comandos más utilizados (en la sesión de la terminal activa)
#
# - la opción --characters=8, selecciona el caracter en la posición 8
# - la opción --characters=1,2,3,4, selecciona el caracter de las posiciones 1,2,3,4
# - la opción --characters=1-8, selecciona el caracter desde la posición 1 hasta la posición 8
# - la opción (elegida) --characters=8-, selecciona el caracter desde la posición 8 en adelante (no necesitamos indicar la posición del último char)
#
# - uniq reporta lineas repetidas de un archivo, mostrándolas sólo una vez (suponiendo que están ordenadas Ej. con el comando sort)
# - la opción --count de uniq, agrega el número de veces que se repite cada linea
history | cut --characters=8- | sort | uniq --count | sort --numeric-sort --reverse | head --lines=10
history | cut -c 8- | sort | uniq -c | sort -rn | head
