-include utils/utils.mk
-include config.cfg

DOC_COMANDOS_LINUX = $(wildcard $(DOC_COMMANDS_LINUX_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_LINUX = $(wildcard $(DOC_SHORTCUTS_LINUX_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

DOC_COMANDOS_APPS = $(wildcard $(DOC_COMMANDS_APPS_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_APPS = $(wildcard $(DOC_SHORTCUTS_APPS_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

# Nota: $(patsubst pattern, replacement, text)
COMANDOS_LINUX = $(notdir $(patsubst %.$(DOC_COMMANDS_EXTENSION),%,$(DOC_COMANDOS_LINUX)))
SHORTCUTS_LINUX = $(notdir $(patsubst %.$(DOC_SHORTCUTS_EXTENSION),%,$(DOC_SHORTCUTS_LINUX)))

COMANDOS_APPS = $(notdir $(patsubst %.$(DOC_COMMANDS_EXTENSION),%,$(DOC_COMANDOS_APPS)))
SHORTCUTS_APPS = $(notdir $(patsubst %.$(DOC_SHORTCUTS_EXTENSION),%,$(DOC_SHORTCUTS_APPS)))

COMANDOS = $(COMANDOS_LINUX) $(COMANDOS_APPS)

# Nota: $(filter-out pattern, text)
COMANDOS_LINUX_WITHOUT_SHORTCUTS = $(filter-out $(SHORTCUTS_LINUX),$(COMANDOS_LINUX))
COMANDOS_APPS_WITHOUT_SHORTCUTS = $(filter-out $(SHORTCUTS_APPS),$(COMANDOS_APPS))

.DEFAULT_GOAL=help

##@ Acciones
l linux-commands: ## Listado Comandos de terminal Linux
	@echo 'Lista de Comandos'
	@$(foreach comando,$(COMANDOS_LINUX_WITHOUT_SHORTCUTS), echo ' -' $(comando);)
	@echo ''
	@echo 'Comandos + Shortcuts'
	@$(foreach shortcut,$(SHORTCUTS_LINUX), echo ' -' $(shortcut);)

a applications-commands: ## Listado Comandos de Aplicaciones
	@echo 'Lista de Comandos para Aplicaciones'
	@$(foreach comando,$(COMANDOS_APPS_WITHOUT_SHORTCUTS), echo ' -' $(comando);)
	@echo ''
	@echo 'Comandos + Shortcuts'
	@$(foreach shortcut,$(SHORTCUTS_APPS), echo ' -' $(shortcut);)

# TODO: reducir código bash
# TODO: evitar lógica repetida de las ramificaciones del if-else
# TODO: no se puede validar la existencia del archivo con el ifeq y la macro $@ porque
# (interpreto ifeq no valida en tiempo de ejecución)
$(COMANDOS):
	@if [ -s $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) ]; then \
		if [ -s $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) ]; then \
			bat $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION); \
		else \
		bat $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION); \
		fi; \
	else \
		if [ -s $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) ]; then \
			bat $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION); \
		else \
		bat $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION); \
		fi; \
	fi;

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

.PHONY: i install ri re-install install-utils r remove h help l linux-commands a applications-commands listado-comandos-linux
