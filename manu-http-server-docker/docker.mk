##@ Comandos de Docker

# TODO: usar una variable compartida para éste Makefile y en el docker-compose
# (podría ser una variable de entorno quizás usando export)
DOCKER_SERVICE=mynodejs

sh: ## Acceder al contenedor con una terminal interactiva
	@docker-compose exec -it $(DOCKER_SERVICE) /bin/sh

up: ##
	@docker-compose up

up-rebuild: ##
	@docker-compose up --force-recreate --build

stop: ##
	@docker-compose stop

down: ##
	@docker-compose down

logs: ##
	@docker-compose logs
