# Nota: el doble $ es para que NO lo evalué como una macro de GNU Make,
# escapamos el $ para que lo tome como un caracter común
npm_bin=$$(npm bin)
dir_js=./js
typescript_params=--outdir $(dir_js)
typescript_bin=$(npm_bin)/tsc $(typescript_params)

##@ Utilidades
init: install-npm-packages ## Inicializar proyecto
	$(info Proyecto npm inicializado)

# Nota: con --yes en el npm init, nos evita completar los datos de package.json
i install-npm-packages:
	npm init --yes && \
	npm install typescript @types/node --save-dev && \
	npm install rxjs --save-dev

##@ Ejemplos RxJs agrupados por tipo de operador
operadores-de-creacion: ##
	$(typescript_bin) $@.ts && node $(dir_js)/$@.js

operadores-de-filtrado: ##
	$(typescript_bin) $@.ts && node $(dir_js)/$@.js

operadores-de-transformacion: ##
	$(typescript_bin) $@.ts && node $(dir_js)/$@.js

##@ Otros
c clean: clean-js-files ## Limpiar recursos
	rm package*.json
	rm -rvf node_modules

clean-js-files: ## Eliminar archivos transpilados
	rm -vf $(dir_js)/*.js

h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: h help init r c clean i install-npm-packages
