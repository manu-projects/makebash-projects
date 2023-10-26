Autenticación Asimétrica usando el Par de Claves de SSH (Pública/Privada)
=========================================================================

Flujo básico durante el intento de conexión
-------------------------------------------
1. nuestro **Cliente SSH**

   - envía una solicitud de conexión al **Servidor SSH**
   - si utilizamos la opción ``StrictHostKeyChecking yes``, 1º verificará si el Servidor está agregado en ``/home/nombre-de-usuario/.ssh/known_hosts``

2. el **Servidor SSH**

   1. verifica si es un **Cliente autorizado**, chequeando si tiene el (fpr) de la Clave Pública en ``/home/nombre-de-usuario/.ssh/authorized_keys``
   2. genera un mensaje denominado **desafío** (key challenge) utilizando

      - un número aleatorio de gran longitud
      - nuestra **Clave Pública** (para encriptar el valor del número aleatorio)

   3. envía al Cliente SSH el mensaje generado (key challenge) para verificar la **Identidad del Usuario** (la Clave Privada)

3. el **Cliente SSH** (suponemos que ya tenemos ejecutando un Agente de Autenticacion)

   - NO puede resolver el desafío (desencriptar el mensaje) porque no tiene la **clave privada**
   - reenvía el mensaje (key challenge) al **Agente de Autenticación**

4. el **Agente de Autenticación** genera un **respuesta al desafío** (challenge reponse)

   1. desencripta el mensaje (key challenge) con la **Clave Privada** (sólo podrá si está asociada a la **Clave Pública** subida al Servidor)
   2. genera un **Valor de Hash** (mensaje resumen) de los siguientes datos

      - el **ID de la sesión de SSH** (varía en cada conexión)
      - el **Valor aleatorio** (challenge cleartext) que desencriptó con la **Clave Privada**

   3. genera una **Firma Digital** (encripta con la **Clave Privada** el **valor de Hash** anterior) para

      - certificar la **Identidad del usuario** (el usuario posee la Clave Privada asociada a la Clave Pública subida al Servidor)
      - asegurar la **Integridad de los datos** (es decir no fueron alterados, lo asegura el Valor de Hash)

   4. envía la respuesta (challenge response, mensaje firmado) al **Cliente SSH**

5. el **Cliente SSH** envía al **Servidor SSH** la respuesta (mensaje firmado) por el **Agente** (el agente sólo comunica con el Cliente)
6. el Servidor SSH verifica la autenticidad de la respuesta (mensaje firmado)

   1. utiliza la **Clave Pública** para desencriptar el mensaje y obtener el **Valor de Hash**
   2. verifica si el **Valor de Hash** generado coincide con el recibido

      - si coincide, ACEPTA la solicitud de conexión y se establece una **sesión segura de shell** entre Cliente-Servidor con el prótocolo SSH (secure shell)
      - si NO coincide, RECHAZA la solicitud de conexión (puede ocurrir porque la Clave Privada NO coincide con la Clave Pública)

Logs de Autenticación
---------------------
- acceder a ``/var/log/auth.sh``
- el programa ``lnav`` permite una mejor lectura de archivos de log

Agente SSH - Par de Claves de SSH
=================================

Clave Pública de SSH
--------------------
- denominadas **claves autorizadas**

  - porque son las únicas permitidas a ingresar al Sistema con el prótocolo SSH (si se confirma la identidad del usuario con la Clave Privada asociada)
  - motivo por el que se agregan en ``/home/nombre-de-usuario/.ssh/authorized_keys`` (del lado del Servidor)

- archivo regular con extensión ``.pub`` en la ruta ``/home/nombre-de-usuario/.ssh/`` del usuario que la generó con ``ssh-keygen``
- copiar la **Clave Pública de nuestra maquina local** en el archivo ``/home/nombre-de-usuario/.ssh/authorized_keys`` del **Servidor SSH**

Clave Privada de SSH
--------------------
- si son utilizadas para **autenticar**

  - confirman la **Identidad** del usuario (aclaramos para diferenciar con GPG, que las clasifica para [A]utenticar, [D]esencriptar, [F]irmar)
  - se referencian en la opción ``IdentityFile`` del ``~/.ssh/config`` **del lado del Cliente**

- permanece en nuestra maquina local en el directorio ``/home/nombre-de-usuario/.ssh/`` (con igual nombre que la Clave Pública)
- utilizada al establecer la conexión con el Servidor SSH, para validar nuestra identidad
- NO debe compartirse ni exponer, porque se utiliza para descifrar/desencriptar la **Clave Pública** asociada

Frase de Paso (passphrase)
--------------------------
- agrega una capa de seguridad adicional a la **Clave Privada**
- si alguien obtuviera nuestra **Clave Privada**, necesitarían adivinar la **frase de paso** asociada
