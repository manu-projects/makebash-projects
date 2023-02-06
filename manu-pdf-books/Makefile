#directorios = $(sort $(dir $(wildcard ./*/.)))
libros = $(wildcard *.pdf)
archivos= $(wildcard *.tar.gz)

libros_comprimidos = $(patsubst %.pdf, %.tar.gz, $(libros))
archivos_descomprimidos = $(patsubst %.tar.gz, %.pdf, $(archivos))

# TODO: esto no funcionaría..
#archivos:=$(foreach libro, $(libros), $(libro).tar.gz)

h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

# TODO: existe una dependencia circular
%.tar.gz: %.pdf
	@echo Comprimiendo $< ..
	tar -cvzf $@ $<
#	tar -cvzf $*.tar.gz $*.pdf

# TODO: existe una dependencia circular
%.pdf: %.tar.gz
	@echo Extrayendo $< $*.
	tar -xvf $<
#	tar -xvf $*.tar.gz

##@ Comandos
crear-categoria: ## Ex. make crear-categoria NAME=topologias-de-red
	mkdir $(NAME) && \
	cp .template.mk $(NAME)/Makefile

comprimir-archivos: $(libros_comprimidos) ##

extraer-archivos: $(archivos_descomprimidos) ##

# TODO: no soluciona la dependencia circular, por eso comentamos el $* de los targets de arriba
#extraer: $(archivos:.pdf=.tar.gz)
#comprimir: $(libros:.tar.gz=.pdf)

formatear-archivos: ##
	rename -f 'tr/ A-Z/-a-z/' -- *.pdf && \
	rename 's/[^a-zA-Z0-9_.-]//g' *.pdf

listar-libros: ##
	lsd -lh **/*.pdf

##@ Utilidades
clean-pdf-files: ##
	rm -vf *.pdf

clean-tar-files: ##
	rm -vf *.tar.gz

.PHONY: h help formatear-archivos comprimir-archivos extraer-archivos crear-categoria listar-libros
