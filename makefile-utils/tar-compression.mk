-include unix-utils.mk

COMPRESSED_FILE_EXTENSION=tar.gz
BOOK_EXTENSION=pdf

libros = $(wildcard *.$(BOOK_EXTENSION))
archivos= $(wildcard *.$(COMPRESSED_FILE_EXTENSION))

%.$(COMPRESSED_FILE_EXTENSION): %.$(BOOK_EXTENSION)
	@echo "Comprimiendo $* en $@ .."
	@$(TAR_COMPRESS) $@ $<

%.$(BOOK_EXTENSION):
	$(info Extrayendo $< $*.)
	@$(TAR_EXTRACT) $*.$(COMPRESSED_FILE_EXTENSION)

comprimir-archivos: $(libros_comprimidos)
	@echo "Listo! archivos comprimidos!"

extraer-archivos: $(archivos_descomprimidos)
	@echo "Listo! archivos extraídos!"

formatear-archivos:
	@$(RENAME) 'y/A-Z _/a-z-/' *.$(BOOK_EXTENSION) && \
	$(RENAME) 's/[^a-zA-Z0-9_.-]//g' *.$(BOOK_EXTENSION)
