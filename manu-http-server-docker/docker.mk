##@ Comandos de Docker
up: ##
	docker-compose up

up-rebuild: ##
	docker-compose up --force-recreate --build

stop: ##
	docker-compose stop

down: ##
	docker-compose down

logs: ##
	docker-compose logs
