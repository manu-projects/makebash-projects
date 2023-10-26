include utils/helper.mk
include utils/utils-unix.mk
include utils/utils.mk

DIRECTORIES=$(shell cat directories.cfg | xargs)

LOGSEQ_TEMPLATE_DIR=logseq-template
PAGES_PATH=$(LOGSEQ_TEMPLATE_DIR)/pages

TEMPLATES_PAGE_FILE=pages/Templates.org
LOGSEQ_CONFIG_FILE=logseq/config.edn

##@ Operaciones
# Nota: no utilizamos los directorios como targets, porque dejamos elegir al usuario el nombre del directorio
create-logseq-workflow: ##
	@read -p "Ingrese la ruta del nuevo flujo de trabajo: " NEW_WORKFLOW_PATH; \
	mkdir --parents $${NEW_WORKFLOW_PATH}; \
	@read -p "Ingrese el nombre del nuevo flujo de trabajo: " NEW_WORKFLOW_NAME; \
	$(RSYNC) logseq-template/ $${NEW_WORKFLOW_PATH}/

update-config-workflows: $(addsuffix /$(LOGSEQ_CONFIG_FILE).backup,$(DIRECTORIES)) $(addsuffix $(LOGSEQ_CONFIG_FILE),$(DIRECTORIES)) ##
update-templates-workflows: $(addsuffix /$(TEMPLATES_PAGE_FILE),$(DIRECTORIES)) ##

# Ejemplo de como funciona el siguiente target
# prueba: a.txt b.txt
#
# a.txt b.txt: archivo.txt
#	cat $< > $@
#

# Nota: dependencia del objetivo update-template-workflows
$(addsuffix /$(TEMPLATES_PAGE_FILE),$(DIRECTORIES)): $(LOGSEQ_TEMPLATE_DIR)/$(TEMPLATES_PAGE_FILE)
	@$(WHIPTAIL_CONFIRM_COPY_ACTION) \
	&& echo "Copiando $@ .." && cat $< > $@ \
	|| echo "Confirmación cancelada"

# - Nota: dependencia del objetivo update-config-workflows
$(addsuffix /$(LOGSEQ_CONFIG_FILE).backup,$(DIRECTORIES)): $(LOGSEQ_TEMPLATE_DIR)/$(LOGSEQ_CONFIG_FILE)
	@$(WHIPTAIL_CONFIRM_COPY_ACTION) \
	&& mv --verbose $(subst .backup,,$@) $@ \
	|| echo "Confirmación cancelada"
#
# Otra alternativa a la acción del target anterior, pero no muy amigable a la vista..
# @echo $@  | sed s/.backup// | xargs --verbose --replace=% mv --verbose % $@

$(addsuffix $(LOGSEQ_CONFIG_FILE),$(DIRECTORIES)): $(LOGSEQ_TEMPLATE_DIR)/$(LOGSEQ_CONFIG_FILE)
	@$(WHIPTAIL_CONFIRM_COPY_ACTION) \
	&& echo "Copiando $@ .." && cat $< > $@ \
	|| echo "Confirmación cancelada"

# Nota: podría tener una lógica similar al template file y config file,
# considero que agrega complejidad innecesaria
copy-pages-to-workflows: ##
	@$(WHIPTAIL_CONFIRM_COPY_ACTION) \
	&& cat directories.cfg | xargs --verbose --replace=% find % -maxdepth 0 -exec $(RSYNC) $(PAGES_PATH) % \; \
	|| echo "Confirmación cancelada"

.PHONY: create-logseq-workflow update-templates-workflows update-config-workflows copy-pages-to-workflows
