service-restart-lightdm:
	@sudo service lightdm restart

list-port-services:
	less /etc/services \
	| awk '!/^#.*/' \
	| tr --squeeze-repeats '\n' \
	| bat

service-ssh-activate:
	systemctl enable ssh

# ssh: cliente ssh
service-ssh-status:
	systemctl status ssh

# sshd: servidor ssh
service-sshd-status:
	systemctl status sshd

# en caso de error ejecutar `journalctl -xeu sshhd.service` para obtener el detalle del problema
service-sshd-restart:
	sudo systemctl restart sshd

# en caso de cambiar el puerto del Servidor SSH
list-services-using-ssh:
	grep ssh /etc/services
