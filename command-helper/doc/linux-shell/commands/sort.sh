## CATEGORIA: operaciones con archivos
## DESCRIPCION: ordenar archivos de texto (útil si tienen un formato csv ó similar)

# Ejemplos para rellenar un archivo con datos y probar el siguiente comando sort
# truncate --size=0 alumnos.txt && seq 10 | xargs -I{} echo "alumno {}" >> alumnos.txt
# cat /dev/null > alumnos.txt && i=1; while [[ $i -le 10 ]]; do echo "alumno $i" >> alumnos.txt; let i++; done
# echo -n "" > alumnos.txt && i=1; while (( $i < 10+1 )); do echo "alumno $i" >> alumnos.txt; ((i++)); done
#
# ordenar un archivo por la segunda columna (numérica) de forma descendente
sort alumnos.txt --key=2 --numeric-sort
sort alumnos.txt -k 2 -n
sort alumnos.txt -nk 2

# Ejemplos para rellenar un archivo con datos y probar el siguiente comando sort
# truncate --size=0 alumnos.txt && seq 10 | xargs -I{} echo "pepe | argentino | {}" >> alumnos.txt && sed -i '1,2 s/a/c/; 3,5 s/a/z/; 6,8 s/a/c/' alumnos.txt
#
# ordenar un archivo por la segunda columna y que tiene el símbolo | pipe como delimitador (separador de campos)
sort alumnos.txt --field-separator "|" --key=2
sort alumnos.txt -t "|" -k 2
sort alumnos.txt -k 2

# Ejemplo para rellenar el archivo con datos y probar el siguiente comando sort
# echo -n "" > nombres-duplicados.txt && timeout 5 bash -c 'while true; do echo "escribiendo.."; echo "carlos" >> nombres-duplicados.txt ; sleep 1; done;'
#
# remover las lineas repetidas
sort --unique nombres-duplicados.txt > nombres-sin-repetir.txt
sort -u nombres-duplicados.txt > nombres-sin-repetir.txt
