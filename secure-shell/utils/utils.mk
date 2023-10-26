# comando `ssh-keygen`
# ====================
#
# opciones
# ---------
# -a		el número de rondas de (KDF), ofrece mayor resistencia al descifrado de la clave
# -t		el tipo de llave (tipo de encriptado, algoritmo de cifrado/firmado ó firma digital)
# -f		ruta y nombre de archivo dónde se generán las claves (pública y privada)
# -N		frase de clave (agrega una capa de seguridad extra, por si tienen acceso a la "Clave Privada")
# -C		comentarios (si fuese para utilizar en github, ellos recomiendan escribir nuestro email, pero NO es necesario)
# -b		tamaño de la clave en bits (si usamos ed25519 no es necesario, pero si lo sería con rsa)
#
# NO usamos la opción (-N) de `ssh-keygen` que agregaba una passphrase a la "Clave Privada de SSH",
# porque estamos guardando la privkey en (pass) Password Manager, que está protegido con GPG..
# (solicitará la Frase de Paso de la Clave Secundaria Privada de GPG para desencriptar las claves)
#
# precauciones
# ------------
# - (si no usaramos password manager pass + gpg) agregar una FRASE DE PASO (passphrase) como capa de seguridad adicional
# - si alguien tiene acceso al archivo de la "Clave Privada", podría utilizarla para descifrar
# el archivo de la "Clave Pública" que exponemos (con la frase de clave reducimos éste riesgo)
#
# mi variable SSH_KEYGEN
# ----------------------
# 1. utilizar el comando de linux `read` para asignarle valor a las variables (Ej. read -p "nombre: " NOMBRE)
# 2. utilizar `&& $(SSH_KEYGEN)` con las variables de la forma $${} porque no son macros de GNU Make,
# son variables definidas en la Shell de Bash (ó la que definamos en el Makefile)
#
SSH_KEYGEN=ssh-keygen \
		-a $(NUMBER_ROUNDS_KDF) \
		-t $(SIGNATURE_ALGORITHM) \
		-f $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME} \
		-C "$${SSH_KEY_COMMENTS}"
