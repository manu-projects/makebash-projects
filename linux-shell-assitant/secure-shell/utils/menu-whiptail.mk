# TODO: reemplazar en otros archivos los ASK_AND_CHECK_.. por ASK_AND_SELECT
ASK_AND_SELECT_SSH_TYPE_HOSTKEY= \
	SSH_TYPE_HOSTKEY=$(MENU_ASK_SSH_TYPE_HOSTKEY); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${SSH_TYPE_HOSTKEY}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

# TODO: refactor global de AWK_FORMAT_MENU_OPTIONS por AWK_FORMAT_WHIPTAIL_MENU_OPTIONS (ó similar)
SSH_LIST_TYPE_HOSTKEYS=$(shell \
	cat $(MODULE_SECURE_SHELL_RESOURCES)/type-host-keys.lst \
	| $(AWK_WHIPTAIL_MENU_COLON_FIELDS))

# TODO: refactor global en todos Makefiles con `whiptail --menu ..`,
# las dimensiones se deben adaptar a la cantidad de elementos del archivo leído (.lst, list, ..)
MENU_ASK_SSH_TYPE_HOSTKEY=$(shell $(WHIPTAIL_COLORED) \
	--title "Algoritmos de Clave Pública en Servidores (Criptografía Asimétrica)" \
	--menu "Seleccione una opción" 20 90 8 \
	$(SSH_LIST_TYPE_HOSTKEYS) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	)

# TODO: reemplazar en otros archivos los ASK_AND_CHECK_.. por ASK_AND_SELECT
ASK_AND_SELECT_SSH_HOST_ALIAS= \
	SSH_HOST_ALIAS=$(MENU_ASK_SSH_HOST_ALIAS); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${SSH_HOST_ALIAS}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

# TODO: refactor global de AWK_FORMAT_MENU_OPTIONS por AWK_FORMAT_WHIPTAIL_MENU_OPTIONS (ó similar)
SSH_LIST_HOST_ALIAS=$(shell \
	cat  $(SSH_CLIENT_CONFIG) | \
	sed '/Host \*/d' \
	| awk '/^Host/ {print; getline; print}' \
	| sed -E 's/^Host (.*)/\1/' \
	| sed -E 's/[[:space:]]*Hostname (.*)/\1/' \
	| xargs --max-args=2 --delimiter='\n' \
	)

# TODO: refactor global en todos Makefiles con `whiptail --menu ..`,
# las dimensiones se deben adaptar a la cantidad de elementos del archivo leído (.lst, list, ..)
MENU_ASK_SSH_HOST_ALIAS=$(shell $(WHIPTAIL_COLORED) \
	--title "Listado de Hosts conocidos" \
	--menu "Seleccione una opción" 20 90 8 \
	$(SSH_LIST_HOST_ALIAS) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	)
