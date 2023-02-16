TEXT_FILE=example1.txt

MAXIMA_EXT=mac
MAXIMA_FILE=.tmp/$(subst .txt,.$(MAXIMA_EXT),$(TEXT_FILE))

TMP_DIR=.tmp
RESUELTOS_DIR=resueltos

all: formatear-texto analizar-texto

$(TMP_DIR):
	@mkdir -p $@

# alternativa, encadenar patrones de sustitución sed con ;
formatear-texto: $(TMP_DIR)
	$(info Formateando texto para Maxima)
	@cat $(TEXT_FILE) | \
	sed 's/resultado.*$$/print\(&\)/' | \
	sed 's/.?*$$/&$$/; s/=/:/' | \
	sed 's/resultado :/"resultado"\,/' \
	> $(MAXIMA_FILE)

# con la opción --very-quiet no se imprimen los simbolos de input/output %i %o
analizar-texto:
	$(info Analizando y calculando expresiones..)
	@maxima --very-quiet --batch=$(MAXIMA_FILE) | \
	sed '/batch.*$$/d' | \
	sed '/read and interpret .*$$/d' | \
	sed '/.*\.$(MAXIMA_EXT)$$/d' | \
	sed '/print.*$$/d' | \
	sed 's/resultado /resultado = /' | \
	sed '/^$$/d; s/:/ = /' \
	> $(RESUELTOS_DIR)/$(TEXT_FILE) && echo "Finalizó el análisis"

clean:
	@-rm -rvf $(RESUELTOS_DIR)/*.txt

.PHONY: all clean formatear-texto analizar-texto
