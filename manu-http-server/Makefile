package-http-server = light-server
package-params=-s . -p 8000
npm_bin=$$(npm bin)

##@ Utilidades
init: install-npm-packages ## Inicializar proyecto
	$(info Proyecto npm inicializado)

# Nota: el doble $ es para que NO lo evalué como una macro de GNU Make
r run: ## Ejecutar Servidor HTTP
	$(npm_bin)/$(package-http-server) $(package-params)

# Nota: alternativa, si el otro target run no funcione
xrun: ## Ejecutar Servidor HTTP (alternativa)
	export PATH="./node_modules/.bin:$$PATH" && \
	$(package-http-server) $(package-params)

# Nota: con --yes en el npm init, nos evita completar los datos de package.json
i install-npm-packages: ## Instalar paquetes npm
	npm init --yes && npm install $(package-http-server) --save-dev

##@ Otros
c clean: ## Limpiar recursos
	rm package.json
	rm -rvf node_modules

h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: h help init r run xrun c clean i install-npm-packages
