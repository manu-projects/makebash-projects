-include Makefile.cfg
-include docker.mk
-include npm.mk

.DEFAULT_GOAL=help

NPM_BIN_LOCAL_DIRECTORY = $$(npm bin)
NPM_BIN_LOCAL_DIRECTORY_ALTERNATIVE = node_modules/.bin

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

c clean: ## Limpiar recursos (package.json, node_modules/)
	-rm -vf package*.json
	-rm -rvf node_modules/

.PHONY: h help init r run xrun c clean i install-npm-packages
