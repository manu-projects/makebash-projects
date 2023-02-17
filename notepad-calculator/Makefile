-include config.cfg

.DEFAULT_GOAL=help

TMP_DIR=.tmp

TEXT_FILES=$(wildcard *.$(TEXT_EXT))
TEXT_FILES_RESUELTOS=$(addprefix $(RESUELTOS_DIR)/,$(TEXT_FILES))

MAXIMA_FILES=$(TEXT_FILES:.$(TEXT_EXT)=.$(MAXIMA_EXT))
MAXIMA_FILES_TMP=$(addprefix $(TMP_DIR)/, $(MAXIMA_FILES))

##@ Comandos
resolver-archivos: formatear-textos analizar-textos ## Formatea y analiza todos los textos
	@echo "Archivos resueltos!"

# Notas:
# 1. las columnas que imprime la función PRINT del comando AWK sólo necesitan un símbolo $ como prefijo
# 2. en GNU Make necesitamos escapar el $ con otro $ delante quedando $$ para que lo tome como caracter en vez de una macro
lista-archivos-resueltos: ##
ifeq ("$(wildcard $(RESUELTOS_DIR)/*.$(TEXT_EXT))", "")
	@echo "No hay archivos resueltos.."
else
	@ls -lth --time-style=long-iso $(RESUELTOS_DIR)/*.$(TEXT_EXT) | \
	nawk 'BEGIN{print "# Nombre Tamaño Fecha Hora"} {print NR, $$NF, $$5, $$6, $$7}' | \
	column -t
endif

$(TMP_DIR):
	@mkdir -p $@

# Breve explicación sobre como usamos el comando sed con la operación de sustitución
#
# 1. Removemos los espacios en blanco
# sed -E 's/[[:space:]]//g'
#
# 2. formateamos el texto para Maxima
# 2.1 reemplazando los = por :
# 2.2 considerando las variables como la primer palabra de cada linea y que pueden incluir el símbolo _
# 2.3 considerando que las operaciones con apertura de paréntesis
#	sed -E 's/^(([[:alnum:]]|\_)+)\=((([[:alnum:]]|\()+[[:punct:]]*[[:alnum:]]*)+)/\1 : \3;/g' \
#
# Notas:
# 1. éste target hace la conversión %.txt en %.mac
# 2. alternativa para acortar el código, encadenar patrones de sustitución sed con ;
$(TMP_DIR)/%.$(MAXIMA_EXT): %.$(TEXT_EXT)
	$(info Formateando $< para Maxima..)
	@cat $< | \
	sed -E 's/[[:space:]]//g' | \
	sed -E 's/^(([[:alnum:]]|\_)+)\=((([[:alnum:]]|\()+[[:punct:]]*[[:alnum:]]*)+)/\1 : \3;/g' \
	> $@


# Breve explicación sobre como usamos el comando sed con la operación de sustitución
#
# 1. Removemos mensajes de Maxima
#	sed '/batch.*$$/d; /read and interpret .*$$/d; /.*\.$(MAXIMA_EXT)$$/d'
#
# 2. Removemos los espacios en blanco
# sed -E 's/[[:space:]]//g'
#
# 3. Formateamos el texto que entiende Maxima por algo más común
# 3.1 reemplazando los : por =
# 3.2 y las mismas consideraciones que en la conversión de %.mac a %.txt
# sed -E 's/\(\%i.{1,3}\)([[:alnum:]]+)\:(([[:alnum:]]+[[:punct:]]*)*)(\n)/\1 = /g'
#
# 4. Capturamos los resultados, removiendo (%o) y el espacio en blanco, capturar sólo el resultado a la derecha
#	sed -E 's/\(\%o.{1,3}\)([0-9]*)/\1/g'
#
# 5. Removemos cualquier linea en blanco por la conversión
#	sed -E '/^[[:space:]]*$$/d'
#
# Notas:
# 1. éste target hace la conversión %.mac en %.txt
# 2. con la opción --very-quiet no se imprimen los simbolos de input/output %i %o pero justamente los necesitamos
$(RESUELTOS_DIR)/%.$(TEXT_EXT): $(TMP_DIR)/%.$(MAXIMA_EXT)
	$(info Analizando $< con Maxima..)
	@maxima --quiet --batch=$< | \
	sed '/batch.*$$/d; /read and interpret .*$$/d; /.*\.$(MAXIMA_EXT)$$/d' | \
	sed -E 's/[[:space:]]//g' | \
	sed -E -z 's/\(\%i.{1,3}\)(([[:alnum:]]|\_)+)\:(([[:alnum:]]+[[:punct:]]*)*)(\n)/\1 = /g' | \
	sed -E 's/\(\%o.{1,3}\)([0-9]*)/\1/g' | \
	sed -E '/^[[:space:]]*$$/d' \
	> $@ && echo "Finalizó el análisis de $<"

formatear-textos: $(TMP_DIR) $(MAXIMA_FILES_TMP)
	@echo "Textos formateados!"

analizar-textos: $(TEXT_FILES_RESUELTOS)
	@echo "Textos analizados!"

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

clean: ## Remover archivos resueltos
	@-rm -rvf $(RESUELTOS_DIR)/*.$(TEXT_EXT)
	@-rm -rf $(TMP_DIR)/*.$(MAXIMA_EXT)

.PHONY: run clean formatear-textos analizar-textos resolver-archivos lista-archivos-resueltos
