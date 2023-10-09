# Project variables
PROJECT_NAME ?= todobackend
ORG_NAME ?= storager
REPO_NAME ?= todobackend

# Docker-compose files
DEV_COMPOSE_FILE := docker/dev/docker-compose.yaml
REL_COMPOSE_FILE := docker/release/docker-compose.yaml

# Docker Compose Project Name 
REL_PROJECT := $(PROJECT_NAME)$(BUILD_ID)
DEV_PROJECT := $(REL_PROJECT)dev

.PHONY: test build release clean

test: 
	docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) build --no-cache
	docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up agent
	docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up test

build:
	docker-compose -p $(DEV_PROJECT) -f $(DEV_COMPOSE_FILE) up builder

release:
	docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) build --no-cache
	docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) up agent
	docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) run --rm app manage.py collectstatic --no-input
	docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) run --rm app manage.py migrate --no-input
	docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) up test

release-test:
	docker-compose -p $(DEV_PROJECT) -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) up test
clean:
	docker-compose -f $(DEV_COMPOSE_FILE) down -v
	docker-compose -p $(REL_PROJECT) -f $(REL_COMPOSE_FILE) down -v