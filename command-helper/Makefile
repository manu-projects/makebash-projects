-include utils/utils.mk
-include utils/unix-utils.mk
-include config.cfg
-include utils/menus.mk

#SHELL=/bin/bash

DOC_COMANDOS_LINUX = $(wildcard $(DOC_COMMANDS_LINUX_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_LINUX = $(wildcard $(DOC_SHORTCUTS_LINUX_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

DOC_COMANDOS_APPS = $(wildcard $(DOC_COMMANDS_APPS_DIRECTORY)/*.$(DOC_COMMANDS_EXTENSION))
DOC_SHORTCUTS_APPS = $(wildcard $(DOC_SHORTCUTS_APPS_DIRECTORY)/*.$(DOC_SHORTCUTS_EXTENSION))

COMANDOS_LINUX = $(basename $(notdir $(DOC_COMANDOS_LINUX)))
SHORTCUTS_LINUX = $(basename $(notdir $(DOC_SHORTCUTS_LINUX)))

COMANDOS_APPS = $(basename $(notdir $(DOC_COMANDOS_APPS)))
SHORTCUTS_APPS = $(basename $(notdir $(DOC_SHORTCUTS_APPS)))

COMANDOS = $(COMANDOS_LINUX) $(COMANDOS_APPS)

.DEFAULT_GOAL=help

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

##@ Listar documentación
l linux-commands: $(DOC_LINUX).txt ## Listado Comandos de terminal Linux
	@echo 'Lista de Comandos'
	@cat $< | $(SORT_BY_COLUMN) 2 | $(NAWK_ORDER_FIELDS) | $(NAWK_HEADERS)

a applications-commands: $(DOC_APPS).txt ## Listado Comandos de Aplicaciones
	@echo 'Lista de Comandos para Aplicaciones'
	@cat $< | $(SORT_BY_COLUMN) 2 | $(NAWK_ORDER_FIELDS) | $(NAWK_HEADERS)

##@ Creación y Edición de documentación

# Notas:
# 1. La opción elegida en el menú será capturada por xargs
# 2. La opción capturada será el target que pasaremos por parámetro al propio Makefile para ejecutar
# 3. Con $(MAKE) se invoca a si mismo el Makefile
# 4. El motivo del redireccionamiento se explica en el target linux-create-doc
# TODO: refactor, lógica repetida
create-doc: ## Crear documentación de Linux ó de una Aplicación
	@$(MENU_CREATE_DOC) 3>&1 1>&2 2>&3 \
	| xargs -I % $(MAKE) --no-print-directory %

edit-doc: ## Editar documentación de Linux ó de una Aplicación
	@$(MENU_EDIT_DOC) 3>&1 1>&2 2>&3 \
	| xargs -I % $(MAKE) --no-print-directory %

# TODO: refactor, lógica repetida
linux-edit-commands: $(DOC_LINUX).txt
	@$(MENU_EDIT_LINUX_COMMANDS)  3>&1 1>&2 2>&3 \
	| xargs -I % $(TEXT_EDITOR) $(DOC_COMMANDS_LINUX_DIRECTORY)/%.$(DOC_COMMANDS_EXTENSION)

linux-edit-shortcuts:
	@$(MENU_EDIT_LINUX_SHORTCUTS)  3>&1 1>&2 2>&3 \
	| xargs -I % $(TEXT_EDITOR) $(DOC_SHORTCUTS_LINUX_DIRECTORY)/%.$(DOC_SHORTCUTS_EXTENSION)

app-edit-commands:
	@$(MENU_EDIT_APPS_COMMANDS)  3>&1 1>&2 2>&3 \
	| xargs -I % $(TEXT_EDITOR) $(DOC_COMMANDS_APPS_DIRECTORY)/%.$(DOC_COMMANDS_EXTENSION)

app-edit-shortcuts:
	@$(MENU_EDIT_APPS_COMMANDS)  3>&1 1>&2 2>&3 \
	| xargs -I % $(TEXT_EDITOR) $(DOC_SHORTCUTS_APPS_DIRECTORY)/%.$(DOC_SHORTCUTS_EXTENSION)

# Notas:
# 1. el comando xargs requiere utilizarlo la forma xargs -I % sh -c 'comando1 %; comando2 %; ..'
# para pasar el mismo parámetro % a multiples comandos en la misma shell
#
# 2. el símbolo % que usamos en los nombres de los ficheros, es el parámetro capturado por el comando xargs con la opción -I
#
# 3. el comando whiptail escribe sobre stdout (fd 2) por tanto creamos un nuevo File Descriptor (3),
# que apunta al stdout (fd 1), para luego redireccionar el stdout->stderr, y redireccionar el stderr->nuevo fd 3 (que apunta al stdout)
linux-create-doc:
	@whiptail --inputbox "Escriba el nombre del comando" 25 80 --title "Crear Documentación de Linux" 3>&1 1>&2 2>&3 \
	| xargs -I % sh -c \
	"$(COPY_NOT_OVERWRITE) $(DOC_COMMANDS_LINUX_DIRECTORY)/.template $(DOC_COMMANDS_LINUX_DIRECTORY)/%.$(DOC_COMMANDS_EXTENSION); \
	$(COPY_NOT_OVERWRITE) $(DOC_SHORTCUTS_LINUX_DIRECTORY)/.template $(DOC_SHORTCUTS_LINUX_DIRECTORY)/%.$(DOC_SHORTCUTS_EXTENSION); \
	echo 'Se creó el archivo $(DOC_COMMANDS_LINUX_DIRECTORY)/%.$(DOC_COMMANDS_EXTENSION);' \
	echo 'Se creó el archivo $(DOC_SHORTCUTS_LINUX_DIRECTORY)/%.$(DOC_SHORTCUTS_EXTENSION);'"

# TODO: lógica repetida con linux-create-doc
app-create-doc:
	@whiptail --inputbox "Escriba el nombre del comando" 25 80 --title "Crear Documentación de Linux" 3>&1 1>&2 2>&3 \
	| xargs -I % sh -c \
	"$(COPY_NOT_OVERWRITE) $(DOC_COMMANDS_APPS_DIRECTORY)/.template $(DOC_COMMANDS_APPS_DIRECTORY)/%.$(DOC_COMMANDS_EXTENSION); \
	$(COPY_NOT_OVERWRITE) $(DOC_SHORTCUTS_APPS_DIRECTORY)/.template $(DOC_SHORTCUTS_APPS_DIRECTORY)/%.$(DOC_SHORTCUTS_EXTENSION); \
	echo 'Se creó el archivo $(DOC_COMMANDS_APPS_DIRECTORY)/%.$(DOC_COMMANDS_EXTENSION);' \
	echo 'Se creó el archivo$(DOC_SHORTCUTS_APPS_DIRECTORY)/%.$(DOC_SHORTCUTS_EXTENSION);'"

# TODO: lógica repetida con COMANDOS_APPS
$(COMANDOS_LINUX):
	@test -f $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	&& $(BAT) $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_LINUX_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	|| $(BAT) $(DOC_COMMANDS_LINUX_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION)

$(COMANDOS_APPS):
	@test -f $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	&& $(BAT) $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION) $(DOC_SHORTCUTS_APPS_DIRECTORY)/$@.$(DOC_SHORTCUTS_EXTENSION) \
	|| $(BAT) $(DOC_COMMANDS_APPS_DIRECTORY)/$@.$(DOC_COMMANDS_EXTENSION)

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install-utils:
ifeq ("$(shell which bat)","")
	@sudo aptitude install -y bat
endif

ri re-install: remove install

check-installed:
ifeq ($(APP_INSTALLED), true)
	$(error La aplicación ya está instalada)
endif

i install: check-installed install-utils ## Instalar aplicación
	@$(BOX_CONFIRM_INSTALL) \
	&& test $(EXIT_STATUS) -eq $(EXIT_STATUS_SUCCESS) \
	&& (echo $(BASH_ALIAS) >> $(BASH_ALIASES_FILE) \
		&& chmod u+x $(UTILS_DIRECTORY)/update-bash-aliases \
		&& $(UTILS_DIRECTORY)/update-bash-aliases) \
	|| true

r remove: ## Desinstalar aplicación
	@$(BOX_CONFIRM_UNINSTALL) \
	&& test $(EXIT_STATUS) -eq $(EXIT_STATUS_SUCCESS) \
	&& sed -i "/^alias $(BASH_ALIAS_SYMBOL)='make.*APP_AUTHOR=$(APP_AUTHOR)/d" $(BASH_ALIASES_FILE) \
	&& $(UTILS_DIRECTORY)/update-bash-aliases \
	|| true

# %:
# 	$(error NO existe el comando)

.PHONY: i install ri re-install install-utils r remove h help l linux-commands a applications-commands
