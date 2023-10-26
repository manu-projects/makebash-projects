# Abreviaturas al Listar las Claves
## Claves públicas
- Abreviaturas en el Listado las Claves Públicas con `gpg --list-keys`

| `pub` | public primary key | clave pública maestra    |
| `uid` | unique identifier  | identificador único      |
| `sub` | public sub-key     | clave pública secundaria |
## Claves Privadas
- Abreviaturas en el Listado las Claves Privadas con `gpg --list-secret-keys`

| `sec` | secret primary key | clave privada maestra    |
| `uid` | unique identifier  | identificador único      |
| `ssb` | secret sub-key     | clave secreta secundaria |
## Clave Privada Maestra fuera del Sistema
- Si borramos el archivo físico de la *Clave Privada Maestra* del sistema
  1. al listar las claves secretas, veremos`sec#` en vez de `sec`
  2. al certificar/firmar la clave pública de otra persona, gpg lanzar como excepción `gpg: signing failed: No secret key`
- por seguridad es común exportarla a un dispositivo encriptado/externo al sistema, previo a borrar su archivo físico en `${HOME}/.gnupg/private-keys-v1.d/`

| `sec`  | clave privada maestra | el archivo físico existe en el sistema |
| `sec#` | clave privada maestra | el archivo físico fue eliminado        |
# Operaciones/Funcionalidades de las Claves (Capabilities)
## Funcionalidades del Par de Claves Primaria ó Maestra
- por default contiene las operaciones [SC]

| `S` | Sign    | Crear firmas digitales (Ej. sobre archivos, en correos, commits de git) |
| `C` | Certify | Certificar/firmar claves públicas secundarias de otras personas         |
## Funcionalidades del Par de Claves Secundaria
- por default contiene las operación [E]
- puede contener las operaciones [S] ó [A] ó [E]

| `S` | Sign         | Crear firmas digitales (Ej. sobre archivos, en correos, commits de git) |
| `A` | Authenticate | Autenticación (Ej. conectarse a una máquina)                            |
| `E` | Encrypt      | Encriptar (con la clave pública) y Desencriptar (con la clave privada)  |
# Nivel de Confianza de Claves y Firmas Digitales (Trust Level)
- en GPG se elige el *nivel de confianza* con la opción `--edit-key id-clave-publica` seguido de la orden `trust`

|            | confianza en la clave | descripción                                                                     |
| *Unknown*  | valor por DEFAULT     | NO se eligió aún el nivel de confianza                                          |
| *Never*    | NO confío para nada   | por tanto tampoco sus firmas, sería lo mismo que NO agregarla a nuestro keyring |
| *Marginal* | confío un poco        | requiere de un *Anillo de confianza* formado por al menos 3 personas            |
| *Full*     | confío totalmente     | requiere de un *Anillo de confianza* formado por al menos 1 persona             |
| *Ultimate* | confío absolutamente  | MAYOR nivel de confianza, utilizar sólo con Claves propias                      |
## Anillo de Confianza
- formado entre personas que firman en su keyring la clave pública de otra persona y la marcan con un nivel de confianza
- cada persona debe
  1. guardar los cambios de su keyring y subirla al servidor de claves públicas pgp (ó exportar manualmente la clave pública y enviarla por otro medio)
  2. importar la clave pública de las otras personas
## Confianza Total (Full)
- requiere de un *Anillo de Confianza* formado por al menos 1 persona
- nuestro (keyring) Anillo de Claves debe tener al menos 1 Clave Pública de otra persona firmada y marcada con *Confianza Total*
- Ej. dos personas que se conocen, cada una firmó la firma la Clave Pública del otro y la marca con Confianza Total
## Confianza Marginal
- requiere de un *Anillo de Confianza* formado por al menos 3 personas (se conocen entre ellos, firmaron la clave pública de cada uno)
- nuestro (keyring) Anillo de Claves debe tener al menos 2 Claves Públicas de otras persona firmadas y marcadas con *Confianza Marginal*
- Ej. tres personas que se conocen, cada una firmó la firma la Clave Pública del otro y la marca con Confianza Marginal
# Remitente y Destinatario
## Proceso Básico
1. el Destinatario tiene que distribuir su *Clave Pública*
2. los Remitentes importan la Clave Pública y ENCRIPTAN el mensaje
3. el Destinatario DESENCRIPTA con su *Clave Privada secundaria* asociada a la Clave Publica
## Remitente (Sender)
### Operaciones
- ENVIA el mensaje
- FIRMA el mensaje (para validar que fué el, utilizando la *Clave Privada primaria*)
- ENCRIPTA el mensaje (con una *Clave Pública secundaria* propia ó compartida, guardada en su *Anillo de Claves*)
### Propietario de la Clave Pública Compartida
1. representa al DESTINATARIO, porque le envían mensajes ENCRIPTADOS (utilizan esa *Clave Pública secundaria*)
2. DESENCRIPTA el mensaje (utilizando su *Clave Privada secundaria*)
### Ejemplos
1. `gpg --clear-sign --local-user "Carlos Ramirez" apuntes.pdf` (FIRMAMOS un archivo, confirmando quien lo manda)
## Destinatario (Recipient)
### Operaciones
- RECIBE el mensaje
- DESENCRIPTA el mensaje
### Operación de Desencriptar
- utiliza la *Clave Privada secundaria* guardada en su *Anillo de Claves (keyring)*
- Un mensaje se puede DESENCRIPTAR unicamente con la *Clave Privada* asociada a la *Clave Pública* utilizada para ENCRIPTAR
### Ejemplos
1. `gpg -e -u "Bob" apuntes.pdf` (ENCRIPTAMOS un archivo para Bob, utilizando su clave pública)
2. `gpg -s -e Bob archivo.txt` (FIRMAMOS con nuestra clave privada primaria y ENCRIPTAMOS para Bob con su clave pública secundaria)
# Par de Claves Primaria y Secundarias
## (master-key) Par de Claves Primaria ó Maestra
- GPG los genera por default cuando creamos nuestro Par de Claves (pública/privada)
- puede incluir uno ó varios (uid) User-IDs de la forma `nombre apellido (comentario) <correo electrónico>`
### Identidad
- identifica a un usuario, su reputación/confianza en la comunidad
(Ej. la reputación de un usuario en debian.org determina si confiarán en descargar los paquetes que desarrolló/subió)
### Clave Privada Primaria (Maestro) - Operaciones permitidas (capabilities)
2. Crear ó Revocar un Par de Claves Secundaria que tenga operaciones para (S)Firmar/(E)Encriptar/(A)Autenticar
3. Agregar ó Revocar un (uid) asociado a una Clave Primaria
2. Autenticar/Firmar una Clave Pública de otra persona (previamente la importamos a nuestro Anillo de Claves Públicas)
6. Cambiar la fecha de Caducidad de la Clave Primaria ó de una Clave Secundaria
7. Generar un *Certificado de Revocación* de Clave Pública
### Abreviaturas en el Listado de Claves
1. `(pub)` Clave Pública Primaria (MAESTRO)
2. `(sec)` Clave Privada Primaria (MAESTRO)
## (sub-key) Pares de Claves Secundarias
- Certificadas/firmadas por un *Par de Claves Primaria* (certifica que pertenece a tal User-ID)
- pueden ser *revocadas* independientemente del *par de claves maestro*
### Independientes
- cada *Clave Secundaria* (subkey) es independiente de la *Clave Primaria ó Maestra*
- un mensaje encriptado con una Clave Pública Secundaria
  - NO puede ser desencriptado por la Clave Primaria ó Maestra asociada
### Operaciones permitidas (capabilities)
1. (encrypt) Encriptar por una Clave Pública Secundaria
2. (decrypt) Desencriptar por una Clave Privada Secundaria
### Listado de Claves
  1. `(sub)` Clave Pública Secundaria (ó subclave pública)
  2. `(ssb)` Clave Privada Secundaria (ó subclave privada)
# Ejemplo - Anillo de Claves Secretas
## Escenario
```shell
jelou@jelou:~$ gpg --list-secret-keys --keyid-format LONG
/home/jelou/.gnupg/pubring.kbx
------------------------------
sec   ed25519/122D90E6F4959F7E 2023-05-07 [SC] [expires: 2025-05-06]
      1235C1E00647508CCEC02A72122D90E6F4959F7E
uid                 [ultimate] neverkas <neverkas.forever@gmail.com>
uid                 [ultimate] neverkas <neverkas@proton.me>
ssb   cv25519/172250B7E54E62CC 2023-05-29 [E] [expires: 2024-05-28]
ssb   ed25519/1ADB16159102D31C 2023-05-29 [S] [expires: 2024-05-28]
ssb   ed25519/2796ECF3FE35DD41 2023-05-29 [A] [expires: 2024-05-28]
```
## Observaciones
- el *anillo de claves públicas/privadas* mostrará la misma información (uids, id key, id subkeys, capabilities, expires, ..)
(porque nosotros creamos el par de claves, somos los propietarios)
- si listaramos los *pares de claves* del *anillo de claves públicas*
  1. la etiqueta `sec` sería `pub`
  2. las etiquetas `ssb` serian `sub`
## Descripción de la Clave Primaria ó Maestra
| *Algoritmo de cifrado en bloque con clave pública* | ed25519                                          |
| *GPG key ID* (incluido al final del fingerprint)   | 122D90E6F4959F7E                                 |
| *Fingerprint* (de la Clave Pública)                | 1235C1E00647508CCEC02A72122D90E6F4959F7E         |
| *Operaciones permitidas*                           | [S] de firmar archivos, [C] de certificar claves |
## User-IDs y Claves Secundarias
### (uid) User-ID
- asociamos la misma identidad con dos correos con distinto dominio
- ambos (uid) tienen `Ultimate` como *Nivel de Confianza del UID* es decir *mayor nivel de confianza* porque es mi clave
### (subkey) Claves Secundarias
- agregamos tres claves secundarias
- 1 *par de claves secundarias* para ENCRIPTAR/DESENCRIPTAR con id `172250B7E54E62CC` (utiliza el algoritmo cv25519)
- 1 *par de claves secundarias* para FIRMAR archivos con id `1ADB16159102D31C` (utiliza el algoritmo ed25519)
- 1 *par de claves secundarias* para AUTENTICAR con id `2796ECF3FE35DD41` (utiliza el algoritmo ed25519)
