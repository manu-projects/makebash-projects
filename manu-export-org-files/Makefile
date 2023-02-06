all: down up

b build:
	$(info Construyendo imagenes...)
	$(call docker_cmd, build)

u up:
	$(info Ejecutando contenedor/es...)
	$(call docker_cmd, up)

p pause:
	$(info Pausando contenedor/es...)
	$(call docker_cmd, pause)

s stop:
	$(info Deteniendo contenedor/es...)
	$(call docker_cmd, stop)

d down:
	$(call docker_cmd, down)

l logs:
	$(call docker_cmd, logs --tail 50 --follow)

sh:
	$(info Accediendo al contentendor en modo interactivo...)
	$(call docker_cmd, exec, /bin/sh)

npm:
	@docker-compose exec $(CONTAINER_WEBAPP) npm $(ARGS)

export:
  $(call make_exec, export.mk, watch)

.PHONY: all sh npm export b build u up s stop l logs d down clean p pause

-include Makefile.conf
-include functions.mk
