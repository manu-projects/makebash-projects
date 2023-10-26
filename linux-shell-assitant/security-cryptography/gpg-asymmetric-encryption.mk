# TODO: evaluar problemas/efectos al mover al Makefile principal
# se agregó porque en (sh) Bourne Shell no tengo la opción -s del comando read
SHELL=/bin/bash

# TODO: boxes educativo, comentando que el mensaje encriptado con la Clave Pública elegida,
# sólo se podrá desencriptar con la Clave Privada asociada a esa Clave Pública
#
# TODO: boxes educativo, que la Clave Pública puede ser una creada por nosotros (que podemos compartir con otros),
# ó una Clave Pública que nos compartieron e importamos a nuestro (keyring) Anillo de Claves
#
# TODO: documentar de forma global que la opción (--output) se coloque como primer opción del comando `gpg`,
# para evitar problemas con las otras opciones de `gpg` que suelen recibir varios parámetros
#
# opciones
# --------
# --recipient		el ID de la clave pública con la que vamos a encriptar el archivo
# --output			nombre del archivo encriptado a generar
gpg-asymmetric-encryption:
	$(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& $(ASK_GPG_DECRYPTED_FILE) \
	&& gpg \
		--encrypt \
		--recipient $${GPG_PUBLIC_KEY_ID} \
		$${GPG_DECRYPTED_FILE}
