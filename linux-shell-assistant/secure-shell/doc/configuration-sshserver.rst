========================================
Configuración desde el lado del Servidor
========================================

1. Asignar permisos a los archivos
2. Creamos nuevos pares de claves para el Host
3. Agregar Claves Públicas Autorizadas


Permisos del Archivo
====================
Asignar permisos de Lectura/Escritura para el Usuario propietario utilizando la Notación Octal ó Simbólica

Asignación con Notación Octal
-----------------------------
desde el lado del Servidor asignamos los permisos

- al directorio ``chmod 0700 /home/nombre-de-usuario/.ssh/``
- al archivo con las **Claves Públicas autorizadas** a ingresar al sistema por el prótocolo SSH  ``chmod 0600 /home/nombre-de-usuario/.ssh/authorized_keys``

Asignación con Notación Simbólica (propietario-grupos-otros)
------------------------------------------------------------
desde el lado del Servidor asignamos los permisos

- al directorio ``chmod go-rwx,u=rwx /home/nombre-de-usuario/.ssh``
- al archivo con las **Claves Públicas autorizadas** a ingresar al sistema por el prótocolo SSH ``chmod go-rwx,u=rw /home/nombre-de-usuario/.ssh/authorized_keys``

(Host Keys) Crear Par de Claves del Host
=========================================
Para tener un mejor control del par de claves que utilizamos desde del lado del cliente-servidor

Borramos los Pares de Claves por defecto del Host
--------------------------------------------------
- los pares de claves están en ``/etc/ssh``
- ejecutamos ``cd /etc/ssh && sudo rm --verbose ssh_host*`` (modificaciones en ``/etc`` requieren permisos de superusuario)

Generamos nuevos Pares de Claves
--------------------------------
NO cambiar el nombre estándar del par de claves, porque el **Cliente SSH** podría no encontrarlas al ejecutar ``ssh-keyscan nombre-del-host``

- Par de claves con el algoritmo ed25519 ejecutando ``ssh-keygen -N "" -t ed25519 -f /etc/ssh/ssh_host_ed25519_key``
- Par de claves con el algoritmo RSA de 4096 bits ejecutando ``ssh-keygen -N "" -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key``

Listado Claves Públicas Autorizadas
-----------------------------------
lo común sería agregarlas al Servidor ejecutando desde el lado del Cliente ``ssh-copy-id nombre-del-host``

- es un archivo regular ``/home/nombre-de-usuario/.ssh/authorized_keys`` (del lado del Servidor)
- contiene las **Claves Públicas** de los **Clientes Remotos** que se conectan al Servidor con **Autenticación Asimétrica**
- el Servidor verifica la **Identidad del Usuario** enviandole un desafío (challenge key) con la **clave pública**
