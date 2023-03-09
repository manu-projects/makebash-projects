CURRENT_DIRECTORY=$(shell pwd)

BASH_ALIASES=~/.bash_aliases
# TODO: contemplar cambio de nombre del directorio
BASH_ALIAS=alias ?='make --no-print-directory -C $(CURRENT_DIRECTORY)'
BASH_ALIAS_ESCAPE_SLASH=$(subst /,\/,$(BASH_ALIAS))

POPUP_EDIT = sh ./scripts/edit-popup.sh $(TEXT_EDITOR)

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
