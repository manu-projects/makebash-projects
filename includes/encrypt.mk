# operador ?=
# ------------
#
# - operador condicional de GNU Make
# - asigna un Valor si y sólo si la Variable NO tiene un Valor asignado
#
# LIST_SECRET_DIRECTORIES?=
SECRET_FILES_FROM_DIRS?=

# nos permite probar el programa con templates, previo a incluir en un proyecto real
ifeq ("$(wildcard $(DIR_BASE))","")
SECRET_FILES=secret-files.list
SECRET_DIRECTORIES=secret-directories.list
else
SECRET_FILES=$(DIR_BASE)/secret-files.list
SECRET_DIRECTORIES=$(DIR_BASE)/secret-directories.list
endif

# TODO: refactor nombre, presta confusión entre LIST_SECRET_FILES y SECRET_FILES
LIST_SECRET_FILES=$(shell \
	cat $(SECRET_FILES) \
	| $(AWK_REMOVE_COMMENTS) \
	| $(TR_REMOVE_NEWLINE) \
)

# TODO: refactor nombre
LIST_SECRET_DIRECTORIES=$(shell \
	cat $(SECRET_DIRECTORIES) \
	| $(AWK_REMOVE_COMMENTS) \
	| $(TR_REMOVE_NEWLINE) \
)

ifneq ("$(wildcard $(LIST_SECRET_DIRECTORIES))", "")
SECRET_FILES_FROM_DIRS=$(shell \
	find $(LIST_SECRET_DIRECTORIES) -type f -name '*.$(SECRET_FILE_EXTENSION)' \
	| $(AWK_REMOVE_COMMENTS) \
	| $(TR_REMOVE_NEWLINE) \
)
endif

# la función sort de GNU Make, ordena removiendo las palabras duplicadas
SECRETS=$(sort $(LIST_SECRET_FILES) $(SECRET_FILES_FROM_DIRS))

# $(subst palabra_buscada, palabra_nueva, texto)
ENCRYPTED_SECRETS=$(subst .$(SECRET_FILE_EXTENSION),.$(ENCRYPTED_SECRET_EXTENSION),$(SECRETS))

# Target de Seguimiento
# --------------------
#
# - marcamos el último momento que se produjo un evento (encriptado de ficheros)
# - por lo general éste target tiende a ser un fichero vacío, pero preferimos que se comporte como un log
# - compara el timestamp de modificación del target (fichero) con el de los ficheros encriptados,
# provocando que compare el timestamp de modificación de los ficheros encriptados con el de los secretos
encrypted-files-update: $(ENCRYPTED_SECRETS)
	@echo "$(DATE_NOW) $?" | tee --append $@

# Regla Implícita de Patrón
# -------------------------
# - utilizamos Encriptación Asimétrica (requiere un Par de Claves, se recomienda que la Clave Privada tenga una "frase de paso")
# - compara el timestamp de modificación del patrón de ambos archivos (%.ext1 y %.ext2)
# - encripta el secreto sólo si el timestamp de modificación del archivo secreto es más reciente que el encriptado
#
# Macros especiales de GNU Make
# -----------------------------
# - $@	se expande con el nombre del target/objetivo a crear (el secreto encriptado)
# - $*	se expande con el nombre de la dependencia que tiene un timestamp de modificación más reciente que el target/objetivo
%.$(ENCRYPTED_SECRET_EXTENSION): %.$(SECRET_FILE_EXTENSION)
	@echo "encriptando $*.$(SECRET_FILE_EXTENSION) como $@"
	@gpg \
		--output="$@" \
		--encrypt \
		--recipient="$(GPG_SUBKEY_ENCRYPTED_ID)" \
		$*.$(SECRET_FILE_EXTENSION)

# - el comando `shred` reduce el riesgo de que obtengan los datos de los archivos secretos con "programas forénses"
safely-remove-secrets:
	@shred --iterations=7 --verbose --zero $(SECRETS) \
	&& rm --verbose --force $(SECRETS)
