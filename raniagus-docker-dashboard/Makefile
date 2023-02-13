include .env

ifndef IMAGE_TAG
$(error IMAGE_TAG variable is not set. Ensure that an .env file is created and properly configured.)
endif

CONTAINERS_RUNNING != docker container ls -q --filter ancestor=$(IMAGE_TAG)
CONTAINERS != docker container ls -aq --filter ancestor=$(IMAGE_TAG)

all: build run

build:
	docker build . --rm -t $(IMAGE_TAG)

run:
	docker run -d --init --env-file=./.env $(if $(PORT),-p $(PORT):$(PORT)) $(IMAGE_TAG)

stop:
ifdef CONTAINERS_RUNNING
	docker container stop $(CONTAINERS_RUNNING)
endif

clean: stop
ifdef CONTAINERS
	-docker container rm $(CONTAINERS)
endif
	-docker rmi $(IMAGE_TAG)

exec:
	docker exec -it $(word 1,$(CONTAINERS_RUNNING)) /bin/ash

logs:
	docker logs $(word 1,$(CONTAINERS_RUNNING)) -f

.PHONY: all build run stop clean exec logs
