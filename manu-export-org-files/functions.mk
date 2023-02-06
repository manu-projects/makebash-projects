define docker_cmd
	@docker-compose $1 $(ARGS) $2
endef

define make_exec
	@$(MAKE) --no-print-directory -f $1 $2
endef

define watch
	@while true; do $(MAKE) -q || $(MAKE) --no-print-directory; sleep 1; done
endef
