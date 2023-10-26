GPG_KEYLIST_SEPARATOR=sed -E 's/^(pub|sec) /======================================================================\npub/'

# TODO: `find $$HOME -type f | fzf` no permitía acceder a directorios en el raíz (/)
# es más eficiente si ya conocés la ruta dónde buscar, porque desde $$HOME existen demasiados archivos
#
#FIND_GPG_DECRYPTED_FILE=$(FIND_FILES_HOME_DIR) \
#	| $(FUZZY_FINDER) \
#		--header=$$'Ingrese la ruta absoluta del archivo (Ej. /tmp/secrets-decrypted.txt)\n\n' \
#		--prompt 'Archivo a encriptar> ' \

GPG_DEFAULT_KEYSERVER=cat $(MODULE_CRYPTO_RESOURCES)/pgp-public-key-servers.lst \
	| sed '/^\# /d' \
	| awk '/^default/' \
	| cut --delimiter="," --fields=2 \
	| tr -d ' '

# TODO: refactor global de AWK_FORMAT_MENU_OPTIONS por AWK_FORMAT_WHIPTAIL_MENU_OPTIONS (ó similar)
GPG_LIST_PGP_PUBKEY_SERVERS=$(shell \
	cat $(MODULE_CRYPTO_RESOURCES)/pgp-public-key-servers.lst \
	| $(AWK_FORMAT_LST_FILES) \
	| cut --delimiter="," --fields=2,3 \
	| $(AWK_WHIPTAIL_MENU_COMMA_FIELDS))

GPG_DEFAULT_KEYSERVER=cat $(MODULE_CRYPTO_RESOURCES)/pgp-public-key-servers.lst \
	| $(AWK_FORMAT_LST_FILES) \
	| awk '/^default/' \
	| cut --delimiter="," --fields=2
