=======================================
Configuración desde el lado del Cliente
=======================================
La configuración la hacemos en el siguiente orden

1. Asignar permisos a los archivos
2. Agregar configuración de los hosts a los que nos conectaremos por SSH
3. Copiar el (fpr) fingerprint del Servidor
4. Copiar nuestra Clave Pública al Servidor

Permisos de los Archivos
========================
Asignar permisos de Lectura/Escritura para el Usuario propietario utilizando la Notación Octal ó Simbólica

Asignación con Notación Octal
-----------------------------
desde el lado del Cliente asignamos los permisos

- al directorio ``chmod 0700 /home/nombre-de-usuario/.ssh/``
- al archivo de configuración ``chmod 0600 /home/nombre-de-usuario/.ssh/config``
- al archivo de **hosts conocidos** a conectarse por el prótocolo SSH ``chmod 0600 /home/nombre-de-usuario/.ssh/known_hosts``

Asignación con Notación Simbólica (propietario-grupos-otros)
------------------------------------------------------------
desde el lado del Cliente asignamos los permisos

- al directorio ``chmod go-rwx,u=rwx /home/nombre-de-usuario/.ssh``
- al archivo de configuración ``chmod go-rwx,u=rw /home/nombre-de-usuario/.ssh/config``
- al archivo de **hosts conocidos** a conectarse por el prótocolo SSH ``chmod go-rwx,u=rw /home/nombre-de-usuario/.ssh/known_hosts``

Configuración de los Host que nos conectaremos por SSH
======================================================
la configuración del Host (servidor) en ``/home/nombre-de-usuario/.ssh/config``

- el **Nombre del Host** (lo usaremos en los siguientes comandos en vez de ``nombre-de-usuario@ip-del-servidor``)
- el nombre de usuario del servidor, el ip y el puerto (el puerto por defecto del prótocolo SSH es 22)
- la **Identificación de Usuario** (el archivo de la Clave Privada)
- los **Tipos de Algoritmo de Clave Pública** del Host que preferimos para autenticación (Ej. ssh-ed25519, ssh-rsa)
- los **Métodos de Autenticación** (Ej. autenticación con clave, autenticación con algoritmo de clave pública)

Copiar el (fpr) fingerprint de la Clave Pública del Servidor
============================================================
copiamos el (fpr) en ``/home/nombre-de-usuario/.ssh/known_hosts`` (base de datos de texto plano, en nuestra maquina local)

- ejecutamos ``ssh-keyscan -H -t tipo-algoritmo-clave-publica nombre-del-host >> /home/nombre-de-usuario/.ssh/known_hosts``
- otra alternativa sería reemplazar nombre del host por ``nombre-usuario@ip-servidor``

Copiar nuestra Clave Pública al Servidor
========================================
copiamos nuestra en el archivo ``/home/nombre-de-usuario/.ssh/authorized_keys`` (en el Servidor SSH)

- ejecutamos ``ssh-copy-id -o StrictHostKeyChecking=no -i /home/nombre-de-usuario/.ssh/nombre-clave-publica.pub nombre-del-host``
- otra alternativa sería reemplazar nombre del host por ``nombre-usuario@ip-servidor``
- otra alternativa serían los comandos ``rsync``, ``scp``, ``sftp``
