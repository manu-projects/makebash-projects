# ---------------------------------------------------------------------------
# - MACROS
.DEFAULT_GOAL := export

MAKE += -f export.mk

DOC_PATH := docs
HTML_PATH := src/views
ROOT_PATH := $(shell pwd)
COMPONENTS_PATH := src/components
DOC_SUBDIRS := $(sort $(dir $(wildcard $(DOC_PATH)/*/)))
HTML_SUBDIRS := $(subst $(DOC_PATH),$(HTML_PATH),$(DOC_SUBDIRS))
SUBDIRS := $(DOC_SUBDIRS) $(HTML_SUBDIRS)

DOC_FILES := $(foreach dir, $(DOC_SUBDIRS), $(wildcard $(dir)*.org))
HTML_FILES := $(subst $(DOC_PATH),$(HTML_PATH), $(DOC_FILES))
HTML_FILES := $(patsubst %.org,%.html, $(HTML_FILES))

RM := rm -rfv
MKDIR := mkdir -vp

# ---------------------------------------------------------------------------
# PANDOC CONFIG

PANDOC_PARAMS =  \
	--from=org --to=html --out=$@ --table-of-contents --toc-depth 3 \
	--resource-path=$(ROOT_PATH) \
	--template $(COMPONENTS_PATH)/template.html

# si no está definida la variable de entorno, le definimos otro valor
HOST_ENV ?= manjaro

ifeq ($(HOST_ENV), container)
PANDOC_CMD = @pandoc $(PANDOC_PARAMS) $<
else
PANDOC_CMD = \
	@docker run --rm \
	--volume "$(ROOT_PATH):/data" \
	--user $(shell id -u):$(shell id -g) \
	pandoc/minimal $(PANDOC_PARAMS) $<
endif

# ---------------------------------------------------------------------------
# - REGLAS

export: $(SUBDIRS) $(HTML_FILES)

watch:
	$(info Observando cambios en la documentación para exportar...)
	$(call watch)

$(SUBDIRS):
	$(info Creando estructura de directorios)
	@$(MKDIR) $@

$(HTML_FILES):$(HTML_PATH)/%.html:$(DOC_PATH)/%.org
	$(info Exportando a html el fichero $(subst $(DOC_PATH)/,,$<))
	$(PANDOC_CMD)

clean:
	$(info Borrando archivos html...)
	@-$(RM) $(HTML_FILES)

.PHONY: watch export clean

-include functions.mk
