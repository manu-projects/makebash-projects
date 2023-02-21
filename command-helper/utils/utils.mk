CURRENT_DIRECTORY=$(shell pwd)

BASH_ALIASES=~/.bash_aliases
# TODO: contemplar cambio de nombre del directorio
BASH_ALIAS=alias ?='make --no-print-directory -C $(CURRENT_DIRECTORY)'
BASH_ALIAS_ESCAPE_SLASH=$(subst /,\/,$(BASH_ALIAS))
