gpg-agent-init: gpg-agent-update-config gpg-agent-update-environment

gpg-agent-update-config:
	$(COPY) $(MODULE_CRYPTO_CONFIGS)/gpg.conf $${HOME}/.gnupg/gpg.conf \
	&& $(COPY) $(MODULE_CRYPTO_CONFIGS)/gpg-agent.conf $${HOME}/.gnupg/gpg-agent.conf

# TODO: no se puede detener de manera correcta el Agente SSH (ssh-agent),
# temporalmente se ejecutará en el ~/.bashrc (ejecutando el script por cada nueva shell de bash)
# en vez de ~/.bash_profile que sería el ideal ya que se ejecuta una única vez, al iniciar el sistema
gpg-agent-update-environment:
	$(COPY) $(MODULE_CRYPTO_SCRIPTS)/gpg-agent-environment.sh $${HOME}/.gnupg/gpg-agent-environment.sh \
	&& chmod u+x $${HOME}/.gnupg/gpg-agent-environment.sh \
	&& cat $(MODULE_CRYPTO_SCRIPTS)/gpg-agent-bash.sh >> $${HOME}/.bashrc

gpg-agent-reload-config:
	gpg-connect-agent reloadagent /bye

# TODO: boxes educativo diciendo que previamente debemos crear una Clave Secundaria Pública (sub, public subkey)
# con la funcionalidad de autenticación ([A]uthenticate capability),
# exportarla con formato ssh-key y agregarla en nuestra cuenta de Github (https://github.com/settings/ssh/new)
#
# TODO: boxes educativo, diciendo que también podemos listar las clave publicas de las identidades manejadas por el Agente GPG
# con ssh-add -L
gpg-agent-export-ssh-subkey-with-auth-capability:
	$(ASK_GPG_UID_EMAIL) \
	&& gpg --export-ssh-key $${GPG_UID_EMAIL}

# TODO: boxes educativo diciendo que previamente debemos crear una Clave Secundaria Pública (sub, public subkey)
# con la funcionalidad de autenticación ([A]uthenticate capability),
# exportarla con formato ssh-keyy y agregarla en nuestra cuenta de Github (https://github.com/settings/ssh/new)
gpg-agent-check-ssh-github:
	ssh -T git@github.com

# TODO: boxes educativo diciendo que previamente debemos crear una Clave Secundaria Pública (sub, public subkey)
# con la funcionalidad para firmar ([S]ign capability),
# exportarla con formato ascii (--armor) y agregarla en nuestra cuenta de Github (https://github.com/settings/gpg/new)
gpg-add-signature-to-github-commits: gpg-enable-signature-from-github-commits
	$(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& git config --global user.signingkey $${GPG_PUBLIC_KEY_ID}

gpg-enable-signature-from-github-commits:
	git config --global commit.gpgsign true

gpg-disable-signature-from-github-commits:
	git config --global commit.gpgsign false

# TODO: refactor
# TODO: boxes educativo, de que éste ID se puede utilizar en la configuración de git para los commits firmados
# con nuestra clave secundaria privada (ssb, secret subkey)
gpg-print-id-subkey-with-sign-capability:
	$(ASK_GPG_UID_EMAIL) \
	&& gpg --list-secret-keys $${GPG_UID_EMAIL} \
	| awk '/^ssb.*\[S\]/' \
	| tr --squeeze-repeats [[:space:]] ',' \
	| cut --delimiter=',' --fields=2 \
	| cut --delimiter='/' --fields=2

# TODO: boxes educativo diciendo que previamente debemos crear una Clave Secundaria Pública (sub, public subkey)
# con la funcionalidad de autenticación ([A]uthenticate capability),
# exportarla con formato ssh-key y agregarla en nuestra cuenta de Github (https://github.com/settings/ssh/new)
gpg-agent-list-subkeys-with-auth-capability:
	ssh-add -L

# TODO: boxes educativo diciendo que previamente debemos crear una Clave Secundaria Pública (sub, public subkey)
# con la funcionalidad de autenticación ([A]uthenticate capability),
# exportarla con formato ssh y agregarla en nuestra cuenta de Github (https://github.com/settings/ssh/new)
#
# TODO: boxes educativo, avisando de comprobar que se agregó la Clave Secundaria en el Agente GPG con `ssh-add -l`
# que imprime un listado de los fingerprint de todas las identidades que maneja el Agente GPG con el protocolo SSH
# (los fpr de las Claves de nuestro Anillo del Claves de GPG que previamente agregamos su keygrip en ~/.gnupg/sshcontrol)
gpg-agent-add-subkey-with-auth-capability:
	$(ASK_GPG_UID_EMAIL) \
	&& gpg --with-keygrip -k $${GPG_UID_EMAIL} \
	| awk '/^sub.*\[A\]/{getline; print $$0;}' | tr -d ' ' | sed -E 's/Keygrip=(.*)/\1/g' \
	| tee --append $${HOME}/.gnupg/sshcontrol

# TODO: documentar lo siguiente
# TODO: esto captura el valor del keygrip, debería guardarlo en el clipboard
# awk '/^sub.*\[A\]/{getline; print $$0;}' | tr -d ' ' | sed -E 's/Keygrip=(.*)/\1/'
#
# TODO: con esto mostramos por si acaso el keygrip de que subkey se estaría copiando
# awk '/^sub.*\[A\]/{print $$0; getline; print $$0;}'
