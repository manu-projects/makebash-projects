-include .config/Makefile.cfg

DOCUMENTOS=$(wildcard $(DOC_DIRECTORY)/*.$(DOC_EXTENSION))
COMANDOS= $(notdir $(patsubst %.$(DOC_EXTENSION),%,$(DOCUMENTOS)))

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install-utils:
	@pip install pygments
#	sudo apt install -y highlight

ri re-install: remove install

i install: install-utils ## Instalar aplicación
	@echo "$(BASH_ALIAS)" >> $(BASH_ALIASES) && \
	chmod u+x $(CONFIG_DIRECTORY)/update-bash-aliases && \
	$(CONFIG_DIRECTORY)/update-bash-aliases

r remove: ## Remover aplicación
	sed -i "/$(BASH_ALIAS_ESCAPE_SLASH)/d" $(BASH_ALIASES) && \
	$(CONFIG_DIRECTORY)/update-bash-aliases

c comandos: ## Lista de comandos
	@echo 'Lista de comandos'
	@$(foreach comando,$(COMANDOS), \
		echo ' -' $(comando);\
	)

# TODO: parámetros de pygmentize como macro en un archivo de configuración
$(COMANDOS):
ifeq (, $(shell which pygmentize))
	@cat $(DOC_DIRECTORY)/$@.$(DOC_EXTENSION)
else
	@pygmentize -l sh -P style=$(PYGMENTIZE_STYLE) $(DOC_DIRECTORY)/$@.$(DOC_EXTENSION)
endif

%:
	$(error NO existe el comando)

.PHONY: i install ri re-install install-utils r remove h help c comandos
