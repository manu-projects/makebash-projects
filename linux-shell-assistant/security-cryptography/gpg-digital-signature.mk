# TODO: boxes educativo, sobre las firmas digitales
gpg-list-signatures:
	gpg --list-signatures | $(COLORED_OUTPUT)

# TODO: boxes educativo, avisando de tener "cuidado" con firmar Claves Públicas de otros con nuestra Clave Privada
# y luego subirlas a un Servidor de Claves Públicas PGP,
# porque si bien lo hacemos para decirle a GPG que "confiamos" en esa Clave Pública para tener en nuestro (keyring) Anillo de Claves,
# el resto del mundo también lo sabría y perdemos parte de nuestra privacidad diciendo "conozco a esa persona"
# (suponiendo que utilizamos esa clave para una comunicación encriptada)
gpg-sign-public-key:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& gpg --sign-key $${GPG_PRIVATE_KEY_ID}

gpg-verify-signed-file:
	$(NOTES_GPG_SIGNATURES) \
	&& $(PRINT_EXAMPLE_SIGNED_FILES) && $(ASK_GPG_SIGNED_FILE) \
	&& gpg --verify $${GPG_SIGNED_FILE}

gpg-verify-signature-separate-from-file:
	$(NOTES_GPG_SIGNATURES) \
	&& $(PRINT_EXAMPLE_UNSIGNED_FILES) && $(ASK_GPG_SIGNED_FILE) \
	&& $(PRINT_EXAMPLE_SIGNATURES) && $(ASK_GPG_SIGNATURE_FILE) \
	&& gpg --verify $${GPG_SIGNATURE_FILE} $${GPG_SIGNED_FILE}

gpg-signature-separate-from-file-as-ascii-format:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(ASK_AND_CHECK_GPG_DIGEST_HASH_ALGORITHM) \
	&& $(NOTES_GPG_SIGNATURES) \
	&& echo "tipo de firma: DETACHED SIGNATURE" \
	&& $(PRINT_EXAMPLE_UNSIGNED_FILES) && $(ASK_GPG_UNSIGNED_FILE) \
	&& gpg \
		--armor \
		--digest-algo=$${GPG_DIGEST_HASH_ALGORITHM} \
		--detach-sign --local-user=$${GPG_PRIVATE_KEY_ID} \
		$${GPG_UNSIGNED_FILE}

# TODO: lógica repetida con el formato ascii
gpg-signature-separate-from-file-as-binary-format:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(ASK_AND_CHECK_GPG_DIGEST_HASH_ALGORITHM) \
	&& $(NOTES_GPG_SIGNATURES) \
	&& echo "tipo de firma: DETACHED SIGNATURE" \
	&& $(PRINT_EXAMPLE_UNSIGNED_FILES) && $(ASK_GPG_UNSIGNED_FILE) \
	&& gpg \
		--digest-algo=$${GPG_DIGEST_HASH_ALGORITHM} \
		--detach-sign --local-user=$${GPG_PRIVATE_KEY_ID} \
		$${GPG_UNSIGNED_FILE}

# TODO: boxes educativo, comentando que el archivo firmado NO quedará encriptado,
# la firmada será agregada en formato ASCII (en vez de un binario) para compartir como texto plano
#
# TODO: boxes educativo, comentando que si alguien quiere	VERIFICAR la firma digital del archivo con GPG,
# necesitará IMPORTAR nuestra Clave Pública (asociada a la Clave Privada con la que firmamos) en su Anillo de Claves,
# y que si NO la tiene en su keyring entonces GPG intentará buscarla en un Servidor de distribución Claves Públicas
#
# TODO: boxes educativo, advirtiendo que cada vez que se modifique el archivo original, se debe volver a crear la firma digital..
# porque al modificar el archivo firmado se corromperá/dañará la integridad del archivo,
# y si alguienta verificar la firma con GPG éste lanzará una excepción "bad signature" porque el contenido del mensaje firmado fué alterado
#
# TODO: documentar que la opción (--local-user) sobreescribe la opción (--default-key),
# con --local-user elegimos una Clave Privada de nuestro Anillo de Claves para firmar
# con --default-key utiliza la primera Clave Privada que encuentre de nuestro keyring
#
# TODO: https://superuser.com/questions/1579649/how-to-fix-warning-not-a-detached-signature
gpg-signature-as-ascii-format:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(ASK_AND_CHECK_GPG_DIGEST_HASH_ALGORITHM) \
	&& $(NOTES_GPG_SIGNATURES) \
	&& echo "tipo de firma: CLEAR SIGNATURE" \
	&& $(PRINT_EXAMPLE_UNSIGNED_FILES) && $(ASK_GPG_UNSIGNED_FILE) \
	&& gpg \
		--digest-algo=$${GPG_DIGEST_HASH_ALGORITHM} \
		--clear-sign --local-user=$${GPG_PRIVATE_KEY_ID} \
		$${GPG_UNSIGNED_FILE}

# TODO: boxes educativo, avisando firmará el archivo original y luego lo encriptará con un algoritmo simétrico (única clave),
# creando un archivo binario del tipo GPG que sólo se puede desencriptar con la "Frase de Paso" (passphrase)
#
# TODO: boxes educativo, avisando que se utiliza una Clave Privada para Firmar un archivo,
# por tanto previamente se debe crear un par de Claves (pública/privada)
#
# TODO: boxes educativo, avisando que luego de desencriptar nos aparecerá el UID de quien firmó el archivo original
gpg-signature-symmetric-encryption:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(ASK_AND_CHECK_GPG_DIGEST_HASH_ALGORITHM) \
	&& $(ASK_AND_CHECK_GPG_SYMMETRIC_ALGORITHM) \
	&& echo "tipo de firma: SIGNATURE" \
	&& $(PRINT_EXAMPLE_UNSIGNED_FILES) && $(ASK_GPG_UNSIGNED_FILE) \
	&& gpg \
		--digest-algo=$${GPG_DIGEST_HASH_ALGORITHM} \
		--symmetric --cipher-algo $${GPG_SYMMETRIC_ALGORITHM} \
		--sign --local-user=$${GPG_PRIVATE_KEY_ID} \
		$${GPG_UNSIGNED_FILE}

# TODO: boxes educativo, comentando que pedirá una Clave para firmar (la privada) y otra para encriptar (la pública),
# pudiendo ser ambas diferentes porque quizás la Clave Pública es de otro usuario (por tanto no tendriamos en nuestro keyring la Clave Privada asociada)
# y que sólo podrá desencriptarlo como siempre el que tenga la Clave Privada asociada a la Clave Pública con la que se encriptó
# (Ej. un jefe, un equipo de trabajo, ..)
gpg-signature-asymmetric-encryption:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) && $(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& $(ASK_AND_CHECK_GPG_DIGEST_HASH_ALGORITHM) \
	&& echo "tipo de firma: SIGNATURE" \
	&& $(PRINT_EXAMPLE_UNSIGNED_FILES) && $(ASK_GPG_UNSIGNED_FILE) \
	&& gpg \
		--digest-algo=$${GPG_DIGEST_HASH_ALGORITHM} \
		--sign --local-user=$${GPG_PRIVATE_KEY_ID} \
		--encrypt --recipient $${GPG_PUBLIC_KEY_ID} \
		$${GPG_UNSIGNED_DECRYPTED_FILE} \

# TODO: usará una clave pública para el encriptado asimétrico, una clave privada para el encriptado simétrico y una clave privada para firmar,
# no necesariamente deben ser la misma Clave Privada con la que firmamos y con la que encriptamos, pero quizás sería más cómodo
#
# TODO: boxes eduactivo, comentando que esto mismo ocurre con Github,
# cuando creamos el par de claves (pública/privada) y le agregamos una "frase de paso" (passphrase)
#gpg-sign-asymmetric-symmetric-encryption:
#	echo pendiente..
