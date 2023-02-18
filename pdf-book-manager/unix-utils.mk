STD_ERR=2
NULL_DEVICE=/dev/null

MKDIR=mkdir -p
LS=ls -lth --time-style=long-iso
RENAME=rename -v
RM=rm -vf
COLUMN=column -t

TAR_EXTRACT=tar -xvf
TAR_COMPRESS=tar -cvzf

ifeq ($(wildcard */*.pdf),)
NAWK_LIBROS=nawk 'BEGIN{print "\# Nombre Tamaño Fecha Hora"} {print NR, $$NF, $$5, $$6, $$7}'
else
NAWK_LIBROS=nawk 'BEGIN{print "\# Categoria Nombre Tamaño Fecha Hora"} {split($$NF, DIR, "/"); print NR, DIR[1], DIR[2], $$5, $$6, $$7}'
endif

