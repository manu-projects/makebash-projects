# TODO: ifeq no funciona como se espera con include
# https://stackoverflow.com/questions/27268450/gnu-make-ifeq-comparison-not-working
-include config.cfg
-include unix-utils.mk

.DEFAULT_GOAL=help
MAKEFILE_DEPTH=1

libros = $(wildcard *.$(BOOK_EXTENSION))
archivos= $(wildcard *.$(COMPRESSED_FILE_EXTENSION))

libros_comprimidos = $(libros:.$(BOOK_EXTENSION)=.$(COMPRESSED_FILE_EXTENSION))
archivos_descomprimidos = $(archivos:.$(COMPRESSED_FILE_EXTENSION)=.$(BOOK_EXTENSION))

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

clean-pdf-files:
	$(RM) *.$(BOOK_EXTENSION)

clean-tar-files:
	$(RM) *.$(COMPRESSED_FILE_EXTENSION)

##@ Comandos
crear-categoria: ## Ex. make crear-categoria NAME=topologias-de-red
	@$(MKDIR) $(NAME) && \
	cp .template.mk $(NAME)/Makefile

descargar: ## Ej. make descargar URL=http://ruta/archivo.pdf
	@curl -O $(URL)

listar-libros: ##
	@$(LS) *.$(BOOK_EXTENSION) */*.$(BOOK_EXTENSION) $(STD_ERR)>$(NULL_DEVICE) | \
	$(NAWK_LIBROS) | $(COLUMN)

.PHONY: h help renombrar-archivos comprimir-archivos extraer-archivos crear-categoria listar-libros
