# Firma Digital (Digital Signature)
## Conceptos
- archivo que contiene *encriptado* un *valor de hash*
- si una persona firma dos documentos, cada archivo tendrá encriptada un *valor de hash* diferente
## Características
- similar a un *checksum* (sumas de comprobación)
- garantiza la *INTEGRIDAD de los datos*
- garantiza *AUTENTICIDAD del emisor* del mensaje (característica que NO ofrece Checksum)
## Algoritmos Requeridos
1. un *algoritmo de Hash* para generar un *fingerprint* ó *valor de hash* (único e irrepetible) del archivo
(Ej. SHA2-256, SHA2-512, ..)
2. un *algoritmo de Encriptación Asimétrica* (Ej. RSA)
   - para encriptar con una *Clave Privada* el *valor de hash*
   - para desencriptar el *valor de hash* con una *Clave Pública* (asociada a la misma Clave Privada utilizada para firmar)
## Garantizan la Integridad de los Datos
- la *integridad de los datos* la garantiza el *Valor de hash* (ó fingerprint) generado sobre el archivo
## Garantizan Autenticidad
- la *autenticidad* la garantiza la *Clave Privada* de quien firmó (se utilizó para encriptar el valor de hash)
  1. al encriptar el *Valor de hash* con la *Clave privada* sólo puede desencriptarlo la *Clave pública* asociada
  (sólo al crear firmas digitales se encripta/desencripta de forma inversa a como se suele hacer con la Criptografía Asimétrica)
  2. la *Clave Pública* tiene vinculada *la identidad del usuario* que la compartió (ej. en un servidor de claves públicas pgp)
## Nivel de Confianza (trust)
- se basa en si uno confía ó no en la *Identidad del usuario* de una *Clave Pública* (Ej. debian, arch, ..)
- si *confiamos* en esa identidad
  1. importamos su *Clave Pública* a nuestro *Anillo de Claves Públicas* (keyring) de GPG
  2. firmamos la *clave pública* con nuestra *clave privada* confirmando que confiamos en la identidad que tiene asociada
  3. *verificamos* los archivos firmados (firmados con la Clave Privada asociada a la Clave Pública que decidimos confiar)
# Relación y Diferencias con (Checksum) las Sumas de Comprobación
## (Checksum) Suma de Comprobación
### Garantizan la Integridad de los Datos
- utilizan *algoritmos de hash* para generar un *fingerprint* (huella) de un archivo (también llamado valor de hash ó.. mensaje resumen)
### NO garantizan Autenticidad
- son anónimas, no tiene vinculado la identidad de quien generó el checksum
(lo opuesto a la firma digital, dónde se vincula la identidad al firmar con la clave privada)
- no impide el *ataque man-in-the-middle* porque cualquiera puede alterar el archivo y luego generar un nuevo *checksum*
- la *firma digital* resuelve éste problema, al utilizar *encriptación Asimétrica* que requiere firmar con la *clave secreta/privada*
# Relación y Diferencias con la Criptografía Asimétrica
## En la Criptografía Asimétrica
### La Clave Pública encripta un archivo ó un mensaje
- ENCRIPTA un mensaje ó el contenido de un archivo
- realizado *por el Remitente*, la Clave Pública pertenece al Destinatario
### La Clave Privada desencripta un archivo ó un mensaje
- DESENCRIPTA un mensaje ó el contenido de un archivo
- realizado *por el Destinatario*, quien distribuyó su Clave Pública
## En la Firma Digital
### El Par de Claves (pública/privada)
- INVIERTE el orden de uso del *Par de claves* de la Encriptación Asimétrica
### La Clave Privada firma un archivo
- ENCRIPTA un valor de hash que identifica el contenido de archivo
- registra la identidad de la persona que lo firmó
### La Clave Pública verifica la firma digital
- DESENCRIPTA el valor de hash que indica el contenido del archivo fue alterado
- visualiza la identidad de la persona que firmó el archivo
# Crear Firma Digital
## 1. Generar un Valor de Hash
- el Algoritmo de Hash elegido (Ej. SHA2-256, SHA2-512, ..) genera un *valor de hash* sobre el archivo
- el contenido del archivo son los *datos de entrada* (input) para generar el *valor de hash* (único e irrepetible)
- una mínima modificación del archivo
  - rompe la *integridad de los datos* porque el valor de hash generado ya no lo representa
  - se debe generar otra firma digital, con un nuevo valor de hash generado a partir del nuevo contenido
## 2. Encriptar con la Clave Privada
- NO es un error, al crear una firma digital es la Clave Privada quien Encripta
- ENCRIPTA el *valor de hash* anterior
- utiliza el *Algoritmo de encriptación Asimétrico* asociado (Ej. RSA)
- NO tiene la intención de encriptar el mensaje original, sólo el *valor de hash*
## 3. Crear el archivo de la firma digital
- contiene el *valor de hash* encriptado (garantiza la Integridad de los datos)
- información del propietario de la *clave privada* (garantiza la Autenticidad de quien lo firmó)
# Verificar Firma Digital
#### Verificar la firma con la Clave Pública
- NO es un error, al verificar una firma digital es la Clave Pública quien Desencripta
- la Clave Pública debe estar asociada a la Clave Privada que lo firmó (de quien compartió esa clave pública)
## Que podemos firmar
- un documento de texto plano, un documento de word, ..
- un programa ejecutable, un sistema operativo, ...
- una clave pública (criptografía asimétrica)
## Cuando firmar
- liberamos/publicamos una versión final de un programa (Ej. común en los Sistema Operativos)
- generamos una clave pública que distribuimos (comunicación encriptada, criptografía asimétrica)
- rubricar un documento contable (Ej. para alguna entidad del gobierno)
## Tips
### Agregar Cambios a un documento
- implíca que (Remitente) deba firmar el documento otra vez, para generar un *valor de hash* diferente
- cada cambio implíca firmar de nuevo
### NO firmar un documento modificado
- implíca que cuando el (Destinatario/Receptor) verifique la firma, sea advertido que el contenido del archivo fue alterado
# Valor de Hash - Mensaje Resumen (Message Digest)
## Que es
- el resultado de aplicar una *función de Hash* a *un mensaje de longitud arbitraria*
- tiene una *longitud fija* (fixed) definida según el *algoritmo de hash* elegido
- el *valor de hash* de un mensaje es único e irrepetible, siempre que no sufra cambios (agregar/modificar/remover contenido)
## Longitud recomendada
- la *longitud mínima* recomendada es de 128 bits (38 dígitos), con 2^128 combinaciones diferentes posibles
- la *longitud más utilizada* es de 160 bits (48 dígitos), con 2^160 combinaciones diferentes posibles
# Algoritmos Criptográficos de Hash (Cryptographic hash function)
## Que son
- _generan valores únicos_ (valor de hash, su longitud está limitada por el tipo de algoritmo elegido) para _verificar la integridad de los datos_
- un algoritmo matemático que _transforma una entrada de datos en una secuencia fija de valores alfanuméricos_
- el resultado/salida se produce con una *operación de transformación NO reversible*, la transformación es en sólo un sentido (no es bidireccional)
(Ej. si transformamos una cadena de texto, con el valor de hash devuelto no podemos saber que texto transformó)
## Cuando utilizar
### Crear una Firma Digital (firmar un archivo)
- certificar que el contenido de un archivo NO fue modificado/alterado
### Persistir clave de cuentas de usuario en una base de datos
- si un intruso obtiene el *valor de hash* asociado a una clave, éste tendría que probar por fuerza bruta 2^N combinaciones posibles
- si la *longitud del valor de hash* es N bits (Ej. 128, 160, ..), existen 2^N combinaciones diferentes posibles
- los valores de hash almacenados y los generados en el momento deben utilizar el mismo *algoritmo de hash* (Ej. md5, sha256, sha512, ..)
- cuando el usuario ingresa su contraseña en el sistema
  1. la cadena de caracteres es transformada a un *valor de hash*
  2. el *valor de hash* generado en el momento se compara con el almacenado en la DB
## Entrada Variable y Salida Fija
- el resultado (salida) es de longitud FIJA (limitante del algoritmo)
- el mensaje de entrada puede ser de longitud variable (pero la salida será siempre fija)
# Tipos de Algoritmos Criptográficos de Hash
## (MD5) Message Diggest 5 (inseguro)
- procesa el mensaje en *entradas de bloques de 512 bits* y el resultado (salida) es una *firma de 128 bits*
- produce una firma de longitud de 128 bits
## (SHA-1) Secure Hash Algorithm (inseguro)
- desarrollado por la (NSA) "Agencia de Seguridad Nacional"
- NO se recomienda utilizar, considerado inseguro por el (NIST) "Instituto Nacional de Estándares y Tecnología" (de Estados Unidos)
- procesa el mensaje en *entradas de bloques de 512 bits* y el resultado (salida) es una *firma de 160 bits*
- produce una firma de longitud de 160 bits
## (SHA-2) Secure Hash Algorithm (seguro)
- tiene una *familia estandar* de dos algoritmos de hash
  1. SHA2-256 (valor de hash de 256 bits de longitud)
  2. SHA2-512 (valor de hash de 512 bits de longitud)
- existe otra familia que son modificaciones del estándar (SHA2-224, SHA2-384, SHA2-512/224, SHA2-512/256)
## (SHA-3) Secure Hash Algorithm (seguro)
- tiene una familia de tres algoritmos de hash
  1. SHA3-256
  2. SHA3-384
  3. SHA3-512
