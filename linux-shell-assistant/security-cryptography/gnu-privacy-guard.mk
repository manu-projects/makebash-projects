# TODO: uso pendiente hasta evaluar exportar la Clave Privada maestra, a un dispositivo encriptado
GPG_PATH=$${HOME}/.gnupg
GPG_KEYRING=pubring.kbx
# - la opción (--secret-keyring) quedó deprecada según GPG
GPG=gpg \
	--no-default-keyring \
	--keyring $(GPG_PATH)/$(GPG_KEYRING) \

# TODO: boxes educativo comentando que si el archivo fue cifrado con un algoritmo ASIMÉTRICO,
# la Clave Privada que tengamos en nuestro (keyring) Anillo de Claves sólo podrá desencriptar archivos
# que fueron encriptados por una Clave Pública asociada a esa Clave Privada
# (es decir que no podremos desencriptar archivos encriptados con una Clave Pública asociada a otra Clave Privada)
gpg-decrypt-file:
	$(PRINT_EXAMPLE_ENCRYPTED_FILES) && $(ASK_GPG_ENCRYPTED_FILE) \
	&& $(ASK_GPG_DECRYPTED_FILE) \
	&& gpg \
		--output $${GPG_DECRYPTED_FILE} \
		--decrypt $${GPG_ENCRYPTED_FILE}

gpg-show-info-signature-encrypted-file:
	$(ASK_GPG_FILE) && pgpdump $${GPG_FILE} \
	| $(COLORED_OUTPUT)
