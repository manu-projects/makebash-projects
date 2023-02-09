-include Makefile.cfg

.DEFAULT_GOAL=help

NPM_BIN_LOCAL_DIRECTORY = $$(npm bin)
NPM_BIN_LOCAL_DIRECTORY_ALTERNATIVE = node_modules/.bin

##@ Comandos
init: install-npm-packages ## Inicializar proyecto
	$(info Proyecto npm inicializado)

check-npm-bin-directory:
ifneq ("$(wildcard $(NPM_BIN_LOCAL_DIRECTORY))", "")
	$(error "No existe la carpeta de npm, intentá ejecutar make install-npm-packages")
endif

# Nota: el doble $ es para que NO lo evalué como una macro de GNU Make
r run: ## Ejecutar Servidor HTTP
	@$(NPM_BIN_LOCAL_DIRECTORY)/$(PACKAGE_HTTP_SERVER) $(HTTP_SERVER_PARAMS)

# Nota: alternativa, si el otro target run no funcione
ra run-alternative: ## Ejecutar Servidor HTTP (Exportando ./node_modules/ como variable de entorno)
	$(info Agregando la ruta node_modules/.bin como variable de entorno en $$PATH de ésta shell..)
	@export PATH="$$PATH:$(NPM_BIN_LOCAL_DIRECTORY_ALTERNATIVE)" && \
	$(PACKAGE_HTTP_SERVER) $(HTTP_SERVER_PARAMS)

##@ Comandos Extra
# Nota: con --yes en el npm init, nos evita completar los datos de package.json
i install-npm-packages: ## Instalar paquetes npm
	@npm init --yes && npm install $(NPM_PACKAGES) --save-dev

u update-npm-packages: ## Actualizar paquetes npm
	@npm install $(NPM_PACKAGES) --save-dev

##@ Utilidades
c clean: ## Limpiar recursos
	@-rm -vf package*.json
	@-rm -rvf node_modules/

h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: h help init r run ra run-alternative c clean i install-npm-packages u update-npm-packages
