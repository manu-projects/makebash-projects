sshclient-github-check:
	ssh -vT git@github.com

# TODO: boxes avisando que buscará la clave agregando el prefijo github_
# (no sería necesario agregar github_ as input)
sshagent-github-add-privatekey-file:  # requiere el archivo de la privkey en ~/.ssh/
	$(ASK_SSH_KEY_NAME) \
	&& ssh-add $(SSH_CLIENT_DIR)/$${SSH_KEY_NAME}

# TODO: boxes diciendo que ya se puede borrar el archivo físico de la clave privada de ~/.ssh
# que la clave ahora está más segura utilizando `pass`, porque ya no pueden robarnos el archivo físico
# y para acceder necesita la clave gpg asociada a `pass` + passphrase de la clave privada si tuviera
# (sugerir el target de Makefile para borrarlo)
#
# TODO: lanzar una excepción más descriptiva que el `exit 1`
sshagent-add-github-privatekey-from-password-manager:
	CATEGORY_NAME=$(MENU_ASK_PASS_CATEGORY); \
	[[ -z "$${CATEGORY_NAME}" ]] && exit 1 \
	|| ssh-add - <<< "$(PASS_ASK_GITHUB_PRIVKEY)"
