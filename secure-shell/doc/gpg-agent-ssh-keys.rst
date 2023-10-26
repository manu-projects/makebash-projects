1. (GPG, GnuPG) GNU Privacy Guard + (pass) The UNIX Password Manager
====================================================================

1.1 generar el Par de Claves Primarias (pública/privada) en GnuPG
-----------------------------------------------------------------

- el **algoritmo ed25519** es el más eficiente y seguro
- GPG nos pedirá una **frase de paso** para proteger la **Clave Primaria Privada de GnuPG**
(ésta "frase de paso" agrega una capa de seguridad, en caso de perder o que nos roben la Clave Primaria Privada de GPG)

.. code-block:: shell

                # ejecutar en la terminal
                make gpg-generate-primary-key


1.2 generar un Par de Claves Secundarias (pública/privada) en GnuPG para [E]ncriptar
------------------------------------------------------------------------------------

- GPG lo utilizaremos para cifrar/encriptar la **Clave Privada de SSH** en el **Password Manager** (llamado pass)
- el **algoritmo cv25519** es el más eficiente y seguro para encriptar (no confundir con ed25519, éste otro no es para encriptar)
- el **Par de Claves Secundarias** debe tener la **capacidad de [E]encriptar** (encrypt capability)
- la **Clave Secundaria Pública** encriptará y la **Clave Secundaria Privada** desencriptará

.. code-block:: shell

                # ejecutar en la terminal
                make gpg-generate-subkey

1.3 crear el Almacén de Claves en (pass) el Gestor de Claves estándar de UNIX
-----------------------------------------------------------------------------

- ingresamos el (fpr) **fingerprint** ó **ID** del **Par de Claves Secundarias** que tiene la capacidad de [E]encriptar (encrypt capability)
- ``pass`` creará un directorio en ``~/.password-store`` y lo inicializará agregando el ID en ``~/.password-store/.gpg-id``

.. code-block:: shell

                # ejecutar en la terminal
                make pass-init

2. Par de Claves SSH + Password Manager
=======================================

2.1 crear el Par de Claves de SSH (pública/privada) + la frase de paso (ó passphrase)
-------------------------------------------------------------------------------------

- el **Par de Claves (pública/privada)** persistirá en el en el directorio ``~/.ssh/`` (cliente SSH)
(NO compartir/publicar la **clave privada** de SSH, sólo divulgaremos la **clave pública** de SSH)
- una alternativa al **Par de Claves SSH** sería crear un **Par de Claves Secundarias de GPG** con la **capacidad de [A]utenticación** (authenticate capability)

.. code-block:: shell

                # ejecutar en la terminal
                make sshclient-create-pairkey

2.2 importar la Clave Privada de SSH al Password Manager (pass)
---------------------------------------------------------------

- evitamos que ocurra el escenario en el que la **Clave Privada de SSH** esté comprometida a causa de la mala seguridad de nuestro sistema
- protegemos la **Clave Privada de SSH** en el **Password Manager (pass)** que necesita el **Par de Claves Secundarias de GPG** para desencriptar
(siendo la Clave Secundaria Privada quien desencripta el archivo que fue cifrado con la Clave Secundaria Pública asociada)
- luego de importar la Clave Privada de SSH, debemos **BORRAR el archivo físico** de ``~/.ssh/`` (cliente SSH)
(el **par de claves de ssh** tiene el mismo nombre, la **clave pública de ssh** tiene la extensión ``.pub``, la **clave privada de ssh** NO tiene extensión)

.. code-block:: shell

                # ejecutar en la terminal
                make pass-github-import-ssh-privatekey

2.3 (opcional) comprobar que la Clave Privada de SSH se importó correctamente
-----------------------------------------------------------------------------

.. code-block:: shell

                # ejecutar en la terminal
                make pass-list-passwords

3. Agente de Autenticación
===========================

3.1 Agregar en el Agente, la Clave Privada cifrada del Password Manager
-----------------------------------------------------------------------

.. code-block:: shell

                # ejecutar en la terminal
                make sshagent-add-github-privatekey-from-password-manager

Agente Autenticación
********************
- la variable de entorno ``SSH_AUTH_SOCK`` apunta al **archivo del tipo Socket** del Agente que utilicemos (Agente SSH ó Agente GPG)
- persiste en memoria la **Clave Privada de SSH** y la (passphrase) asociada si tuviera, los **Clientes SSH** le preguntarán a él
- ofrece mayor seguridad porque nos evita interactuar con los Clientes SSH, caso contrario nos preguntarían a cada rato por la **Clave Privada de SSH**

Agente GPG (gpg-agent)
***********************
- es el que utilizaremos porque antes ya importamos la **Clave Privada de SSH** en el **Password Manager (pass)** que está protegido/encriptado con GPG

Agente SSH (ssh-agent de OpenSSH)
*********************************
- lo utilizaríamos si protegieramos el archivo de la **Clave Privada de SSH** con una **frase de paso (passphrase)**
- NO lo utilizamos, porque preferimos tener el archivo de la **Clave Privada Maestra** en un **medio de almacenamiento externo al Sistema**

3.2 (opcional) comprobar que la Clave Privada se guardó en el Agente
--------------------------------------------------------------------

- una alternativa sería utilizar el comando ``ssh-add`` con la opción ``-l`` ó ``-L``
- con ``ssh-add -L`` listamos las claves públicas, con ``ssh-add -l`` para listar los **(fpr) fingerprint**

.. code-block:: shell

                # ejecutar en la terminal
                make sshagent-list-publickeys

4. Remover la Clave Privada de SSH
==================================

4.1 Remover el archivo regular de la Clave Privada de SSH
---------------------------------------------------------

.. code-block:: shell

                # ejecutar en la terminal
                make sshclient-github-remove-privatekey-file

- contemplamos el escenario de que esté comprometida la seguridad de nuestra máquina
- el archivo físico del **Par de Claves de SSH (pública/privada)** suelen estar en ``~/.ssh``
- guardar una copia, exportando en algún **medio de almacenamiento encriptado** externo al Sistema (Ej. disco duro externo ó pendrive)

4.2 (opcional) copiar en el portapeles la Clave Pública de SSH
--------------------------------------------------------------

.. code-block:: shell

                # ejecutar en la terminal
                make sshclient-github-copy-publickey-to-clipboard

- acceder al navegador web y pegar el contenido en https://github.com/settings/ssh/new
- utilizar el atajo ``Ctrl+v`` para retirar la **Clave Pública de SSH** del portapapeles

5. Iniciar el Agente de Autenticación
=====================================

Archivos de Configuracón dónde ejecutar los Script Shell ó Comandos de Bash
---------------------------------------------------------------------------
- en el archivo ``~/.bashrc`` los comandos se ejecutarán cada vez que abramos una Bash Shell
- en el archivo ``~/.bash_profile`` los comandos se ejecutarán una única vez, al iniciar el sistema
- algunos recomiendan **iniciar el Agente (SSH ó GPG)** sólo cuando se requiere, porque el sistema ya podría estar comprometido al iniciar

Agente GPG
----------
consideramos que es más seguro utilizar el **Agente GPG** que el **Agente SSH** de OpenSSH porque

1. importamos la **Clave Privada de SSH** del **Password Manager (pass)**
2. las claves del **Password Manager (pass)** están protegidas/encriptadas con GPG

.. code-block:: shell

                # agregar en el archivo ~/.bashrc ó ~/.bash_profile
                export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
                export GPG_TTY="$(tty)"
                gpg-connect-agent updatestartuptty /bye

Agente SSH
----------
- revisar la documentación ``ssh-agent-autostart`` que está más detallada
