GENERATE_PASSWORD_LENGTH=20

ASK_PASS_CATEGORY_NAME=read -p "Escriba el nombre de la categoría (Ej. university, work, ..): "
ASK_PASS_COMPANY_NAME=read -p "Escriba de la empresa (Ej. gmail, hotmail, ..): "
ASK_PASS_KEYWORD =read -p "Escriba de la palabra clave a buscar (Ej. gmail, work, ..): "

# - usamos los apóstrofes `` porque lo utilizamos con el operador <<< también podríamos haber usado $$()
# Ej. ssh-add - <<< "$(PASS_ASK_GITHUB_PRIVKEY)"
PASS_ASK_GITHUB_PRIVKEY=`pass $${CATEGORY_NAME}/github/ssh-privkey`

# TODO: refactor de las rutas, algo más genérico
# TODO: refactor global de AWK_FORMAT_MENU_OPTIONS por AWK_FORMAT_WHIPTAIL_MENU_OPTIONS (ó similar)
PASS_LIST_CATEGORIES=$(shell \
	cat $(MODULE_APPS_CLI)/password-manager/resources/pass-categories.lst \
	| $(AWK_WHIPTAIL_MENU_COLON_FIELDS)\
	)

PASS_LIST_COMPANIES=$(shell \
	cat $(MODULE_APPS_CLI)/password-manager/resources/pass-companies.lst \
	| $(AWK_WHIPTAIL_MENU_COLON_FIELDS)\
	)

MENU_ASK_PASS_CATEGORY=$(shell $(WHIPTAIL_COLORED) \
	--title "My Password Manager - Elegir Categoría" \
	--menu "Seleccione una opción" 10 50 3 \
	$(PASS_LIST_CATEGORIES) \
	2>&1 1>/dev/tty \
	)

MENU_ASK_PASS_COMPANY=$(shell $(WHIPTAIL_COLORED) \
	--title "My Password Manager - Elegir Companía" \
	--menu "Seleccione una opción" 10 50 3 \
	$(PASS_LIST_COMPANIES) \
	2>&1 1>/dev/tty \
	)

# TODO: refactor de la variable de bash que tiene asignada el comando sed,
# (no podemos invocar a nuestra función definida con GNU Make,
# y asignar su valor a una variable de bash)
#
# TODO: lanzar una excepción más descriptiva que el `exit 1`
# no tratar a ASK_PASS como una macro de GNU Make, es una variable de entorno de (bash) Bourne Again Bash
MENU_ASK_PASS= CATEGORY_NAME=$(MENU_ASK_PASS_CATEGORY); COMPANY_NAME=$(MENU_ASK_PASS_COMPANY);\
	[[ -z "$${CATEGORY_NAME}" || -z "$${COMPANY_NAME}" ]] && exit 1 || \
	ASK_PASS="$${CATEGORY_NAME}/$${COMPANY_NAME}"; \
	ASK_PASS_ESCAPING_SLASH=$$(sed 's/\//\\\//g' <<< $${ASK_PASS})
#	ASK_PASS_ESCAPING_SLASH=$(call SED_ESCAPING_SLASH,$${ASK_PASS})

pass-init:
	$(ASK_AND_CHECK_GPG_SUBKEY_ENCRYPT_ID) \
	&& pass init $${GPG_SUBKEY_ENCRYPT_ID}

# TODO: es necesario? `pass insert` ya se crean los directorios
# (quizás no está mal la idea, pero que sólo lo agregue en mi archivo .lst con un operador de redirección >)
#pass-add-category:
#	$(ASK_PASS_CATEGORY_NAME) PASS_CATEGORY_NAME \
#	&& pass init --path=$${PASS_CATEGORY_NAME}

# format: pass insert {store}/{company}/{environment}/{username or email}
# TODO: modificar todas las instancias dónde usemos $${ASK_PASS}
# sustituir por $${PASS} ó similar (también modificar la macro)
pass-add-password:
	$(MENU_ASK_PASS) \
	&& pass insert $${ASK_PASS}

# TODO: boxes avisando que la clave generada se copiará en el clipboard por 45 segundos
# (la opción --clip hace que no se imprima por pantalla la clave generada, pero la guarda en el clipboard)
pass-generate-random-password:
	$(MENU_ASK_PASS) \
	&& pass generate --clip $${ASK_PASS} $(GENERATE_PASSWORD_LENGTH)
#	pass generate --clip $(MENU_ASK_PASS_CATEGORY)/$(MENU_ASK_PASS_COMPANY) $(GENERATE_PASSWORD_LENGTH)

# TODO: boxes avisando que pedirá la clave de gpg
pass-show-password:
	$(MENU_ASK_PASS) \
	&& pass show $${ASK_PASS}
#	pass show $(MENU_ASK_PASS_CATEGORY)/$(MENU_ASK_PASS_COMPANY)

pass-copy-password-to-clipboard:
	$(MENU_ASK_PASS) \
	&& pass --clip $${ASK_PASS}
#	pass --clip $(MENU_ASK_PASS_CATEGORY)/$(MENU_ASK_PASS_COMPANY)

pass-remove-password:
	$(MENU_ASK_PASS) \
	&& pass rm $${ASK_PASS}
#	pass rm $(MENU_ASK_PASS_CATEGORY)/$(MENU_ASK_PASS_COMPANY)

pass-list-passwords:
	pass ls

pass-find-password-by-keyword:
	$(ASK_PASS_KEYWORD) PASS_KEYWORD \
	&& pass find $${PASS_KEYWORD}

# TUT
# =========

# TODO: documentar
# usamos --ignore-existing para evitar actualizar el backup
tut-backup-config:
	rsync --ignore-existing --verbose --progress --human-readable \
	$${HOME}/$(TUT_CONFIG_ACCOUNTS){,.default} \

# TODO: documentar
# buscamos en todo el proyecto, el archivo de configuración del programa tut
tut-copy-config: tut-backup-config
	find . \
	-type f \
	-path '*$(TUT_CONFIG_ACCOUNTS)' \
	-exec rsync --verbose --progress --human-readable {} $${HOME}/$(TUT_CONFIG_ACCOUNTS) \;

pass-tut-update-passwords: tut-copy-config pass-tut-import-clientId pass-tut-import-clientSecret pass-tut-import-accessToken

# existe lógica repetida, pero no es necesario un refactor (por el momento)
pass-tut-import-clientId:
	cat $(TUT_CONFIG_ACCOUNTS) | awk '/ClientID/' \
	| tr -d " '" | cut --delimiter='=' --fields=2 \
	| pass insert --multiline personal/tut/client-id

pass-tut-import-clientSecret:
	cat $(TUT_CONFIG_ACCOUNTS) | awk '/ClientSecret/' \
	| tr -d " '" | cut --delimiter='=' --fields=2 \
	| pass insert --multiline personal/tut/client-secret

pass-tut-import-accessToken:
	cat $(TUT_CONFIG_ACCOUNTS) | awk '/AccessToken/' \
	| tr -d " '" | cut --delimiter='=' --fields=2 \
	| pass insert --multiline personal/tut/access-token

# TODO: lanzar una excepción más descriptiva que el `exit 1`
# TODO: caja de diálogo preguntando si quiere cambiar la ruta por defecto de la clave privada ~/ssh
pass-github-import-privateKey:
	CATEGORY_NAME=$(MENU_ASK_PASS_CATEGORY); \
	[[ -z "$${CATEGORY_NAME}" ]] && exit 1 \
	|| $(ASK_SSH_PRIVATE_KEY_NAME) SSH_PRIVATE_KEY_NAME \
	&& cat $(SSH_PAIR_KEY_DIR)/$${SSH_PRIVATE_KEY_NAME} \
	| pass insert --multiline $${CATEGORY_NAME}/github/ssh-privkey

# TODO:
# pass-delete-all-categories:

# TODO: posibilidad de mostrar en la caja de diálogo de whiptail, sólo las categorías que existan
# TODO: lanzar una excepción más descriptiva que el `exit 1`
pass-delete-category:
	CATEGORY_NAME=$(MENU_ASK_PASS_CATEGORY); \
	[[ -z "$${CATEGORY_NAME}" ]] && exit 1 \
	|| pass rm --recursive $${CATEGORY_NAME}

