ASK_GPG_PASSPHRASE= \
	GPG_PASSPHRASE=$(shell $(WHIPTAIL_COLORED) \
		--passwordbox "Ingrese la frase de paso (para la clave privada)" 10 100 \
		$(WHIPTAIL_REDIRECT_STDERR) \
	)

# TODO: lanzar una excepción más descriptiva que el `exit 1`
ASK_AND_CHECK_GPG_SYMMETRIC_ALGORITHM= \
	GPG_SYMMETRIC_ALGORITHM=$(MENU_ASK_GPG_SYMMETRIC_ALGORITHM); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${GPG_SYMMETRIC_ALGORITHM}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

ASK_AND_CHECK_GPG_ASYMMETRIC_ALGORITHM= \
	GPG_ASYMMETRIC_ALGORITHM=$(MENU_ASK_GPG_ASYMMETRIC_ALGORITHM); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${GPG_ASYMMETRIC_ALGORITHM}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

# TODO: lanzar una excepción más descriptiva que el `exit 1`
ASK_AND_CHECK_GPG_DIGEST_HASH_ALGORITHM= \
	GPG_DIGEST_HASH_ALGORITHM=$(MENU_ASK_GPG_DIGEST_HASH_ALGORITHM); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${GPG_DIGEST_HASH_ALGORITHM}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

ASK_AND_CHECK_GPG_KEY_CAPABILITIES= \
	GPG_KEY_CAPABILITIES=$(CHECKLIST_ASK_GPG_KEY_CAPABILITIES); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${GPG_KEY_CAPABILITIES}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

ASK_AND_CHECK_GPG_SUBKEY_CAPABILITIES= \
	GPG_SUBKEY_CAPABILITIES=$(MENU_ASK_GPG_SUBKEY_CAPABILITIES); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${GPG_SUBKEY_CAPABILITIES}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

# TODO: lanzar una excepción más descriptiva que el `exit 1`
ASK_AND_CHECK_GPG_PUBKEY_SERVER= \
	GPG_PUBKEY_SERVER_URL=$(MENU_ASK_GPG_PUBKEY_SERVER); \
	[[ $(BASH_CHECK_EMPTY_STRING) "$${GPG_PUBKEY_SERVER_URL}" ]] \
		&& exit 1 \
		|| $(ECHO_NOTHING)

MENU_ASK_GPG_PUBKEY_SERVER=$(shell $(WHIPTAIL_COLORED) \
	--title "Servidores de Clave Pública PGP - Elegir Servidor" \
	--menu "Seleccione una opción" 20 90 8 \
	$(GPG_LIST_PGP_PUBKEY_SERVERS) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	)

# TODO: refactor global de AWK_FORMAT_MENU_OPTIONS por AWK_FORMAT_WHIPTAIL_MENU_OPTIONS (ó similar)
GPG_LIST_SYMMETRIC_ALGORITHMS=$(shell \
	cat $(MODULE_CRYPTO_RESOURCES)/symmetric-algorithms.lst \
	| $(AWK_WHIPTAIL_MENU_COLON_FIELDS))

GPG_LIST_ASYMMETRIC_ALGORITHMS=$(shell \
	cat $(MODULE_CRYPTO_RESOURCES)/asymmetric-algorithms.lst \
	| $(AWK_WHIPTAIL_MENU_COLON_FIELDS))

GPG_LIST_DIGEST_HASH_ALGORITHMS=$(shell \
	cat $(MODULE_CRYPTO_RESOURCES)/digest-hash-algorithms.lst \
	| $(AWK_WHIPTAIL_MENU_COLON_FIELDS))

GPG_LIST_KEY_CAPABILITIES=$(shell \
	cat $(MODULE_CRYPTO_RESOURCES)/primary-key-capabilities.lst \
	| $(AWK_WHIPTAIL_CHECKLIST_COLON_FIELDS))

GPG_LIST_SUBKEY_CAPABILITIES=$(shell \
	cat $(MODULE_CRYPTO_RESOURCES)/subkey-capabilities.lst \
	| $(AWK_WHIPTAIL_MENU_COLON_FIELDS))

# comando `whiptail`
# ==================
#
# opciones
# --------
# --menu 		los parámetros obligatorios son TEXT HEIGHT WIDTH MENU-HEIGHT
#
# TODO: refactor global en todos Makefiles con `whiptail --menu ..`,
# las dimensiones se deben adaptar a la cantidad de elementos del archivo leído (.lst, list, ..)
MENU_ASK_GPG_SYMMETRIC_ALGORITHM=$(shell $(WHIPTAIL_COLORED) \
	--title "Algoritmos Cifrado en bloque con clave secreta (Criptografía Simétrica)" \
	--menu "Seleccione una opción" 20 90 8 \
	$(GPG_LIST_SYMMETRIC_ALGORITHMS) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	)

MENU_ASK_GPG_ASYMMETRIC_ALGORITHM=$(shell $(WHIPTAIL_COLORED) \
	--title "Algoritmos Cifrado en bloque con clave pública (Criptografía Asimétrica)" \
	--menu "Seleccione una opción" 20 130 5 \
	$(GPG_LIST_ASYMMETRIC_ALGORITHMS) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	)

MENU_ASK_GPG_DIGEST_HASH_ALGORITHM=$(shell $(WHIPTAIL_COLORED) \
	--title "Algoritmos de Hash (Digest Algorithms)" \
	--menu "Seleccione una opción" 20 110 8 \
	$(GPG_LIST_DIGEST_HASH_ALGORITHMS) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	)

MENU_ASK_GPG_SUBKEY_CAPABILITIES=$(shell $(WHIPTAIL_COLORED) \
	--title "Funcionalidades para Claves Secundarias (Subkey Capabilities)" \
	--menu "Seleccione una opción" 20 110 8 \
	$(GPG_LIST_SUBKEY_CAPABILITIES) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	)

CHECKLIST_ASK_GPG_KEY_CAPABILITIES=$(shell whiptail \
	--title "Funcionalidades para Claves Primaria (Primary key Capabilities)" \
	--checklist "Seleccione una opción" 20 110 2 \
	$(GPG_LIST_KEY_CAPABILITIES) \
	$(WHIPTAIL_REDIRECT_STDERR) \
	| $(FORMAT_WHIPTAIL_CHECKLIST_RESULT) \
	)

