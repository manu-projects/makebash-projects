# - cuando servicio SSH Server no inicia y journalctl informa "sshd: no hostkeys avaiable"
# - genera las claves de host (rsa, dsa, ecdsa, ed25519)en /etc/ssh
sshhost-generate-all-hostkeys:
	@sudo ssh-keygen -A
