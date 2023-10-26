PRINT_EXAMPLE_KEY_FILES=echo "clave (Ej. mypublic.key, myprivate.key, ..)"
PRINT_EXAMPLE_ASCII_KEY_FILES=echo "clave formato ascii (Ej. mykey.key.asc, mykey.key, ..)"

PRINT_EXAMPLE_REVOCATION_CERTIFICATE_FILES=echo "certificado de revocación de clave pública (Ej. certificado.rev, certificado.asc, ..)"

PRINT_EXAMPLE_SIGNED_FILES=echo "archivo firmado (Ej. clientes.txt.asc, manual.txt.sig, ..)"
PRINT_EXAMPLE_UNSIGNED_FILES=echo "archivo a firmar (Ej. clientes.txt, manual.pdf, ..)"
PRINT_EXAMPLE_SIGNATURES=echo "firma digital (Ej. clientes.txt.asc, manual.txt.sig, ..)"
PRINT_EXAMPLE_ENCRYPTED_FILES=echo "archivo encriptado (Ej. secretos.txt.gpg, secretos.txt.asc, ..)"

# TODO: validar si los estoy usando
EXAMPLE_DECRYPTED_FILES="(Ej. /tmp/secret-encrypted.txt)"
EXAMPLE_ENCRYPTED_FILES="(Ej. /tmp/secret-encrypted.gpg, /tmp/secret-encrypted.asc)"
EXAMPLE_ENCRYPTED_FILES_ASCII_FORMAT="(Ej. /tmp/secret-encrypted.asc)"
EXAMPLE_ENCRYPTED_FILES_BINARY_FORMAT="(Ej. /tmp/secret-encrypted.gpg)"

# https://www.gnupg.org/documentation/manuals/gnupg/Specify-a-User-ID.html
# https://confluence.atlassian.com/bitbucketserver/using-gpg-keys-913477014.html

ASK_GPG_EXPIRATION_DATE=read -p 'Escriba la cantidad de años (Ej. 1y, 2y, ..): ' GPG_EXPIRATION_DATE
ASK_GPG_UID_NAME=read -p "Escriba su apodo (ó nombre y apellido): " GPG_UID_NAME
ASK_GPG_UID_EMAIL=read -p "Escriba su email: " GPG_UID_EMAIL
GPG_UID="$${GPG_UID_NAME} <$${GPG_UID_EMAIL}>"

# TODO: boxes educativo, en algunas opciones de GPG (Ej. send-keys) NO podemos usar el email como ID
# ASK_GPG_UID_KEY=read -p " > ingrese el ID de la Clave Pública: "

ADVICE_GPG_KEY_ID="escribir el símbolo '?' sin las comillas, si desea ver su Anillo de Claves"

# TODO: deprecar, es necesario definir privada/pública
# (quedó en gpg-pair-key.mk con los certificados de revocación)
ASK_GPG_KEY_ID=read -p " > ingrese el ID de su Clave: " GPG_KEY_ID

ASK_GPG_PRIVATE_KEY_ID=read -p " > ingrese el ID de su Clave Privada: " GPG_PRIVATE_KEY_ID
ASK_GPG_PUBLIC_KEY_ID=read -p " > ingrese el ID de la Clave Pública: " GPG_PUBLIC_KEY_ID

ASK_GPG_SUBKEY_ENCRYPT_ID=read -p " > ingrese el ID de la Clave Secundaria que Encripte/Desencripte: " GPG_SUBKEY_ENCRYPT_ID

# TODO: terminar de documentar la forma en que utilizás el condicional de bash [[ predicado ]]
#
# 1. si el predicado se cumple asociar con una rama-if, se ejecutan las expresiones con el operador &&
# 2. si el predicado no se cumple asociar con una rama-else, se ejecuta la expresión con el operador ||
# 	- decidimos no imprimir nada en la rama-else con `echo -n ""`
# 	- si en el condicional de bash [[ ]] no se define la rama-else, su Estado de Salida $? será 1 que significa error
#		y no se terminará de evaluar el target de Makefile
CHECK_GPG_PUBLIC_KEY_ID= \
	[[ $${GPG_PUBLIC_KEY_ID} == '?' ]] \
	&& $(MAKE) --no-print-directory gpg-list-public-keys && $(ASK_GPG_PUBLIC_KEY_ID) \
	|| $(ECHO_NOTHING)

CHECK_GPG_PRIVATE_KEY_ID= \
	[[ $${GPG_PRIVATE_KEY_ID} == '?' ]] \
	&& $(MAKE) --no-print-directory gpg-list-private-keys && $(ASK_GPG_PRIVATE_KEY_ID) \
	|| $(ECHO_NOTHING)

# TODO: lógica repetida con pubkey, privatekey
CHECK_GPG_SUBKEY_ENCRYPT_ID= \
	[[ $${GPG_SUBKEY_ENCRYPT_ID} == '?' ]] \
	&& $(MAKE) --no-print-directory gpg-list-public-keys && $(ASK_GPG_SUBKEY_ENCRYPT_ID) \
	|| $(ECHO_NOTHING)

# - nos referimos al Par de Claves (pública/privada)
ASK_AND_CHECK_GPG_PUBLIC_KEY_ID=$(NOTES_GPG_KEY_ID) \
	&& echo $(ADVICE_GPG_KEY_ID) \
	&& $(ASK_GPG_PUBLIC_KEY_ID) \
	&& $(CHECK_GPG_PUBLIC_KEY_ID)

ASK_AND_CHECK_GPG_PRIVATE_KEY_ID=$(NOTES_GPG_KEY_ID) \
	&& echo $(ADVICE_GPG_KEY_ID) \
	&& $(ASK_GPG_PRIVATE_KEY_ID) \
	&& $(CHECK_GPG_PRIVATE_KEY_ID)

# TODO: lógica repetida con pubkey, privatekey
ASK_AND_CHECK_GPG_SUBKEY_ENCRYPT_ID= \
	echo $(ADVICE_GPG_KEY_ID) \
	&& $(ASK_GPG_SUBKEY_ENCRYPT_ID) \
	&& $(CHECK_GPG_SUBKEY_ENCRYPT_ID)

# TODO: documentar sobre las nuevas opciones del comando `read`
# https://linuxcommand.org/lc3_man_pages/readh.html
# https://stackoverflow.com/questions/2642585/read-a-variable-in-bash-with-a-default-value
#       -e	use Readline to obtain the line
#       -i text	use TEXT as the initial text for Readline
#				-p prompt	output the string PROMPT without a trailing newline before attempting to read
#
# TODO: boxes educativo, en todos las referencias a $(ASK_GPG_PRIVATE_KEY_ID)
# advirtiendo que NO se debe compartir, y si se exporta que sea solo como copia de respaldo + su Certificado de Revocación..
# ASK_GPG_PRIVATE_KEY_ID=$(ADVICE_GPG_PRIVKEY_ID) && read -p " > ingrese el ID de la Clave Privada: "
# ASK_GPG_SERVER_PUBLIC_KEY=read -p " > ingrese la dirección del servidor de claves públicas: "
ASK_GPG_SERVER_PUBLIC_KEY=read \
	-e -p " > ingrese la dirección del servidor de claves públicas: " \
	-i `$(GPG_DEFAULT_KEYSERVER)` \
	GPG_SERVER_PUBLIC_KEY

ASK_FILE_PATH=ingrese la ruta absoluta del archivo

# TODO: refactor, lógica repetida ?
ASK_GPG_FILE=read -p " > $(ASK_FILE_PATH): " GPG_FILE

ASK_GPG_REVOCATION_CERTIFICATE_FILE=read -p " > $(ASK_FILE_PATH): " GPG_REVOCATION_CERTIFICATE_FILE

# TODO: evaluar si se siguen usando, si no borrar..
ASK_GPG_ENCRYPTED_FILE_BINARY_FORMAT=read -p " > $(ASK_FILE_PATH): "
ASK_GPG_ENCRYPTED_FILE_ASCII_FORMAT=read -p " > $(ASK_FILE_PATH): "

ASK_GPG_EXPORT_KEY_FILE=read -p " > $(ASK_FILE_PATH) de la Clave a exportar: " GPG_EXPORT_KEY_FILE

ASK_GPG_IMPORT_KEY_FILE=read -p " > $(ASK_FILE_PATH) de la Clave a importar: " GPG_IMPORT_KEY_FILE
ASK_GPG_IMPORT_PUBLIC_KEY_FILE=read -p " > $(ASK_FILE_PATH) de la Clave Pública a importar: " GPG_IMPORT_PUBLIC_KEY_FILE
ASK_GPG_IMPORT_PRIVATE_KEY_FILE=read -p " > $(ASK_FILE_PATH) de la Clave Privada a importar: " GPG_IMPORT_PRIVATE_KEY_FILE

ASK_GPG_ENCRYPTED_FILE=read -p " > $(ASK_FILE_PATH) encriptado: " GPG_ENCRYPTED_FILE
ASK_GPG_DECRYPTED_FILE=read -p " > $(ASK_FILE_PATH) desencriptado: " GPG_DECRYPTED_FILE

ASK_GPG_UNSIGNED_FILE=read -p " > $(ASK_FILE_PATH): " GPG_UNSIGNED_FILE
ASK_GPG_SIGNED_FILE=read -p " > $(ASK_FILE_PATH): " GPG_SIGNED_FILE
ASK_GPG_SIGNATURE_FILE=read -p " > $(ASK_FILE_PATH): " GPG_SIGNATURE_FILE

# TODO: describir en detalle
ADVICE_GPG_PUBKEY_ID=echo "La clave pública.."

# TODO: describir en detalle
ADVICE_GPG_PRIVKEY_ID=echo "(recuerde no compartir la clave privada)"
