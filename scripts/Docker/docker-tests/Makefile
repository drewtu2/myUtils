# This a make file that allows us to easily build and run docker containers. 
# This relies on a config file `config.env` to set some environment variables that are used in this 
# makefile. 
# Referenced from: https://gist.github.com/mpneuried/0594963ad38e68917ef189b4e6a269db

# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`
# dpl ?= deploy.env
# include $(dpl)
# export $(shell sed 's/=.*//' $(dpl))

# grep the version from the mix file
VERSION=$(shell ./version.sh)
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))


# DOCKER TASKS
# Build the container
build: $(DOCKERFILE_PATH) ## Build the container
	$(info Building $(APP_NAME) from $(DOCKERFILE_PATH))
	docker build -t $(APP_NAME) -f $(DOCKERFILE_PATH) .

build-nc: $(DOCKERFILE_PATH) ## Build the container without caching
	docker build --no-cache -t $(APP_NAME) -f $(DOCKERFILE_PATH) .

run: build ## Run container on port configured in `config.env`
	docker run -i -t --rm \
		--env-file=./config.env \
		-p=$(PORT):$(PORT) \
		--name="$(APP_NAME)" \
		--mount type=bind,source="$(ROOT_DIR)/$(SOURCE)",target=$(TARGET) \
		--net=host \
		--env="DISPLAY" \
		--volume="$(HOME)/.Xauthority:/root/.Xauthority:rw" \
		$(APP_NAME)


up: build run ## Run container on port configured in `config.env` (Alias to run)

stop: ## Stop and remove a running container
	docker stop $(APP_NAME); docker rm $(APP_NAME)

release: build-nc publish ## Make a release by building and publishing the `{version}` ans `latest` tagged containers to ECR
