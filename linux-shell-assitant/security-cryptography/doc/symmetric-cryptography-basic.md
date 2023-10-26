# Criptografía Simétrica
## Cifrado en Bloque
- clasificado como *cifrado en bloque* con *clave secreta*
## Clave Secreta
- basado en una *única clave secreta* para encriptar/desencriptar
- no requiere crear un par de claves (requerido en criptografía asimétrica y en la creación de firma digital)
- la *clave secreta* también se conoce como
  1. *frase de paso* (passphrase)
  2. *secreto compartido* (shared secret)
## Algoritmos de Cifrado Simétrico (Cipher Algorithms)
- GPG utiliza por default el algoritmo de cifrado `AES-128`
- en GPG la opción `--cipher-algo` permite especificar un algoritmo de cifrado para encriptar
### (DES) Data Encryption Standard
- diseñado por la (NSA) "National Security Agency"
- utiliza *bloques de 64 bits* y una *clave de 56 bits*
### (3DES) Triple DES
- aplica tres veces el _algoritmo DES con diferentes claves_
- utiliza una *clave de 112 bits* de longitud
### (IDEA) "International Data Encription Algorithm"
- utiliza *bloques de 64 bits* de longitud y una *clave de 128 bits*
### Blowfish
- utiliza *bloques de 64 bits* de longitud y una *clave de hasta 448 bits*
### RC5
- diseñado por *RSA (4)*
- el *tamaño del bloque* a encriptar se puede definir
- el *tamaño de la clave* y el *número de fases de encriptación* también se pueden definir
### (AES) Advanced Encryption Standard
- claves con longitud entre 128, 192 y 256 bits
