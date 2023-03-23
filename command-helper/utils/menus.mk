# TODO: refactor, lógica repetida
BOX_CONFIRM_INSTALL=whiptail \
	--title "Instalar Aplicación $(APP_NAME)" \
	--yesno "¿Desea confirmar acción?" 0 0 \
	--no-button "Cancelar" --yes-button "Confirmar"

BOX_CONFIRM_UNINSTALL=whiptail \
	--title "Desinstalar Aplicación $(APP_NAME)" \
	--yesno "¿Está seguro de confirmar acción?" 0 0 \
	--no-button "Cancelar" --yes-button "Confirmar"

MENU_SHOW_NOTES=whiptail \
	--title "Mostrar documentación en Notas" \
	--menu "Elegir una opción" 0 0 5 $(NOTES_LIST)

# TODO: refactor, lógica repetida
MENU_EDIT_LINUX_COMMANDS=whiptail \
	--title "Editar documentación de Linux" \
	--menu "Elegir una opción" 0 0 5 $(LINUX_COMMANDS_LIST)

MENU_EDIT_LINUX_SHORTCUTS=whiptail \
	--title "Editar documentación de Linux" \
	--menu "Elegir una opción" 0 0 5 $(LINUX_SHORTCUTS_LIST)

MENU_EDIT_APPS_COMMANDS=whiptail \
	--title "Editar documentación de una Aplicación" \
	--menu "Elegir una opción" 0 0 5 $(APPS_COMMANDS_LIST)

MENU_EDIT_APPS_SHORTCUTS=whiptail \
	--title "Editar documentación de una Aplicación" \
	--menu "Elegir una opción" 0 0 5 $(APPS_SHORTCUTS_LIST)

MENU_CREATE_DOC=whiptail --title "Crear documentación" \
								--menu "Elegir una opción" 30 80 5 \
								"linux-create-doc" "Documentación de Linux" \
								"app-create-doc" "Documentación de una Aplicación"

MENU_EDIT_DOC=whiptail --title "Editar documentación" \
	--menu "Elegir una opción" 30 80 5 \
	"linux-edit-commands" "Comandos de Linux" \
	"linux-edit-shortcuts" "Shortcuts de Linux" \
	"app-edit-commands" "Comandos de una Aplicación" \
	"app-edit-shortcuts" "Shortcutsde una Aplicación"

# Notas:
# 1. Ojo! Si usamos ésta MACRO como una orden de una regla, no encontrará los targets en el Makefile para crearlos
# 2. Usarla para pasarla de parámetro a algún comando de linux
# TODO: refactor, lógica repetida
SHORTCUTS_LINUX_FORMAT=$(shell echo $(SHORTCUTS_LINUX) | sed -E 's/([[:alpha:]]+) /\1|/g')
SHORTCUTS_APPS_FORMAT=$(shell echo $(SHORTCUTS_APPS) | sed -E 's/([[:alpha:]]+) /\1|/g')

# TODO: refactor, lógica repetida
LINUX_COMMANDS_LIST=$(shell cat $(DOC_LINUX).txt \
	| nawk -F '|' '{print $$1 "::" $$2}' \
	| sed -E 's/(.+)::(.+)/"\1" "\2" \\/g' \
	| tr '\\' '\n')

# Notas:
# 1. Si usamos el operador != en vez de la función $(shell ) no cumplirá su propósito el slash invertido
# 2. En véz de borrar lineas con el comando sed y su opción /d, se prefirió filtrar filas con awk que también permite patrones (más fácil)
LINUX_SHORTCUTS_LIST=$(shell cat $(DOC_LINUX).txt \
	| awk -F '|' '{print $$1 "::" $$2}' \
	| sed -E 's/([[:alpha:]]+)::(.+)/\"\1\" \"\2\"\\/g' \
	| awk '/$(SHORTCUTS_LINUX_FORMAT)/' \
	| tr '\\' '\n')

APPS_COMMANDS_LIST=$(shell cat $(DOC_APPS).txt \
	| nawk -F '|' '{print $$1 "::" $$2}' \
	| sed -E 's/(.+)::(.+)/"\1" "\2" \\/g'\
	| tr '\\' '\n')

APPS_SHORTCUTS_LIST=$(shell cat $(DOC_APPS).txt \
	| awk -F '|' '{print $$1 "::" $$2}' \
	| sed -E 's/([[:alpha:]]+)::(.+)/\"\1\" \"\2\"\\/g' \
	| awk '/$(SHORTCUTS_APPS_FORMAT)/' \
	| tr '\\' '\n')

NOTES_LIST=$(shell cat $(DOC_NOTES).txt \
	| nawk -F '|' '{print $$1 "::" $$2}' \
	| sed -E 's/(.+)::(.+)/"\1" "\2" \\/g' \
	| tr '\\' '\n')
