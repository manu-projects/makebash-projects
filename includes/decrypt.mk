ENCRYPTED_SECRETS_FROM_DIRS?=

# comando `find`
# - soporta buscar en varias rutas
# - buscará hasta el máximo nivel de profundidad del árbol de directorios de cada ruta
# - con la opción (--maxdepth) restringimos el nivel máximo de profundidad
ifneq ("$(wildcard $(LIST_SECRET_DIRECTORIES))", "")
ENCRYPTED_SECRETS_FROM_DIRS=$(shell \
	find $(LIST_SECRET_DIRECTORIES) -type f -name '*.$(ENCRYPTED_SECRET_EXTENSION)' \
	| awk '!/^\#/' \
	| tr '\n' ' ' \
)
endif

# $(subst palabra_buscada, palabra_nueva, texto)
DECRYPTED_SECRETS_FROM_DIRS=$(subst .$(ENCRYPTED_SECRET_EXTENSION),.$(SECRET_FILE_EXTENSION),$(ENCRYPTED_SECRETS_FROM_DIRS))

DECRYPTED_SECRETS=$(sort $(LIST_SECRET_FILES) $(DECRYPTED_SECRETS_FROM_DIRS))

# comando `tee`
# - redirecciona la salida de otro comando a la pantalla (stdout) y como texto a un archivo
# - con la opción (--append) inserta texto a un archivo sin borrar su contenido (similar al operador >>)
# - sin la opción (--append) inserta texto a un archivo borrando su contenido (similar al operador >)
decrypted-files-update: $(DECRYPTED_SECRETS)
	@echo "$(DATE_NOW) $?" | tee --append $@

# Regla Implícita de Patrón
%.$(SECRET_FILE_EXTENSION):
	@echo "desencriptando $* como $@"
	@gpg \
		--output="$@" \
		--decrypt \
		--recipient="$(GPG_SUBKEY_ENCRYPTED_ID)" \
		$*.$(ENCRYPTED_SECRET_EXTENSION)
