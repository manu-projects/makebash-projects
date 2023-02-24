-include utils/utils.mk
-include utils/unix-utils.mk
-include config.cfg

DOC_COMANDOS_LINUX = $(wildcard $(DOC_COMMANDS_LINUX_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_LINUX = $(wildcard $(DOC_SHORTCUTS_LINUX_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

DOC_COMANDOS_APPS = $(wildcard $(DOC_COMMANDS_APPS_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_APPS = $(wildcard $(DOC_SHORTCUTS_APPS_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

# Problema: no era necesario utilizar patsubst, sólo necesitabas usar la basename
COMANDOS_LINUX = $(basename $(notdir $(DOC_COMANDOS_LINUX)))
COMANDOS_APPS = $(basename $(notdir $(DOC_COMANDOS_APPS)))
COMANDOS = $(COMANDOS_LINUX) $(COMANDOS_APPS)

.DEFAULT_GOAL=help

$(DOC_LINUX).txt: $(DOC_COMANDOS_LINUX)
	@$(TRUNCATE_CLEAR_CONTENT) $@
	@$(foreach comando, $^,\
		cat $(comando) | sed -n '$(NUMBER_LINE_DESCRIPTION)p' | nawk '{print "$(basename $(notdir $(comando))) " $$0}' | sed 's/\#/\|/g' \
		>> $@;\
	)

$(DOC_APPS).txt: $(DOC_COMANDOS_APPS)
	@$(TRUNCATE_CLEAR_CONTENT) $@
	@$(foreach comando, $^,\
		cat $(comando) | sed -n '$(NUMBER_LINE_DESCRIPTION)p' | nawk '{print "$(basename $(notdir $(comando))) " $$0}' | sed 's/\#/\|/g' \
		>> $@;\
	)

##@ Acciones
l linux-commands: $(DOC_LINUX).txt ## Listado Comandos de terminal Linux
	@echo 'Lista de Comandos'
	@cat $< | $(NAWK_HEADERS)

a applications-commands: $(DOC_APPS).txt ## Listado Comandos de Aplicaciones
	@echo 'Lista de Comandos para Aplicaciones'
	@cat $< | $(NAWK_HEADERS)

# TODO: no se puede validar la existencia del archivo con el ifeq y la macro $@ porque el ifeq de GNU Make no valida en tiempo de ejecución (?)
$(COMANDOS_LINUX):
	@if [ -s $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) ]; then \
		$(BAT) $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION); \
	else \
		$(BAT) $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION); \
	fi

$(COMANDOS_APPS):
	@if [ -s $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) ]; then \
		$(BAT) $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION); \
	else \
		$(BAT) $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION); \
	fi

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

%:
	$(error NO existe el comando)

.PHONY: i install ri re-install install-utils r remove h help l linux-commands a applications-commands
