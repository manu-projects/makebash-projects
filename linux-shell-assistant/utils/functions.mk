define SED_ESCAPING_SLASH
	sed 's/\//\\\//g' <<< $(1)
endef
