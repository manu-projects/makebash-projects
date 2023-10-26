ASK_PORT_ALLOW=read -p "ingrese el puerto: "

firewall-activate:
	sudo ufw enable

firewall-status:
	sudo ufw status

firewall-allow-ssh-port:
	sudo ufw allow $(SSH_PORT)

firewall-allow-port:
	$(ASK_PORT_ALLOW) PORT \
	&& sudo ufw allow $${PORT}
