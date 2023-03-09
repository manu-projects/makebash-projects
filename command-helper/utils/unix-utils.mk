BAT=bat --line-range $(NUMBER_LINE_BEGIN_DOCUMENTATION):

NAWK_HEADERS=nawk 'BEGIN{print "Comando | Categoría | Descripción"} {print $$0}' | column -t -s "|"

# en GNU Make debemos escapar el $ que utiliza awk para los parámetros por eso $$1 $$2 en vez de $1 ó $2,
# para que lo tome como un caracter y no lo tome una referencia a una macro de GNU Make
NAWK_ORDER_FIELDS=nawk -F '|' '{print $$1 " | " tolower($$2) " | " toupper(substr($$3,1,1)) substr($$3,2)}'

TRUNCATE_CLEAR_CONTENT=truncate -s 0

# luego es utilizado al listar los comandos por la segunda columna (categoria)
# Ej. cat comandos.txt | sort -t "|" -k 2
SORT_BY_COLUMN = sort -t "|" -k

COPY_NOT_OVERWRITE=rsync --ignore-existing
# alternativa al rsync --ignore-existing es cp --no-clobber
