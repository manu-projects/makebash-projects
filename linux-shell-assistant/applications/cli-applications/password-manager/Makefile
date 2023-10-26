# TODO: después hay que usar la macro de la ruta absoluta
# en el Makefile principal dónde se definen los módulos
include $(MODULE_APPS_CLI)/password-manager/*.mk

# TODO: mover una categoría de lenguajes de programación
install-language-golang:
	sudo aptitude install golang-go

install-password-manager-gopass: install-language-golang
	sudo aptitude install gopass
