TEMPLATE_DIR=template
TEMPLATE_DIRS=mutt telegram tut

generate-template: $(TEMPLATE_DIR) $(TEMPLATE_DIRS)

delete-template:
	@rm --verbose --recursive $(TEMPLATE_DIR)

$(TEMPLATE_DIR):
	@mkdir $@

$(TEMPLATE_DIRS):
	@cd $(TEMPLATE_DIR) \
	&& mkdir --verbose --parents $@/configs \
	&& touch $@/configs/$@.$(SECRET_FILE_EXTENSION)
