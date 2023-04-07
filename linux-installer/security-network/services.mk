list-port-services:
	less /etc/services \
	| awk '!/^#.*/' \
	| tr --squeeze-repeats '\n' \
	| bat

service-ssh-activate:
	systemctl enable ssh

# TODO: ssh ó sshd ??
service-ssh-status:
	systemctl status sshd

# TODO: ssh ó sshd ??
# en caso de error ejecutar `journalctl -xeu sshhd.service` para obtener el detalle del problema
service-ssh-restart:
	sudo systemctl restart sshd

# en caso de cambiar el puerto del Servidor SSH
list-services-using-ssh:
	grep ssh /etc/services
