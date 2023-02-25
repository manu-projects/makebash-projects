## CATEGORIA: archivador
## DESCRIPCION: comprimir/descomprimir archivos y directorios

# extraer archivos en la ruta actual
# - (x) extract : extraer
# - (v) verbose: describe los pasos de forma verbosa
# - (f) file: especificar el archivo
tar -xvf videos-humor.tar
tar -xvf videos-humor.tar.gz

# extraer archivos en una ruta específica
tar -xvf videos-humor.tar.gz -C ~/Videos/

# comprimir archivo
# - (c): create: crear archivo
tar -cvf videos-humor.tar ~/Videos/humor

# comprimir archivo con formato gzip
# (z): gzip: comprimir con gzip
tar -cvzf videos-humor.tar.gz ~/Videos/humor

# filtrar archivos y no incluir los archivos con extensión .mp3
tar -cvzf videos-humor.tar.gz ~/Videos/humor --exclude=*.mp3

# listar archivos
tar -tf videos-humor.tar

# listar archivos con detalles
tar -tvf videos-humor.tar
