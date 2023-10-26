include helper.mk
include init.mk

SETUP_CONFIG_FILE=config.org
PROJECT_NAME=emacs-custom-templates

all: emacs-run-tangle create-symbolic-link

##@ Acciones

# - evaluará todos los bloques de código de un archivo .org (Org Mode) y generará un código fuente .el (Elisp)
# - cargar el código fuente .el en la configuración de .spacemacs
emacs-run-tangle: ## generar archivo de configuración en ~/.emacs.d
	emacs --batch \
				--eval "(require 'org)" \
				--eval '(org-babel-tangle-file "${SETUP_CONFIG_FILE}")'

create-symbolic-link: ## generar enlace simbólico de los templates en ~/org-files
	mkdir --verbose --parents ~/org-files/ \
	&& ln --verbose --symbolic ${PWD}/templates ~/org-files/

# TODO: notificar la creación del makefile oculto
# TODO: evaluar necesidad copiar la configuración de .dir-locals.el
create-new-project: ## crear estructura de directorios de templates en un directorio
	read -p "Ingrese la ruta del proyecto a crear/configurar: " NEW_PROJECT_PATH; \
	mkdir --verbose --parents $${NEW_PROJECT_PATH}; \
	cp --verbose init.mk $${NEW_PROJECT_PATH}/.$(PROJECT_NAME).mk ; \
	make --no-print-directory --directory=$${NEW_PROJECT_PATH} --file=.$(PROJECT_NAME).mk init

.PHONY: all emacs-run-tangle create-symbolic-link create-new-project
