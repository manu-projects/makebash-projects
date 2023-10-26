# targets sshagent-start y sshagent-add-privatekey
# ================================================
#
# - NO ejecutar si ya ejecutamos el Shell script para auto-iniciar el Agente SSH
# porque podría volverse tedioso manejar múltiples Agentes SSH
#
# - ejecutan un nuevo Agente SSH asociado a una única Shell
# y configura en la Shell actual las "variables de entorno" para que funcione el Agente SSH
#
# - si creamos una nueva "PTY Slave" desde un Emulador de Terminal
#   1. se creará una nueva Shell (sin las "variables de entorno" del Agente SSH que creamos en la Shell que se ejecuto el ssh-agent)
#   2. la nueva Shell NO se conectará automáticamente al Agente SSH (al no tener las variables de entorno),
#   a menos que definamos las variables manualmente en esta nueva Shell (algo tedioso si nos manejamos con múltiples "PTY Slave")

# TODO: boxes educativo, diciendo que por seguridad NO recomendamos el auto-iniciar,
# pero SI se recomienda iniciar el Agente SSH sólo en los momentos que lo utilicemos
# (porque la seguridad del Sistema podría estar comprometida al iniciar)
sshagent-autostart:
	@echo "Copiando configuración en $${HOME}/.bashrc" \
	&& rsync $(MODULE_SECURE_SHELL_SCRIPTS)/ssh-agent-autostart.sh $(SSH_CLIENT_DIR)/ssh-agent-autostart.sh \
	&& echo "source $(SSH_CLIENT_DIR)/ssh-agent-autostart.sh" >> $${HOME}/.bashrc

# comandos `eval` y `ssh-agent -s`
# ================================
#
# comando ssh-agent
# -----------------
#
# 1. escribe comandos de Shell del tipo (sh) "Bourne Shell" por STDOUT, imprimiendo por pantalla
# (ese resultado escrito por stdout lo pasaremos por parámetro al comando `eval`)
# 2. los comandos de shell devueltos crean "variables de entorno" y las exporta a la Shell utilizando `export`
# (estas variables de entorno son necesarias para el agente SSH, por Ej. SSH_AUTH_SOCK, SSH_AGENT_PID)
#
# comando eval
# -------------
#
# 1. evalúa el resultado devuelto por `ssh-agent` y los ejecuta como comandos de Shell
# 2. la Shell interpreta los comandos y crea/modifica las variables de entorno mencionadas en la Shell
# (estas variables de entorno son utilizadas por el comando `ssh-add`)
sshagent-start:
	eval $$(ssh-agent -s)

# comandos `eval` + `ssh-agent -k`
# ================================
#
# - finaliza el agente SSH que ejecuta en segundo plano en la Shell actual
# - elimina las variables de entorno de la Shell actual (que habían sido creadas al evaluar `ssh-agent -s`)
# - requiere el comando `eval` para ejecutar como comandos de Shell el resultado devuelto por `ssh-agent -k` que eliminan las variables de entorno
# (si no lo utilizamos, en la Shell seguirán existiendo las variables de entorno que utilizaba el agente ssh anterior que fue finalizado)
sshagent-kill:
	eval $$(ssh-agent -k)
#	kill -9 $${SSH_AGENT_PID}

# comando `ssh-add`
# =================
#
# - agrega la identidad de la Clave Privada al "Agente de Autenticación OpenSSH"
# - si alguna llave requiere "frase de clave" (passphrase), entonces la pedirá por la (tty) terminal del usuario
#
# requisitos para que funcione
# ----------------------------
#
# 1. el Agente de Autenticación OpenSSH debe estar ejecutando
# 2. debe existir la Variable de Entorno `SSH_AUTH_SOCK` (el devuelto por `ssh-agent -s`) porque utiliza ese socket
sshagent-add-privatekey-file: # requiere el archivo de la privkey en ~/.ssh/
	$(ASK_SSH_PRIVATE_KEY_NAME) \
	&& ssh-add $(SSH_CLIENT_DIR)/$${SSH_PRIVATE_KEY_NAME}

# TODO: similar al target de ssh-github.mk pero conexiones remotas locales
# sshagent-add-privatekey-safe: ssh-install-askpass

# TODO: dar un aviso de que ya NO es seguro utilizar
# es inseguro, dejamos el target para recordar "NO utilizar ssh-askpass"
ssh-install-askpass:
ifeq ("$(shell which ssh-askpass)", "")
	sudo aptitude install ssh-askpass
endif

sshagent-list-fingerprints:
	ssh-add -l

sshagent-list-publickeys:
	ssh-add -L

sshagent-delete-identity-from-privatekey-file:
	$(ASK_SSH_PRIVATE_KEY_NAME) \
	&& ssh-add -d $(SSH_CLIENT_DIR)/$${SSH_PRIVATE_KEY_NAME}

# TODO: popup con whiptail de confirmar acción
sshagent-delete-identities:
	ssh-add -D

#sshagent-kill:
#	kill -9 $${SSH_AGENT_PID}

sshagent-restart:
	sudo systemctl restart sshd
