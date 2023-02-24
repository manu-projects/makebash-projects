## Recorta el tamaño de un archivo (ó bien se dice truncar un archivo)

# Limpiar el contenido del archivo, lo deja con 0 Bytes
truncate -s 0 archivo.txt

# Trunca el archivo a 100 Bytes (si era de 10Mb, entonces se perderán datos)
truncate -s 100 archivo.txt

# Aumenta el tamaño del archivo en +100k (es decir 100*1024 Bytes)
# Nota: las unidades son K,M,G,T,P y son potencias de 1024 Bytes
truncate -s +100k archivo.txt

# Reduce el tamaño del archivo en -100k
truncate -s -100k archivo.txt
