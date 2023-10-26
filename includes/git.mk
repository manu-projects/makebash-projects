GIT_IGNORE_FILES=template encrypted-files-update decrypted-files-update \*.$(SECRET_FILE_EXTENSION)

.gitignore:
ifeq ("$(wildcard .gitignore)", "")
	@touch $@
endif

# - redireccionamos cualquier Estado de Salida de error ($? != 0) del comando `grep` a /dev/null
# porque GNU Make primero evaluará las condiciones de todos los ifeq
# por tanto no se llega a ejecutar el target que crea el archivo
update-gitignore: .gitignore
ifeq ($(shell grep ".$(SECRET_FILE_EXTENSION)" .gitignore 2>/dev/null && echo 1 || echo 0), 0)
	@$(foreach FILE, $(GIT_IGNORE_FILES), \
		echo $(FILE) >> .gitignore; \
	)
endif
