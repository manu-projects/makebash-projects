-include utils/utils.mk
-include utils/unix-utils.mk
-include config.cfg

#SHELL=/bin/bash

DOC_COMANDOS_LINUX = $(wildcard $(DOC_COMMANDS_LINUX_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_LINUX = $(wildcard $(DOC_SHORTCUTS_LINUX_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

DOC_COMANDOS_APPS = $(wildcard $(DOC_COMMANDS_APPS_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_APPS = $(wildcard $(DOC_SHORTCUTS_APPS_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

COMANDOS_LINUX = $(basename $(notdir $(DOC_COMANDOS_LINUX)))
COMANDOS_APPS = $(basename $(notdir $(DOC_COMANDOS_APPS)))
COMANDOS = $(COMANDOS_LINUX) $(COMANDOS_APPS)

.DEFAULT_GOAL=help

$(eval edit:;@:)

# TODO: refactor, definir una función de Makefile que reciba por parámetro el nombre de target y las dependencias
$(DOC_LINUX).txt: $(DOC_COMANDOS_LINUX)
	@$(TRUNCATE_CLEAR_CONTENT) $@
	@$(foreach comando, $^,\
		cat $(comando) | \
		sed -n '$(CONTENT_NUMBER_LINE_CATEGORY),$(CONTENT_NUMBER_LINE_DESCRIPTION)p' | \
		nawk 'BEGIN{print "$(basename $(notdir $(comando)))|" } {print $$0}' | \
		sed -E 's/^\#\# ($(CONTENT_TAG_CATEGORY))\: (([[:alnum:]]|[[:space:]]|[[:punct:]])+)$$/\2\|/g' | \
		sed -E 's/^\#\# ($(CONTENT_TAG_DESCRIPTION))\: (([[:alnum:]]|[[:space:]]|[[:punct:]])+)$$/\2;/g' | \
		tr --delete '\n' | tr ';' '\n' \
		>> $@;\
	)

# TODO: refactor, definir una función de Makefile que reciba por parámetro el nombre de target y las dependencias
$(DOC_APPS).txt: $(DOC_COMANDOS_APPS)
	@$(TRUNCATE_CLEAR_CONTENT) $@
	@$(foreach comando, $^,\
		cat $(comando) | \
		sed -n '$(CONTENT_NUMBER_LINE_CATEGORY),$(CONTENT_NUMBER_LINE_DESCRIPTION)p' | \
		nawk 'BEGIN{print "$(basename $(notdir $(comando)))|" } {print $$0}' | \
		sed -E 's/^\#\# ($(CONTENT_TAG_CATEGORY))\: (([[:alnum:]]|[[:space:]]|[[:punct:]])+)$$/\2\|/g' | \
		sed -E 's/^\#\# ($(CONTENT_TAG_DESCRIPTION))\: (([[:alnum:]]|[[:space:]]|[[:punct:]])+)$$/\2;/g' | \
		tr --delete '\n' | tr ';' '\n' \
		>> $@;\
	)

##@ Acciones
l linux-commands: $(DOC_LINUX).txt ## Listado Comandos de terminal Linux
	@echo 'Lista de Comandos'
	@cat $< | $(SORT_BY_COLUMN) 2 | $(NAWK_ORDER_FIELDS) | $(NAWK_HEADERS)

a applications-commands: $(DOC_APPS).txt ## Listado Comandos de Aplicaciones
	@echo 'Lista de Comandos para Aplicaciones'
	@cat $< | $(SORT_BY_COLUMN) 2 | $(NAWK_ORDER_FIELDS) | $(NAWK_HEADERS)

# Notas:
# - comando TEST para validar existencia de archivos.. test -f archivo.txt && echo "existe" || echo "no existe"
# - no se puede validar la existencia del archivo con el ifeq + wildcard + la macro $@ porque.. ifeq de GNU Make no valida en tiempo de ejecución
#.ONESHELL:
$(COMANDOS_LINUX):
# 1. validamos si pasó el parámetro "edit"
ifeq (edit, $(filter edit,$(MAKECMDGOALS)))
# 1.1 confirmamos que tipo de modificación se desea, ejecutamos un sh y pasamos por parámetro las rutas del archivo .sh y .org
# (delegamos la responsabilidad en un .sh por la complejidad de evaluar y expandir macros con comandos de shell de éste tipo y comparar con el ifeq de GNU Make)
	@$(POPUP_EDIT) \
	$(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) \
	$(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION)
# 1.2 flujo alternativo, si no pasó el parámetro "edit" entonces imprimimos los comandos ó shortcuts
# (en las notas describimos como funciona el comando TEST)
else
	@test -f $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	&& $(BAT) $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	|| $(BAT) $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION)
endif

$(COMANDOS_APPS):
#1. validamos si pasó el parámetro "edit"
ifeq (edit, $(filter edit,$(MAKECMDGOALS)))
# 1.1 confirmamos que tipo de modificación se desea, ejecutamos un sh y pasamos por parámetro las rutas del archivo .sh y .org
	@$(POPUP_EDIT) \
	$(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) \
	$(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION)
# 1.2 flujo alternativo, si no pasó el parámetro "edit" entonces imprimimos los comandos ó shortcuts
# (en las notas describimos como funciona el comando TEST)
else
	@test -f $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	&& $(BAT) $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	|| $(BAT) $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION)
endif

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

# %:
# 	$(error NO existe el comando)

.PHONY: i install ri re-install install-utils r remove h help l linux-commands a applications-commands
