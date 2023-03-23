##@ Tareas de compresión

%.$(COMPRESSED_FILE_EXTENSION): %.$(BOOK_EXTENSION)
	@echo "Comprimiendo $* en $@ .."
	@$(TAR_COMPRESS) $@ $<

# IMPORTANTE:
# %.pdf: %.tar.gz genería una dependencia circular con %.tar.gz: %.pdf
%.$(BOOK_EXTENSION):
	$(info Extrayendo $< $*.)
	@$(TAR_EXTRACT) $*.$(COMPRESSED_FILE_EXTENSION)

comprimir-archivos: $(libros_comprimidos) ##
	@echo "Listo! archivos comprimidos!"

extraer-archivos: $(archivos_descomprimidos) ##
	@echo "Listo! archivos extraídos!"

formatear-archivos: ## renombra los nombres de los archivos (sugerido previo a comprimir)
	@$(RENAME) 'y/A-Z _/a-z-/' *.$(BOOK_EXTENSION) && \
	$(RENAME) 's/[^a-zA-Z0-9_.-]//g' *.$(BOOK_EXTENSION)
