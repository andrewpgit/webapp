BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
TAG  ?=$(BRANCH)
NAME ?=app
REPO ?=andrewpgit
VERSION ?=0.0.1
IMAGE_NAME ?=$(REPO)/$(NAME)
.PHONY: help

help:
	@echo ""
	@echo "rebuild 	- build a Docker image without cache"
	@echo "build 	- build a Docker image"
	@echo "release 	- release a Docker image to Docker Hub"
	@echo "stop	- stop and remove container"
	@echo ""

build:
	@echo "Build docker image $(NAME):$(TAG)"
	docker build -t $(IMAGE_NAME):$(TAG) .

rebuild:
	@echo "Build the container without caching"
	docker build  --no-cache -t $(IMAGE_NAME):$(TAG) .

run:
	@echo "Run the container"
	docker run -d --name=$(NAME)_$(TAG) -p 8080:8080 $(IMAGE_NAME):$(TAG)

stop:
	@echo "Stop and remove a running container"
	docker stop $(NAME)_$(TAG); docker rm $(NAME)_$(TAG)

release:
	@echo "Push Docker to Docker registry"
	docker push $(IMAGE_NAME):$(TAG)

delete:
	@echo "Remove docker image"
	docker images -q  -f label=app=nodejs | xargs -I ARGS docker rmi ARGS
