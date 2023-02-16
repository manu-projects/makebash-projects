-include Makefile.cfg

.DEFAULT_GOAL=help

TMP_DIR=.tmp

TEXT_FILES=$(wildcard *.$(TEXT_EXT))
TEXT_FILES_RESUELTOS=$(addprefix $(RESUELTOS_DIR)/,$(TEXT_FILES))

MAXIMA_FILES=$(TEXT_FILES:.txt=.mac)
MAXIMA_FILES_TMP=$(addprefix $(TMP_DIR)/, $(MAXIMA_FILES))

##@ Comandos
run: formatear-textos analizar-textos ## Formatea y analiza todos los textos

$(TMP_DIR):
	@mkdir -p $@

# alternativa, encadenar patrones de sustitución sed con ;
$(TMP_DIR)/%.$(MAXIMA_EXT): %.$(TEXT_EXT)
	$(info Formateando $< para Maxima..)
	@cat $< | \
	sed 's/resultado.*$$/print\(&\)/' | \
	sed 's/.?*$$/&$$/; s/=/:/' | \
	sed 's/resultado :/"resultado"\,/' \
	> $@

# con la opción --very-quiet no se imprimen los simbolos de input/output %i %o
$(RESUELTOS_DIR)/%.$(TEXT_EXT): $(TMP_DIR)/%.$(MAXIMA_EXT)
	$(info Analizando $< con Maxima..)
	@maxima --very-quiet --batch=$< | \
	sed '/batch.*$$/d' | \
	sed '/read and interpret .*$$/d' | \
	sed '/.*\.$(MAXIMA_EXT)$$/d' | \
	sed '/print.*$$/d' | \
	sed 's/resultado /resultado = /' | \
	sed '/^$$/d; s/:/ = /' \
	> $@ && echo "Finalizó el análisis de $<"


formatear-textos: $(TMP_DIR) $(MAXIMA_FILES_TMP)
	@echo "Textos formateados"

analizar-textos: $(TEXT_FILES_RESUELTOS)
	@echo "Textos analizados"

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

clean: ## Remover archivos resueltos
	@-rm -rvf $(RESUELTOS_DIR)/*.$(TEXT_EXT)
	@-rm -rf $(TMP_DIR)/*.$(MAXIMA_EXT)

.PHONY: run clean formatear-textos analizar-textos
