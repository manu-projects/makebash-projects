-include .env

ssh-connect:
	@ssh -C $(USER)@$(IP)

ssh-generate-certificate:
# con esto nos evitamos ejecutar `ssh-keygen` y copiar el `~/.ssh/id_rsa.pub`
# del cliente en el `~/.ssh/authorized_keys`, porque lo hace de forma automática
	@ssh-copy-id $(USER)@$(IP)

##################################################################################

install-linux-packages: install-mailer gpg-generate-password pass-init
	@sudo apt install -y yakuake ranger

install-mailer:
	sudo apt install -y curl isync msmtp pass mutt neomutt
	-[ ! -d "$(CURRENT_PATH)/mutt-wizard" ] && \
	git clone https://github.com/LukeSmithxyz/mutt-wizard && cd mutt-wizard && sudo make install && rm -rf mutt-wizard

gpg-generate-password: # (1) primero se debe generar la clave gpg
	@gpg --full-gen-key

pass-init: # (2) luego creamos una carpeta con `pass` para una clave gpg existente
	@pass init $(ACCOUNT_GPG)

##################################################################################

install-dev-packages: install-spacemacs preinstall-vscode install-docker
	@sudo apt update
	@sudo apt install openssh-server irssi git code gcc clang -y

# https://docs.docker.com/engine/install/ubuntu/
preinstall-docker:
# 1. install Docker dependencies
	@sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
# 2. add Docker’s official GPG key which is important in enabling Docker repo
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# 3. add Docker repository
	@echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list

install-docker: preinstall-docker
# 1. Install Docker Engine
	@sudo apt update
	@sudo apt install -y docker-ce docker-ce-cli containerd.io
# 2. Agregamos al usuario actual al grupo `docker` paa que pueda ejecutar los comandos con docker
	@sudo usermod -aG docker $(WHOAMI)
# 3. Con `newgrp` habilitamos el cambio de grupo, sin necesidad de hacer `logout`ni `reboot`
	@newgrp docker

install-emacs:
	@sudo add-apt-repository ppa:kelleyk/emacs
	@sudo apt update
	@sudo apt install emacs27 -y
	@sudo add-apt-repository --remove ppa:kelleyk/emacs

install-spacemacs: install-emacs
	@git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# https://code.visualstudio.com/docs/setup/linux
preinstall-vscode:
# 1. Add Visual Studio Code repository and key
	@sudo apt-get install apt-transport-https wget gpg -y
	@wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	@sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
# 2. Add APT repository to Linux Mint
# The contents are written to the file /etc/apt/sources.list.d/vscode.list.
	@sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	@rm -f packages.microsoft.gpg

.PHONY: install-dev-packages preinstall-docker install-docker install-emacs install-spacemacs preinstall-vscode ssh-connect ssh-generate-certificate
