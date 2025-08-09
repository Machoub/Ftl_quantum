DOCKER_IMG_NAME = quantum_image
DOCKER_CONTAINER_NAME = quantum_container
DOCKER_COMPOSE = docker-compose -f docker-compose.yml
DOCKER_DEPLOY = tools/exec.sh

up:
	$(DOCKER_COMPOSE) up -d --build
	chmod +x $(DOCKER_DEPLOY)
	$(DOCKER_DEPLOY) $(DOCKER_CONTAINER_NAME)

down:
	$(DOCKER_COMPOSE) down

start:
	$(DOCKER_COMPOSE) start

stop:
	$(DOCKER_COMPOSE) stop

ps:
	$(DOCKER_COMPOSE) ps

clean:
	$(DOCKER_COMPOSE) down --rmi all --volumes

fclean:

prune: fclean
	docker system prune --all --force --volumes

.PHONY: up down start stop ps clean fclean prune