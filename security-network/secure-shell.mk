SSH_ASK_USER=read -p "ingrese el nombre usuario: "
SSH_ASK_IP=read -p "ingrese ip: "

install-ssh:
	sudo aptitude install openssh-server

ssh-connect:
	read -p "ingrese el nombre usuario: " SSH_USER \
	&& read -p "ingrese ip: " SSH_IP \
	&& ssh $${SSH_USER}@$${SSH_IP}
#	$(SSH_ASK_USER) SSH_USER \
#	&& $(SSH_ASK_IP) SSH_IP \
#	&& ssh $${SSH_USER}@$${SSH_IP}

# TODO: chequear por las opciones seguras
ssh-generate-certificate:
	ssh-keygen

# TODO: crear un archivo servidores-ssh.lst + combinarlo con algún menu con whiptail y elegir desde ahi
# (agregarle un servidor fake como ejemplo)
#
# - se copia de forma automática la Clave Pública `~/.ssh/id_rsa.pub` del Cliente SSH
# en la ruta `~/.ssh/authorized_keys` del Servidor SSH
ssh-copy-certificate-to-remote:
	read -p "ingrese el nombre usuario: " SSH_USER \
	&& read -p "ingrese ip: " SSH_IP \
	&& ssh-copy-id -p $(SSH_PORT) $${SSH_USER}@$${SSH_IP}
