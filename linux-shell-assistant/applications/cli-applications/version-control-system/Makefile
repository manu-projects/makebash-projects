ASK_GIT_USER_NAME=read -p "Escriba su nombre de usuario de git:"
ASK_GIT_USER_EMAIL=read -p "Escriba la dirección de e-mail asociada:"
ASK_GIT_DEFAULT_BRANCH=read -p "Escriba el nombre de la rama por default (Ej. master, main, ..):"

install-vcs-git:
	sudo aptitude install git

configure-vcs-git:
	$(ASK_GIT_USER_NAME) GIT_USER_NAME \
	&& $(ASK_GIT_USER_EMAIL) GIT_USER_EMAIL \
	&& $(ASK_GIT_USER_NAME) GIT_DEFAULT_BRANCH \
	&& git config --global user.name "$${GIT_USER_NAME}" \
	&& git config --global user.email  "$${GIT_USER_EMAIL}"\
	&& git config --global init.defaultBranch  "$${GIT_DEFAULT_BRANCH}"
