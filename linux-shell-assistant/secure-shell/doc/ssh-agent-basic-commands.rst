Comandos básicos por linea de comandos (terminal)
=================================================
en la máquina cliente deberiamos ejecutar, reemplazar ``host`` por la IP del servidor ó el nombre del Host de ``~/.ssh/config``

1. ``ssh-keygen`` crear el par claves pública/privada y una "frase de paso" (passphrase)
2. ``ssh-copy-id host`` copiar clave pública en el HOST (Servidor remoto) al que nos queremos conectar
3. ``ssh host`` conectarse al HOST (para validar conexión)

Comandos en un Shell script para Iniciar el Agente SSH
======================================================
en la máquina cliente podemos agregar en ``~/.bash_profile`` (al iniciar el sistema, login shell) ó en ``~/.bashrc`` (cada nueva shell)

1. ``ssh-agent`` iniciar el Agente SSH para que éste recuerde las **claves privadas** y su **frase de paso** (passphrase) si tuviesen una asociada
2. ``ssh-add ~/.ssh/nombre-clave-privada`` agrega la **clave privada** al Agente SSH (comprobar que se agregó con la opción -L)
