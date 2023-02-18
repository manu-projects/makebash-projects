# TODO: ifeq no funciona como se espera con include
# https://stackoverflow.com/questions/27268450/gnu-make-ifeq-comparison-not-working
-include config.cfg
-include unix-utils.mk

.DEFAULT_GOAL=help
MAKEFILE_DEPTH=1

libros = $(wildcard *.$(BOOK_EXTENSION))
archivos= $(wildcard *.$(COMPRESSED_FILE_EXTENSION))

# Nota:
# - Alternativa de sustitución con la función patsubst por ejemplo $(patsubst %.pdf, %.tar.gz, $(libros))
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

# Notas:
# 1. Para listar archivos con misma extensión de múltiples directorios podemos usar el comando ls pasandole ambas rutas
# por ejemplo ls ruta/*.extension otra-ruta/*.extension
#
# 2. Si el comando ls no encuentra el archivo ó patrón pasado por parámetro, lanzará un mensaje al file descriptor 2 STDERR
# 3. Ocutamos los mensajes de error de ls, redireccionando los mensajes que el comando ls envía al fd 2 stderr al dispositivo nulo /dev/null
# con el operador de redirección > por ejemplo ls /pupi 2>/dev/null
listar-libros: ##
	@$(LS) *.$(BOOK_EXTENSION) */*.$(BOOK_EXTENSION) $(STD_ERR)>$(NULL_DEVICE) | \
	$(NAWK_LIBROS) | $(COLUMN)

.PHONY: h help renombrar-archivos comprimir-archivos extraer-archivos crear-categoria listar-libros
