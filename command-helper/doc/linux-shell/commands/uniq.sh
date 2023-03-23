## CATEGORIA: clasificar comando
## DESCRIPCION: describir comando

# Mostrar los 5 mensajes del syslog que más se repitan, y la cantidad de veces que se repiten
cut --characters=17- /var/log/syslog | sort | uniq --count | sort --numeric-sort --reverse | head --lines=5

# Ejecutar las siguientes tres lineas, para generar un archivo de ejemplo y practicar el comando uniq
truncate --size 0 syslog-alumnos.txt
seq 5 | xargs -I {} sh -c 'echo "$(date +%T), alumno 00{}, online";' | tee --append syslog-alumnos.txt
seq 5 | xargs -I {} sh -c 'echo "$(date +%T), alumno 00{}, online"; sleep 1;' | tee --append syslog-alumnos.txt

# Contar la cantidad de veces que se repite una linea + mostrar cada linea una única vez
#
# - comando sort opción --key=2, ordenamos por la 2º columna
# - es necesario previo a usar uniq, ordenar si las lineas del archivo si sabemos que NO está ordenado por algún criterio
# - opción --count, agrega un prefijo con el número de veces que se repita
sort --key=2 syslog-alumnos.txt | uniq --count
sort -k 2 syslog-alumnos.txt | uniq -c

# Mostrar columnas específicas de un archivo delimitado por el símbolo coma + contar las veces que se repiten las lineas
# (previo a usar uniq -c, ordenamos por la 1º columna caso contrario no agrupará correctamente)
cut alumnos.txt --delimiter=',' --fields=2,3 | sort --key=1 | uniq --count
cut alumnos.txt -d ',' -f 2,3 | sort -k 1 | uniq -c

# Mostrar las lineas que se repiten (1 vez) y las que NO se repiten
sort syslog-alumnos.txt | uniq

# Mostrar las lineas que se repiten (1 vez) y las que NO se repiten
# PERO.. ignorar las mayúsculas y minúsculas al comparar entre las lineas
sort syslog-alumnos.txt | uniq --ignore-case
sort syslog-alumnos.txt | uniq -i

# Mostrar las lineas que se repiten (1 vez) y las que NO se repiten,
# PERO ignorar la 2º columna al comparar entre lineas repetidas
sort syslog-alumnos.txt | uniq --skip-fields=2
sort syslog-alumnos.txt | uniq -f 2

# Mostrar sólo las lineas que NO se repiten
# - comando sort opción --key=1, ordenamos por la 1º columna (es necesario si sabemos que el archivo no está ordenado)
sort --key=1 syslog-alumnos.txt | uniq --unique
sort -k 1 syslog-alumnos.txt | uniq -u

# Mostrar sólo las lineas que se repiten
sort --key=1 syslog-alumnos.txt | uniq --repeated
sort -k 1 syslog-alumnos.txt | uniq -d
