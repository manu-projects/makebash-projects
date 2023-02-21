-include utils/utils.mk
-include config.cfg

DOC_COMANDOS = $(wildcard $(DOC_DIRECTORY)/$(DOC_COMMANDS_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))

# Nota: $(patsubst pattern, replacement, text)
COMANDOS= $(notdir $(patsubst %.$(DOC_COMMANDS_EXTENSION),%,$(DOC_COMANDOS)))

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install-utils:
	@sudo aptitude install -y bat

ri re-install: remove install

i install: install-utils ## Instalar aplicación
	@echo "$(BASH_ALIAS)" >> $(BASH_ALIASES) && \
	chmod u+x $(UTILS_DIRECTORY)/update-bash-aliases && \
	$(UTILS_DIRECTORY)/update-bash-aliases

# TODO: chequear patrón de sustitución
r remove: ## Remover aplicación
	sed -i "/$(BASH_ALIAS_ESCAPE_SLASH)/d" $(BASH_ALIASES) && \
	$(UTILS_DIRECTORY)/update-bash-aliases

c comandos: ## Lista de comandos
	@echo 'Lista de comandos'
	@$(foreach comando,$(COMANDOS), \
		echo ' -' $(comando);\
	)

$(COMANDOS):
	@bat $(DOC_DIRECTORY)/$(DOC_COMMANDS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION)

%:
	$(error NO existe el comando)

.PHONY: i install ri re-install install-utils r remove h help c comandos
