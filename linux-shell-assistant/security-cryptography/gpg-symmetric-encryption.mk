# TODO: boxes educativo, avisando que el cifrado SIMÉTRICO sólo tendrá una Clave Secreta
# TODO: documentar opciones de (gpg), el orden es importante.. porque --output no es una opción de symmetric
gpg-symmetric-encryption-with-binary-format:
	$(ASK_AND_CHECK_GPG_SYMMETRIC_ALGORITHM) \
	&& $(ASK_GPG_DECRYPTED_FILE) \
	&& gpg \
			--symmetric \
			--cipher-algo $${GPG_SYMMETRIC_ALGORITHM} $${GPG_DECRYPTED_FILE}

# TODO: lógica repetida con formato binario
gpg-symmetric-encryption-with-ascii-format:
	$(ASK_AND_CHECK_GPG_SYMMETRIC_ALGORITHM) \
	&& $(ASK_GPG_DECRYPTED_FILE) \
	&& gpg \
			--armor \
			--symmetric \
			--cipher-algo $${GPG_SYMMETRIC_ALGORITHM} $${GPG_DECRYPTED_FILE}
