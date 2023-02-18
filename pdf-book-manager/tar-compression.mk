##@ Tareas de compresión

# Notas:
# 1. $@ es una macro especial que toma el valor del target/objetivo
# 2. $< es una macro especial que toma la primer dependencia de la regla
%.$(COMPRESSED_FILE_EXTENSION): %.$(BOOK_EXTENSION)
	@echo "Comprimiendo $* en $@ .."
	@$(TAR_COMPRESS) $@ $<

# IMPORTANTE:
# %.pdf: %.tar.gz genería una dependencia circular con %.tar.gz: %.pdf
#%.pdf:
%.$(BOOK_EXTENSION):
	$(info Extrayendo $< $*.)
	@$(TAR_EXTRACT) $*.$(COMPRESSED_FILE_EXTENSION)

# IMPORTANTE:
# 1. Es común pensar de forma algorítmica, iterar sobre una lista de nombres de libros
# y ejecutar un comando para comprimir/descomprimir pasandole de parámetro el nombre..
#
# 2. El problema de lo anterior es que se ejecutaría a cada rato comprimiendo/descomprimiendo
# desaprovechando el concepto que tiene GNU Make con los objetivos/target (archivos)..
# es decir "crear el objetivo (archivo) sólo si es necesario",
# por eso dejo comentada la siguiente regla..
#
# comprimir-archivos:
#		$(foreach libro, $(libros),\
#		tar -cvzf $(libro).tar.gz $(libro);)

comprimir-archivos: $(libros_comprimidos) ##
	@echo "Listo! archivos comprimidos!"

extraer-archivos: $(archivos_descomprimidos) ##
	@echo "Listo! archivos extraídos!"

# Breve explicación de los patrones utilizadas con rename
# 1. Transformamos las mayúsculas en minúsculas, reemplazamos los espacios y guión bajo por guión -
#	rename -v 'y/A-Z _/a-z-/' *.pdf
#
# 2. Usamos el ^ como una operación de complemento, removiendo todo caracter NO alfanumérico ó que no sea _.-
#	rename 's/[^a-zA-Z0-9_.-]//g' *.pdf
#
# Notas:
# 1. si al comando rename combinamos los parámetros -n -v imprimirá como quedarían los nombres de los archivos,
# sin generar efecto sobre los archivos (no los renombra)
#
# 2. alternativa al comando rename + la orden (s) sustitución con expresiones de PERL
# es combinar los comandos tr y rename con el parámetro -f, por ejemplo rename -f 'tr/ A-Z/-a-z/' *.pdf
#
# 3. la orden (s) de sustitución del comando rename es similar al del comando SED
# 4. la órden (y) del comando rename, nos permite transformación de Mayúsculas->Minusculas de manera sencilla
formatear-archivos: ## renombra los nombres de los archivos (sugerido previo a comprimir)
	@$(RENAME) 'y/A-Z _/a-z-/' *.$(BOOK_EXTENSION) && \
	$(RENAME) 's/[^a-zA-Z0-9_.-]//g' *.$(BOOK_EXTENSION)
