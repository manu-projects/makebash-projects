#!/bin/bash

# Objetivos de éste Bash Script
# ==============================
#
# - ejecutar una única instancia del Agente SSH
# (cada vez que se ejecute el ssh-agent se crea una nueva instancia del agente y crea un nuevo archivo tipo socket)
# - al crear una nueva Bash Shell (en un emulador de terminal) el Agente SSH utilice el mismo archivo tipo socket (referenciado por SSH_AUTH_SOCK)
# - la variable de entorno SSH_AUTH_SOCK de cada Bash Shell referencie al mismo archivo tipo socket

SSH_ENV="${HOME}/.ssh/agent-environment"

function start_agent_ssh() {
    echo "(agent-ssh-autostart) Inicializando un nuevo Agente de Autenticación de SSH en una Subshell..."

    echo "(agent-ssh-autostart) Guardando los comandos de shell devueltos por el Agente SSH en ${SSH_ENV}..."
    ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}

    echo "(agent-ssh-autostart) Asignando permisos de lectura y escritura al archivo ${SSH_ENV}.."
    chmod u+rw ${SSH_ENV}

    echo "(agent-ssh-autostart) Ejecutando los comandos de Shell guardados del Agente SSH..."
    source ${SSH_ENV} > /dev/null

    echo "(agent-ssh-autostart) Verifique de agregar las conexiones de SSH en su archivo de configuración ~/.ssh/config"

    # - si al comando `ssh-add` no le pasamos parámetros, agregará las claves por defecto con nombre id_ed25519, id_rsa, ..
    # - preferimos NO agregar las claves privadas mediante `shh-add`,
    # porque es más seguro y portable utilizar un archivo de configuración ~/.ssh/config ó ~/etc/ssh/ssh_config
    #
    # echo "(agent-ssh-autostart) Guardando las Claves Privadas de SSH en el Agente SSH.."
    # ssh-add
}

# 1. si ya existe el archivo que contiene los comandos devueltos al ejecutar el agente SSH
if [ -f "${SSH_ENV}" ]; then
    # - evaluamos/importamos a la Bash Shell actual las Variables de Entorno que contiene el archivo (Ej. SSH_AGENT_PID, SSH_AUTH_SOCK)
    # - redireccionamos el resultado de ejecutar los comandos al dispositivo null, para no mostrarlos por pantalla (stdout)
    echo "(agent-ssh-autostart) Ejecutando los comandos de Shell guardados del Agente SSH, para configurar las variables de entorno de la Shell..."
    source ${SSH_ENV} > /dev/null

    # - Si no coincide la Variable de Entorno que importamos con el Agente SSH en ejecución, ejecutamos un nuevo Agente SSH
    # (si no está ejecutando el proceso, lo comparará con un string vacío)
    # - al ejecutar la función de Bash se ejecutará una nueva instancia del Agente SSH y se reescribirán las variables de entorno
    # en el archivo que referenciamos en ${SSH_ENV}
    if [ "${SSH_AGENT_PID}" != "$(pgrep --exact ssh-agent)"]
    then
        echo "(agent-ssh-autostart) No existe un Agente SSH ejecutando."
        echo "(agent-ssh-autostart) Ejecutando un nuevo Agente SSH, y reescribiendo los comandos que definen las variables de entorno actuales de la Shell.."
        start_agent_ssh
    fi

    # Solución alternativa al if []; then ..
    # ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || { ...
    #
    # 1. filtramos entre todos los procesos asociados a la Shell, buscando por el Agente SSH
    # 2. utilizamos el operador lógico OR (||) si queremos ejecutar un comando (B) en caso de que el "estado de salida" de un comando (B) sea distinto de cero
    # 3. si el "Estado de Salida" de un comando es distinto de cero, entonces no tuvo éxito al ejecutar ó ocurrió un error, en este caso si no encuentra a un proceso

# 2. si NO existe el archivo que contiene los comandos (variables de entorno) devueltos al ejecutar el Agente SSH
else
    # 2.1. creamos el archivo (que guardará los comandos que devuelve el Agente SSH para setear las variables de entorno)
    # 2.2. ejecutamos un Agente SSH
    # 2.3. notificar de agregar las conexiones ssh en su archivo de configuración de OpenSSH
    start_agent_ssh
fi
