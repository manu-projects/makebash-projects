##@ Secure Shell - Openssh (Client side)

sshclient-remove-privatekey-file:
	$(ASK_SSH_KEY_NAME) \
	&& rm -vi $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME}

sshclient-copy-publickey-to-clipboard:
	$(ASK_SSH_KEY_NAME) \
	&& cat $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME} \
	| $(COPY_TO_CLIPBOARD)

# se recomienda que sólo el usuario del sistema acceda al directorio ~/.ssh
# caso contrario el comando `ssh-add` NO permitirá agregar Claves Privadas de SSH, diciendo "WARNING: UNPROTECTED PRIVATE KEY FILE!"
sshclient-check-permissions: sshclient-check-permissions-dir sshclient-check-permissions-config

# TODO: problemas en el condicional de GNU Make si utilizamos la macro $(PRINT_OCTAL_PERMISSIONS)
# porque aunque tratemos de ejecutar cualquier target, GNU Make 1º evaluará las expresiones de los ifeq
sshclient-check-permissions-config:
ifeq ("$(shell stat --format='%a'  $(SSH_CLIENT_CONFIG))", "$(SSH_CLIENT_CONFIG_PERMISSIONS)")
	@echo "el archivo regular $(SSH_CLIENT_CONFIG) tiene BIEN asignado los permisos"
else
	@echo "el archivo regular $(SSH_CLIENT_CONFIG) tiene MAL asignado los permisos"
	@echo "asignando los permisos correctos.."
	chmod $(SSH_CLIENT_CONFIG_PERMISSIONS) $(SSH_CLIENT_CONFIG)
endif

# TODO: repite problema que con el target sshclient-check-permissions-config
sshclient-check-permissions-dir:
ifeq ("$(shell stat --format='%a' $(SSH_CLIENT_DIR))","$(SSH_CLIENT_DIR_PERMISSIONS)")
	@echo "el directorio $(SSH_CLIENT_DIR) tiene BIEN asignado los permisos"
else
	@echo "el directorio $(SSH_CLIENT_DIR) tiene MAL asignado los permisos"
	@echo "asignando los permisos correctos.."
	chmod $(SSH_CLIENT_DIR_PERMISSIONS) $(SSH_CLIENT_DIR)
endif

sshclient-create-pairkey: ##
	$(NOTES_SSH_KEYS)
	$(ASK_SSH_KEY_NAME) && $(ASK_SSH_KEY_COMMENTS) \
	&& $(SSH_KEYGEN)

sshclient-list-pairkey-files:
	$(NOTES_SSH_PRIVATE_KEYS)
	@ls $(SSH_CLIENT_DIR) \
	| grep -E --invert-match --word-regexp "agent-environment|authorized_keys|config|known_hosts"

sshclient-remove-pairkey:
	$(ASK_SSH_KEY_NAME) \
	&& rm -vi $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME} $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME}.pub

# comando `ssh-copy-id`
# =====================
#
# objetivo
# --------
# - copiar la Clave Pública `~/.ssh/id_rsa.pub` (u otra que elijamos) del "Cliente SSH" en el "Servidor SSH"
# (se copia en el archivo `~/.ssh/authorized_keys`)
#
# opciones
# ---------
# -i		ruta y nombre de la clave pública
sshclient-copy-publickey-to-unknown-host: ##
	$(ASK_SSH_KEY_NAME) && $(ASK_SSH_HOST_USER) && $(ASK_SSH_HOST_IP) \
	&& ssh-copy-id \
		-o StrictHostKeyChecking=no \
		-i $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME}.pub \
		-p $(SSH_PORT) $${SSH_HOST_USER}@$${SSH_HOST_IP}

sshclient-copy-publickey-to-known-host: ##
	$(NOTES_SSH_KNOWN_HOSTS) \
	&& $(ASK_AND_SELECT_SSH_HOST_ALIAS) && $(ASK_SSH_KEY_NAME) \
	&& ssh-copy-id \
		-o StrictHostKeyChecking=no \
		-i $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME} \
		$${SSH_HOST_ALIAS}

# TODO: refactor, lanzar un error más descriptivo que `exit 1`
sshclient-check-known-host-exists:
	$(ASK_SSH_HOST_ALIAS) && ssh-keygen -H -F $${SSH_HOST_ALIAS} > /dev/null; \
	[[ $(CHECK_EXIT_STATUS) ]] \
		&& echo "el Host aparece en el Listado de Hosts conocidos (~/.ssh/known_hosts)" && exit 1 \
		|| echo "el Host NO aparece en el Listado de Hosts conocidos (~/.ssh/known_hosts)" && true

# ssh-keyscan
# - NO funciona si le pasamos el Alias del host que tenemos ~/.ssh/config ni /etc/ssh/ssh_config
# - requiere pasar el hostname del Host (la dirección de IP ó el dominio del servidor)
sshclient-add-known-host:
	$(NOTES_SSH_KNOWN_HOSTS) \
	&& $(ASK_SSH_HOST_NAME) && $(ASK_AND_SELECT_SSH_TYPE_HOSTKEY) \
	&& ssh-keyscan -H -t $${SSH_TYPE_HOSTKEY} $${SSH_HOST_NAME} >> ~/.ssh/known_hosts

# comando `rsync`
# ========================
#
# opciones interesantes
# ---------------------
# --rsyncpath
#		- comando a ejecutar en el Servidor SSH (remoto) antes de iniciar la transferencia
#		- en este ejemplo utilizamos `sudo rsync` porque necesitamos permisos de superusuario para acceder al directorio /etc
#		- previo a ejecutar, en el Servidor SSH modificamos el sudoers con `sudo visudo`
# 	agregando al final del archivo nombre_usuario_remoto ALL=NOPASSWD:ruta_del_comando_binario_rsync
#
# --rsh
# 	- comando a ejecutar en la Shell del Servidor SSH (remoto)
# 	- por default `rsync` utiliza `ssh`, pero queremos cambiar el puerto 22 que utiliza ssh
#
# opciones comunes
# ------------------
# --human-readable	convierte el tamaño del archivo en una unidad más entendible
# --compress				comprime el archivo durante la transferencia (reduce su tamaño, tardando menos)
# --progress				imprime el progreso durante la transferencia (no es lo mismo que --verbose)
# --partial					mantiene los archivos incompletos en la ruta destino (servidor remoto) en caso de que la transferencia se interrumpa
#
# TODO: evaluar posibilidad de solicitar nombre de la clave + opción -i en el ssh con la ruta de la clave privada
sshclient-copy-config-to-unknown-host:
	$(ASK_SSH_HOST_USER) && $(ASK_SSH_HOST_IP) \
	&& rsync \
	--progress --human-readable --partial --compress --verbose \
	--rsync-path="sudo rsync" \
	--rsh "ssh -p $(SSH_PORT)" \
	$(MODULE_SECURE_SHELL_CONFIGS)/sshd_config \
	$${SSH_HOST_USER}@$${SSH_HOST_IP}:/etc/ssh/sshd_config.d

sshclient-copy-sshdconfig-to-known-host:
	$(ASK_AND_SELECT_SSH_HOST_ALIAS) \
	&& rsync \
	--progress --human-readable --partial --compress --verbose \
	--rsync-path="sudo rsync" \
	$(MODULE_SECURE_SHELL_CONFIGS)/sshd_config \
	$${SSH_HOST_ALIAS}:/etc/ssh/sshd_config.d

# - al utilizar la opción (-i), el método de autenticación es por Clave Pública que debe estar en el Servidor
# (por parámetro pasamos la Clave Privada, porque es la "Identidad del Usuario" utilizada durante el "Challenge Key" solicitado por el Servidor)
#
# - si no utilizamos (-i) el método de autenticación sería por Password
sshclient-connect-to-unknown-host: ## solitará nombre de la llave, usuario del host, ip del host
	$(NOTES_SSH_UNKNOWN_HOSTS) \
	&& $(ASK_SSH_PRIVATE_KEY_NAME) && $(ASK_SSH_HOST_USER) && $(ASK_SSH_HOST_NAME) \
	&& ssh \
		-i $(SSH_CLIENT_DIR)/$${SSH_PRIVATE_KEY_NAME} \
		-p $(SSH_PORT) \
		$${SSH_HOST_USER}@$${SSH_HOST_NAME}

sshclient-connect-to-known-host:
	$(ASK_AND_SELECT_SSH_HOST_ALIAS) \
	&& ssh $${SSH_HOST_ALIAS}

# TODO: avisar que el Sistema de Ventanas x11 de por si NO es seguro
# TODO: popup educativo, de que luego de conectarnos podremos ejecutar aplicaciones con interfáz gráfica del Servidor pero en nuestra máquina local
# (podemos ejecutar aplicaciones GUI de forma remota, sin necesidad de instalarlas de forma local)
sshclient-connect-to-known-host-X11:
	$(ASK_AND_SELECT_SSH_HOST_ALIAS) \
	&& ssh -X $${SSH_HOST_ALIAS}

# comando `ssh`
# ============
#
# opciones
# --------
# -X		habilita el X11forwarding (túnel de puerto X11 ó Sistema de Ventanas X)
# -x		deshabilita el X11forwarding
# -C		recomendado si existe mala conexión de internet, comprime los datos enviados por el Servidor SSH (stdin, stdout, stderr, datos del túnel X11, ..)
#
# TODO: avisar que el Sistema de Ventanas x11 de por si NO es seguro
sshclient-connect-to-unknown-host-X11: ## solicitará el nombre del host (definido por config)
	$(NOTES_SSH_UNKNOWN_HOSTS) \
	&& $(ASK_SSH_PRIVATE_KEY_NAME) && $(ASK_SSH_HOST_USER) && $(ASK_SSH_HOST_NAME) \
	&& ssh -X \
		-i $(SSH_CLIENT_DIR)/$${SSH_PRIVATE_KEY_NAME} \
		-p $(SSH_PORT) \
		$${SSH_HOST_USER}@$${SSH_HOST_NAME}

# comando `sftp` (secure ftp)
# ===========================
#
# - transfiere de archivos con un prótocolo ftp a través de una conexión segura
#
# TODO: validar si necesitás pasarle el key-file
sshclient-connect-sftp-host:
	$(ASK_SSH_HOST_USER) && $(ASK_SSH_HOST_IP) \
	&& sftp $${SSH_HOST_USER}@$${SSH_HOST_IP}

sshclient-remove-keyhost-by-ip:
	$(SSH_ASK_HOST_IP) \
	&& ssh-keygen -f "$${HOME}/.ssh/known_hosts" -R "$${SSH_HOST_IP}"

# TODO: para pasarlo a un dispositivo de almacenamiento encriptado (disco externo, pendrive)
# ssh-backup-pairkeys:

# comando `ssh-keygen`
# ====================
#
# opciones
# --------
# -l		mostrar el fingerprint de una Clave Pública (.pub)
# -f		ruta y nombre de la Clave Pública (.pub)
sshclient-show-fingerprint-publickey:
	$(ASK_SSH_KEY_NAME) \
	&& ssh-keygen -l -f $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME}.pub
