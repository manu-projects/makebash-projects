openssl-list-cipher-algoritms:
	openssl list -cipher-algorithms

# 1. (enc) encriptamos: con el algoritmo (DES)
# 2. (in) dato de entrada: el nombre del archivo a encriptar
# 3. (out) dato de salida: el nombre del archivo encriptado
openssl-symmetric-encryption:
	cd samples && \
	openssl \
		enc -des \
		-in sample-1.txt \
		-out sample-1.enc.des

# opciones
# ---------
# -d 	desencriptar
openssl-symmetric-decryption:
	cd samples && \
	openssl \
		enc -des -d \
		-in sample-1.enc.des \
		-out sample-2.txt

diff-decrypt-samples:
	diff --unified samples/{sample-1,sample-2}.txt

# opciones
# --------
# creamos un par de claves (pública/privada) en el mismo fichero
# genrsa	generar clave con algoritmo RSA
# (tamaño) longitud 2048 bits
openssl-generate-pairKey:
	cd samples && \
	openssl \
		genrsa \
		-out pairKey-RSA.pem 2048 \
	&& ls -l

openssl-generate-pairKey-with-passphrase:
	cd samples && \
	openssl \
		genrsa \
		-aes128 \
		-out pairKey-RSA.pem 2048 \
	&& ls -l

# aclaramos el algoritmo con el que se creó, el par de claves (Ej. en este caso RSA)
# opción (-in) especificamos el fichero del par de claves (publica/privada)
# opción (-pubout) indicamos que queremos extraer la clave pública
# opción (-out) nombre del fichero de la clave pública que extraímos
openssl-export-publicKey-from-pairKey:
	cd samples && \
	openssl \
		rsa \
		-in pairKey-RSA.pem \
		-pubout -out public-key-RSA.pem \
	&& ls -l

# para encriptar/desencriptar podemos utilizar: pkeyutl ó rsautl
openssl-asymmetric-encryption:
	cd samples && \
	openssl \
		pkeyutl -encrypt \
		-inkey public-key-RSA.pem \
		-pubin -in sample.txt \
		-out sample-encrypted.rsa \
	&& ls -l

openssl-asymmetric-decryption:
	cd samples && \
	openssl \
		pkeyutl -decrypt \
		-inkey private-key-RSA.pem \
		-in sample-encrypted.rsa \
		-out sample-decrypted.txt \
	&& ls -l

openssl-remove-samples:
	- rm -r --verbose samples/*.{pem,rsa}
	- rm --verbose samples/*-decrypted.txt
