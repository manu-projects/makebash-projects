# Criptografía Asimétrica
## Cifrado en Bloque
- clasificado como *cifrado en bloque* con *clave pública*
## Par de Claves (pública/privada)
### Clasificación Par de Clave Primaria y Secundarias
- revisar en la documentación `doc/gpg-labels.md` de etiquetas y términos de GPG
### Clave pública
- la *clave pública* encripta mensajes, verifica firmas digitales, ..
- utilizada para encriptar un mensaje (contenido de un archivo)
- compartible como texto plano (debe exportarse en formato ASCII, utiliza codificación en base64)
- compartible de forma masiva desde un *Servidor de Distribución de Claves Públicas PGP* (Ej. pgp.mit.edu)
  - otros usuarios pueden enviarnos _archivos encriptados_ ó _emails encriptados_ (utilizando nuestra Clave Pública)
  - sólo nosotros podemos desencriptar los datos (utilizando nuestra Clave Privada)
### Clave privada
- NO se debe compartir
- desencripta un mensaje (encriptado con la clave pública asociada)
- la *clave privada* desencripta mensajes, firma archivos, firma claves, revoca claves públicas, ..
## Frase de paso (passphrase)
- encripta la *Clave Privada* como capa de seguridad adicional
(Ej. si otro usuario obtiene nuestra Clave Privada, podría desencriptar lo que encriptamos con la Clave Pública)
## Certificado de Revocación
- revoca una *clave pública* impidiendo que pueda cifrar datos (aunque puede verificar firmas del usuario)
- en casos de olvidar la clave ó perder la *clave privada*
(Ej. si algún intruso tuviera acceso al sistema y luego a la clave privada)
## Precauciones
### Crear/Proteger el Certificado de Revocación de Clave Pública
- crear en el momento de creación del *par de claves*
- en caso de que la *Clave Privada* se pierda o sea robada, _para revocar la clave_
- guardar en un dispositivo externo al del Sistema instalado (Ej. un pendrive encriptado)
### Utilizar el Certificado de Revocación de Clave Pública
1. importar en nuestro *Anillo de Claves* (keyring)
2. subir al Servidor de Claves Públicas PGP (suponiendo que otras personas la utilicen)
### Proteger la Clave Privada Primaria
- guardar en un dispositivo externo al del Sistema instalado (Ej. un pendrive encriptado)
- utilizar una *clave privada secundaria*
## Algoritmos de Cifrado Asimétrico
### Logaritmos Discretos
- el más conocido es *ElGamal* (basado en las teorías de Diffie Hellman)
### (RSA) Factorización de números primos
- Funciones exponenciales discretas con _propiedades de los números primos_
- Un par de claves (pública/privada) _a partir de 2048 bits de longitud se considera segura_ (en la actualidad)
#### Ejemplos
- RSA de 2048 bits (para archivos pequeños)
- RSA de 3072 bits
- RSA de 4096 bits (para archivos grandes)
### (ECC) Criptografía de Curva Elíptica
- El par de claves (pública/privada) _son de corta longitud comparado con (RSA)_
- Recomendado para Sistemas de pocos recursos comparados con un ordenador de escritorio
(Ej. se puede implementar en celulares, tarjetas inteligentes, ..)
- La eficiencia y pequeña longitud hacen que sea más utilizado en vez del algoritmo (RSA) de "Factorización de números primos"
#### Ejemplos
- ECC P-256 (para archivos muy pequeños)
- ECC P-521 (para archivos pequeños)
- ECC EdDSA (para archivos pequeños)
