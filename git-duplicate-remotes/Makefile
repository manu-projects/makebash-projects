-include remotes.cfg
-include config.cfg
-include unix-utils.mk

GIT_INITIALIZED=git rev-parse --is-inside-work-tree

GIT_HOOKS = $(wildcard git-hooks/*)
CURRENT_DIRECTORY_NAME = $(notdir $(PWD))
PARENT_DIRECTORY_FILES = $(notdir $(wildcard ../*) $(wildcard ../.*))
EXCLUDED_FILES=$(CURRENT_DIRECTORY_NAME) . ..
PARENT_DIRECTORY_FILES_FILTERED = $(filter-out $(EXCLUDED_FILES), $(PARENT_DIRECTORY_FILES))

.DEFAULT_GOAL=help

ifeq (false,$(GNU_MAKE_PRINT_RECIPE))
AT:=@
endif

# TODO: si ya tiene creado el repositorio remoto dónde se subirán los cambios, trae problemas de merge porque no hacemos pull..
# (suponemos que es su primer push dónde creamos la branch upstream)

##@ Comandos
i init: git-init git-remotes-update git-pull git-push-upstream ## Agrega los repositorios remotos, descarga/sube de los remotos configurados

git-init:
ifneq ($(shell cd .. && $(GIT_INITIALIZED) 2>/dev/null),true)
	$(info Inicializando repositorio de git..)
	$(AT)cd .. \
	&& git init
endif

p git-pull: ## descargar cambios del repositorio only-fetch
	$(info Descargando cambios del repositorio only-fetch..)
	$(AT)cd .. \
	&& git pull only-fetch master

git-remotes-update: .targets/git-remotes

# se va a ejecutar sólo cuando el target y su dependencia (remote.cfg) difieran en el timestamp
.targets/git-remotes: remotes.cfg
	$(info Agregando repositorio remotos a git..)
# 1. creamos el directorio que contiene a éste target (archivo)
	$(AT)$(MKDIR) $(dir $@) && touch $@
# 2. agregamos los repositorios remotos en el directorio padre
	$(AT)cd .. \
	&& git remote add only-fetch $(URL_REMOTO_ONLY_FETCH) \
	&& git remote add origin $(URL_REMOTO_PRIVADO)

# Notas:
# 1. luego de creada una branch (local), ésta requiere asociarla con una branch upstream (remota)
# para subir/descargar cambios al repositorio remoto (operaciones push y fetch)
#
# 2. se crea una única vez la branch upstream (remota) "cuando queremos hacer push ó fetch al repositorio remoto"
# y sólo se asocia una por branch (local)
git-push-upstream: .targets/git-hooks-update
	$(info Configurando repositorio upstream y subiendo cambios al repositorio origin..)
	$(AT)cd .. \
	&& git push --set-upstream origin master

# se va a ejecutar sólo cuando el target y su dependencias difieran en el timestamp
# (una Regla Explícita no me parece viable y una Regla Implícita sería sobrediseño)
.targets/git-hooks-update: $(GIT_HOOKS)
# 1. creamos el directorio que contiene a éste target (archivo)
	$(AT)$(MKDIR) $(dir $@) && touch $@
# 2. copiamos los archivos al directorio padre
	$(AT)$(foreach hook-file, $^,\
		chmod u+x $(hook-file) && \
		$(COPY) $(hook-file) ../.git/hooks; \
	)

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

# Notas:
# 1. el comando `find` de bash sería la alternativa para obtener los archivos del directorio padre e ignorar éste directorio
# 2. Utilizamos el comando TEST (de linux) con la opción -eq porque éste se utiliza para comparar valores numéricos
clean: ## Eliminar archivos del directorio padre
	$(AT)$(BOX_CONFIRM_CLEAN) \
	&& test $(EXIT_STATUS) -eq $(EXIT_STATUS_SUCCESS) \
	&& (echo "Eliminando archivos y directorios del directorio padre.." \
			&& $(RM) .targets/* \
			&& cd .. && $(RM) $(PARENT_DIRECTORY_FILES_FILTERED)) \
	|| true

.PHONY: i init clean h help git-init git-pull git-remotes-update git-push-upstream
