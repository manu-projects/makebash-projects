include $(MODULE_APPS_TUI)/microblogging/config.cfg

# TODO: refactor, target que genere un submodule.cfg en cada directorio
# con el nombre del directorio, y que se agregue al principio de cada Makefile como include

#SUBMODULE_NAME=microblogging
#include $(MODULE_APPS_TUI)/$(SUBMODULE_NAME)/config.cfg

micro-module-name:
	@echo "MODULE_NAME: $(MODULE_NAME)"
	@echo "SUBMODULE_NAME: $(SUBMODULE_NAME)"

# TODO: target para removerlo
# TODO: validación si ya está agregado
# http://packages.azlux.fr/
add-repository-azlux:
	echo "deb [signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian/ stable main" \
	| sudo tee /etc/apt/sources.list.d/azlux.list \
	&& sudo wget -O /usr/share/keyrings/azlux-archive-keyring.gpg  https://azlux.fr/repo.gpg

# TODO:
#verify-gpg-signature-azlux:
# gpg --show-keys --with-fingerprint /usr/share/keyrings/azlux-archive-keyring.gpg

install-microblogging-mastodon-tut: add-repository-azlux
	sudo aptitude update \
	&& sudo aptitude install tut

