# contar cantidad de archivos/directorios
ls | wc -c

# filtrar las entradas del directorio sin usar `grep`
ls *pdf

# listar archivos ocultos
ls -la

# listar archivos ordenados por fecha de creación/actualización
ls -lt

# listar archivos ordenados por tamaño del archivo
ls -ls

# listar archivos ordenados por tamaño del archivo (en un formato más entendible)
ls -lsh

# listar los 4 archivos más recientes
ls -lth | head -n4

# listar los 2 archivos más antiguos
ls -lth | tail -n2
