# Criptograma
- un mensaje *cifrado y compartido*
(Ej. texto plano ó contenido de un archivo físico)
- generado por un *algoritmo de cifrado*
(Ej. algoritmos modernos de cifrado en bloque con clave pública como RSA)
# Formato del Criptograma (del mensaje encriptado+compartido)
## Formato Binario GPG
- el formato por default por GPG al encriptar, la extensión del binario es `.gpg`
- el mensaje debe enviarse contenido en el archivo físico generado, por contiene caracteres que no son legibles para copiar/pegar
## Formato ASCII codificación base64
- en GPG la opción `--armor` se debe especificar al principio del comando `gpg`
- la extensión generada del archivo por gpg es `.asc`
- contiene caracteres legibles que podemos copiar/pegar como cualquier otro texto plano
- el *criptograma* se puede enviar
  1. en _formato de texto plano_ (Ej. cuerpo de mensaje de un email, mensaje de texto por chat, ..)
  2. ó incluido en un _archivo físico_ (con extensión .txt, .asc, éste último es el más común)
# Criptografía Simétrica + Criptografía Asimétrica
## Capa de Seguridad a la Clave Privada
- La *Criptografía Simétrica* agrega una *frase de paso* a la *Clave Privada*
- Si *Clave Privada* se pierde ó es robada necesitarán la *frase de paso* (passphrase) para desencriptar el mensaje
(recordar crear el *Certificado de Revocación* de Clave Pública y guardarlo de forma segura, cuando creamos el Par de Claves)
