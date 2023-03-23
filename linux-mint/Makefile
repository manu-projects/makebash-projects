-include .env

ssh-connect:
	@ssh -C $(USER)@$(IP)

ssh-generate-certificate:
# con esto nos evitamos ejecutar `ssh-keygen` y copiar el `~/.ssh/id_rsa.pub`
# del cliente en el `~/.ssh/authorized_keys`, porque lo hace de forma automática
	@ssh-copy-id $(USER)@$(IP)

##################################################################################

install-linux-packages: install-mailer gpg-generate-password pass-init install-lsd
	@sudo apt install -y yakuake ranger lnav

install-lsd:
	cd /tmp && \
	curl -L https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_amd64.deb > lsd.deb && \
	sudo dpkg -i lsd.deb

install-mailer:
	sudo apt install -y curl isync msmtp pass mutt neomutt
	-[ ! -d "$(CURRENT_PATH)/mutt-wizard" ] && \
	git clone https://github.com/LukeSmithxyz/mutt-wizard && cd mutt-wizard && sudo make install && rm -rf mutt-wizard

gpg-generate-password: # (1) primero se debe generar la clave gpg
	@gpg --full-gen-key

pass-init: # (2) luego creamos una carpeta con `pass` para una clave gpg existente
	@pass init $(ACCOUNT_GPG)

##################################################################################

install-shell-fish:
	sudo aptitude install fish

install-terminal-kitty:
	sudo apt install -y kitty

install-fzf:
	sudo aptitude install fzf

##################################################################################

# TODO: mensaje para la ramificación else, reutilizar para otros paquetes que se agregaron la fuente en sources.list.d
# TODO: archivo de configuración para las fuentes
configure-apt-sources-list-nala:
ifeq ($(wildcard /etc/apt/sources.list.d/volian-archive-scar-unstable.list),)
	echo "deb-src https://deb.volian.org/volian/ scar main" | sudo tee -a /etc/apt/sources.list.d/volian-archive-scar-unstable.list
endif

install-nala-legacy: configure-apt-sources-list-nala
	sudo apt update && sudo apt install -y nala-legacy

install-highlight:
	sudo apt install -y highlight

install-bat:
	sudo apt install -y bat

##################################################################################

install-anki:
	sudo aptitude install -y anki


##################################################################################

# TODO: pendiente hasta actualizar dotfiles
create-dotfiles:
	@mkdir -p ~/dotfiles
#	@cd ~/dotfiles && git clone $(GITHUB_DOTFILES) . && stow .
#	cd ~/dotfiles && git clone $(GITHUB_DOTFILES) . && stow --adopt -v .

install-dev-packages: install-spacemacs install-clojure preinstall-vscode install-docker create-dotfiles
	@sudo apt update
	@sudo apt install -y neovim openssh-server irssi git code gcc clang stow virtualbox virtualbox-ext-pack
	@echo "eval $(keychain --eval id_rsa)" >> ~/.bashrc

# https://docs.docker.com/engine/install/ubuntu/
preinstall-docker:
# 1. install Docker dependencies
	@sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
# 2. add Docker’s official GPG key which is important in enabling Docker repo
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# 3. add Docker repository
	@echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list

# TODO: si usamos live cd de Linux mint cambiar la clave, si no la pedira y fallara la instalacion
# cambiarla con: passwd mint
install-docker: preinstall-docker
	@passwd
# 1. Install Docker Engine
	@sudo apt update
	@sudo apt install -y docker-ce docker-ce-cli containerd.io
# 2. Agregamos al usuario actual al grupo `docker` paa que pueda ejecutar los comandos con docker
	@sudo usermod -aG docker $(WHOAMI)
# 3. Con `newgrp` habilitamos el cambio de grupo, sin necesidad de hacer `logout`ni `reboot`
	@newgrp docker

# TODO: por el momento no remover el repositorio, porque preguntara por la version de emacs a borrar..
# luego agregar que borre la 28
#
# TODO: si no acepta la clave de servidor de kelleyk/emacs, agregarla
# con lo sig.: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key ACA_NUMERO_KEY_QUE_FALLA
install-emacs:
	@sudo apt remove --autoremove emacs
	@sudo add-apt-repository ppa:kelleyk/emacs
	@sudo apt update
	@sudo apt install emacs28 -y
#	@sudo add-apt-repository --remove ppa:kelleyk/emacs

# TODO: chequear el nombre del repositorio si apunta a spacemacs, caso contrario instalar
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

install-clojure:
# Clojure CLI tools and common aliases (Additional tools to enhance Clojure development experience)
	$(info Instalando Clojure + Clojure Tools..)
	@git clone git@github.com:practicalli/clojure-deps-edn.git ~/.clojure/

# Clojure CLI tools (Run Clojure REPL for development and production)
	@mkdir -p /tmp && cd /tmp && curl -O https://download.clojure.org/install/linux-install-1.10.3.967.sh && \
	chmod +x linux-install-1.10.3.967.sh && sudo ./linux-install-1.10.3.967.sh

	$(info Instalando paquetes de linux necesarios (rlwrap leinigen)..)
# A simple read line for command history, only used by clj
	sudo apt install -y rlwrap
#	Leiningen will help you create, build and deploy your Clojure projects.
	sudo apt install -y leiningen

install-docker-compose:
	$(info Instalando Docker Compose..)
# 1. descargamos docker compose
	cd /tmp && \
	curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url  | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
# 2. damos permisos de ejecución y movemos al directorio de los ejecutables
	chmod +x /tmp/docker-compose-linux-x86_64 && sudo mv /tmp/docker-compose-linux-x86_64 /usr/local/bin/docker-compose

# TODO: crear un programming-languages.mk
install-R-language:
	sudo apt install r-base

remove-R-language:
	# removemos el paquete r-base y sus archivos de configuración
	sudo apt-get purge r-base
	# removemos paquetes no necesarios y dependencias 
	sudo apt-get autoremove

install-R-studio:
	sudo apt-get install gdebi-core
	cd /tmp && \
	wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2022.02.2-485-amd64.deb && \
	sudo apt install -f ./rstudio-2022.02.2-485-amd64.deb 

.PHONY: install-dev-packages preinstall-docker install-docker install-docker-compose install-emacs install-spacemacs install-clojure preinstall-vscode ssh-connect ssh-generate-certificate install-R-language remove-R-language install-R-studio
