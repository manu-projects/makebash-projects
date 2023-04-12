.DEFAULT_GOAL=help

STDERR=2
NULL_DEVICE=/dev/null

GIT_STATUS=$(shell git status --porcelain)
GIT_REMOTE_EXISTS=$(shell git remote | grep -w $(REPOSITORY_NAME) $(STDERR)>$(NULL_DEVICE))

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

git-log-graph:
	git log --graph --abbrev-commit --decorate --oneline

# Nota (1) necesaria para evitar confusión:
# 1. comando `xargs`:
# - convertimos las lineas de un archivo en parámetros (en realidad sólo sustituye los \n saltos de linea por espacios)
#   (no es común, pero cumple su función mejor que si hicieramos `tr '\n' ' '` porque si no quedaría un espacio no deseado al final)
#
# 2. comando `tr`:
# - transformamos los parámetros devueltos por `xargs` en un formato param1|param2|..
GIT_REMOTES=git remote \
	| awk '!/origin/' \
	| xargs \
	| tr ' ' '|'

# Nota (3) necesaria para evitar confusión:
# 1. comando `grep`:
# - opción (--extendend-regexp): interpretará del formato param1|param2|.. como un patrón de una "Expresión Regular Extendida",
#   seleccionando sólo las lineas que coincida con alguna de esos parámetros (param1 ó param2 ó los que estén entre los pipes)
# - opción (--invert-match): invertirá la selección, devolviendo aquellas que no coincidan con el patrón (el complemento)
# - opción (--word-regexp): seleccionará sólo las lineas que coincidan exactamente con toda la palabra
#
# 2. comando `tr`:
# - formateamos el input para el comando `xargs`, borrando las comas de las lineas seleccionadas por `grep` de `repositorios.cfg`
# (la intención de las comas las usabamos para separar el campo nombre y dirección de cada remoto)
GIT_REMOTOS_PENDIENTES=cat repositorios.cfg \
	| grep --invert-match --word-regexp --extended-regexp `$(GIT_REMOTES)` \
	| tr --delete ','

GIT_REMOTOS_PENDIENTES_CANTIDAD=$(GIT_REMOTOS_PENDIENTES) \
	| wc --lines

# ............................................................................................................................
# PASO (1): Cuando agregamos por primera vez un repositorio al subtree
# ............................................................................................................................
#
# 1. Desde la máquina local ejecutamos `git-update-subtree`
# 2. Chequea si coincide la lista de repositorios remotos locales en la máquina (git remote) con la lista de repositorios.cfg
# 3. Si falta alguno entonces hace un llamado recursivo al mismo Makefile para agregar los que falten (invocando el target git-subtree-add)

##@ Acciones
git-update-subtree: ## agrega un nuevo repositorio remoto (ejecutar desde Maquina Local)
ifneq ($(GIT_REMOTOS_PENDIENTES_CANTIDAD), 0)
	$(info existen remotos pendientes por agregar al git remote)
	@$(GIT_REMOTOS_PENDIENTES) | $(GIT_ADD_REMOTE)
endif

# Nota (2) necesaria para evitar confusión:
# 1. comando `xargs` con la opción (--max-args):
# - limitamos la cantidad de parámetros que `xargs` pase al comando que le asociamos (en este ejemplo al comando `bash`)
#
# 2. comando `bash` con la opción (-c):
# - son necesarias las comillas simples
# - cuando queremos pasarle más de un parámetro (el $0, $1, $2, .. son las variables asignadas a los parámetros recibidos en respectivo orden)
# - Ej. bash -c 'echo pum pum puerta; echo Hola $0, tu edad es $1 y naciste en $2' carlos 10 1990
#
# Ej. si ejecutamos `echo carlos pepe samu fede chimolo po | xargs --max-args=2 bash -c 'echo equipo: $0, $1'`
# el resultado será que ejecutará el comando `bash` 3 veces
#
# equipo: carlos, pepe <- 1º ejecución de `xargs`, le pasa dos parámetros al comando `bash`
# equipo: samu, fede   <- 2º ejecución de `xargs`, le pasa dos parámetros al comando `bash`
# equipo: chimolo, po  <- 3º ejecución de `xargs`, le pasa dos parámetros al comando `bash`
#
# Nota: usamos $$0, $$1, .. en vez de $0, $1, .. para escapar el $ y que GNU Make lo interprete como un caracter y no una macro
GIT_ADD_REMOTE=xargs --max-args=2 \
	bash -c '$(MAKE) --no-print-directory git-subtree-add REPOSITORY_NAME=$$0 REPOSITORY_URL=$$1'

git-subtree-add: check-repository-modifications add-remote-repository
	git subtree add --squash --prefix=$(REPOSITORY_NAME) $(REPOSITORY_NAME) master
#	&& git push origin master

check-repository-modifications:
ifneq ("$(GIT_STATUS)", "")
	$(error Existen cambios en el repositorio local, intente confirmarlos para continuar)
endif

add-remote-repository:
ifeq ("$(GIT_REMOTE_EXISTS)","")
	git remote add $(REPOSITORY_NAME) $(REPOSITORY_URL)
endif

# ............................................................................................................................
# Paso (2): Cuando el repositorio nodo del subtree ya pertenece
# ............................................................................................................................
#
# - Al ejecutar en un Servidor Remoto (Github Actions), los cambios que obtiene de un Repositorio nodo del subtree (git subtree pull)
# "son temporales" porque este script se ejecuta desde una Máquina Virtual (Ej. con ubuntu)
#
# Repositorio remoto nodo perteneciente del Subtree:
# - si su workflow escucha un evento "push" => propaga un evento X + envía datos del repositorio (nombre)
#
# Repositorio que contiene los nodos del Subtree:
# - si su workflow escucha un evento X => éste es el primer target que invoca, para traerse los cambios (pull)
git-subtree-pull: check-remote-status ##  trae cambios de un repositorio (ejecutar desde un Remoto como 1º tarea)
	git subtree pull --prefix=$(REPOSITORY_NAME) $(REPOSITORY_URL) master --squash

check-remote-status:
	git status \
	&& git remote --verbose \
	&& git remote show origin

# ............................................................................................................................
# Paso (3): Cuando el repositorio que contiene los nodos hizo pull del subtree
# ............................................................................................................................
#
# - Al ejecutar en un Servidor Remoto (Github Actions), los cambios quedan en la Máquina Virtual (Ej. Ubuntu),
# por tanto para persistir los cambios debemos subirlos al Servidor Remoto con un (git push)
#
# Repositorio que contiene los nodos del Subtree:
#  - hace (push) subiendo los cambios al repositorio remoto (github.com)
upload-changes-to-remote: ## sube los cambios al remoto (ejecutar desde un Remoto como 2º tarea)
	git push origin master

.PHONY: git-log-graph git-update-subtree git-subtree-add check-repository-modifications add-remote-repository git-subtree-pull upload-changes-to-remote
