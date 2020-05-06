BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
TAG  ?=$(BRANCH)
NAME ?=app
REPO ?=andrewpgit
VERSION ?=0.0.1
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
	docker build -t $(REPO)/$(NAME):$(TAG)-$(VERSION) .

rebuild: 
	@echo "Build the container without caching"
	docker build  --no-cache -t $(REPO)/$(NAME):$(TAG)-$(VERSION) .

run: 
	@echo "Run the container"
	docker run -d --name=$(NAME)_$(TAG) -p 8080:8080 $(REPO)/$(NAME):$(TAG)-$(VERSION)

stop: 
	@echo "Stop and remove a running container"
	docker stop $(NAME)_$(TAG); docker rm $(NAME)_$(TAG)

release:
	@echo "Push Docker to Docker registry"
	docker push $(REPO)/$(NAME):$(TAG)-$(VERSION)

delete: 
	@echo "Remove docker image"
	docker images -q  -f label=app=nodejs | xargs -I ARGS docker rmi ARGS
