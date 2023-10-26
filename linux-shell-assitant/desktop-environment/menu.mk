DESKTOP_ENVIRONMENT_LIST=$(MODULE_DESKTOP_ENVIRONMENT_RESOURCES)/list.lst

DESKTOP_ENVIRONMENT_LIST_FORMAT=$(shell cat $(DESKTOP_ENVIRONMENT_LIST)\
	| awk '!/\#/' \
	| sed -E 's/([[:alnum:]]+): (.+)/\"\1\" \"\2\"/;' \
	| tr ';' '\n')

MENU_DESKTOP_ENVIRONMENT_SELECT=whiptail \
	--title "Entornos de Escritorio" \
	--menu "Seleccione una opción" 20 70 10 \
	$(DESKTOP_ENVIRONMENT_LIST_FORMAT)

de list-desktop-environment:
	@$(MENU_DESKTOP_ENVIRONMENT_SELECT) 2>&1 1>/dev/tty \
	| xargs -I % $(MAKE) --no-print-directory "install-%-desktop"
