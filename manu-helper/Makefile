CURRENT_DIRECTORY = $(shell pwd)
BASH_ALIASES = ~/.bash_aliases
COMANDOS = $(subst .txt,,$(wildcard *.txt))

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

l lista: ## Lista de comandos
	@echo 'Lista de comandos'
	@$(foreach comando,$(COMANDOS), \
		echo ' -' $(comando);\
	)

$(COMANDOS):
	@cat $@.txt

%:
	$(error NO existe el comando)

init:
	@echo "alias ?='make --no-print-directory -C $(CURRENT_DIRECTORY)'" >> $(BASH_ALIASES) && \
	chmod u+x update-bash-aliases && \
	./update-bash-aliases

.PHONY: init h help l lista
