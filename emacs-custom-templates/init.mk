# TODO: problemas entre la lectura en la subshell de bash de create-new-project
CONFIG_FILES=init.mk .dir-locals.el

DIRECTORIES:=pages articles
DIRECTORIES:=$(addprefix doc/,$(DIRECTORIES))

PAGES:=articles courses books issues users-dotfiles documentation tasks videos
PAGES:=$(addsuffix .org,$(PAGES))
PAGES:=$(addprefix doc/pages/,$(PAGES))

# TODO: popup de confirmación, de creación de los directorios
$(DIRECTORIES):
	mkdir --verbose --parents $@ \
	&& touch $@/.gitkeep

$(PAGES):
	touch $@

init: $(DIRECTORIES) $(PAGES)

.PHONY: init
