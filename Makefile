# deps :
##	sudo apt install docker-buildx
###################################################################################
################################  params  #########################################
###################################################################################
TAR_FILE=pxe_clonzilla.tar
TAR_PATH := $(shell pwd)
IMAGE_NAME=pxe_clonzilla_image:latest
CONTAINER_NAME=pxe_clonzilla_container
DOCKERFILE ?= Dockerfile
###################################################################################
############################# save docker script ##################################
###################################################################################
define SAVE_CHANGES_SCRIPT
#!/bin/bash
# This script commits the container and saves it to a tar file.
# It is intended to be run from within the Docker container.
docker commit $$(hostname) $(IMAGE_NAME)
docker save -o /save/$(TAR_FILE) $(IMAGE_NAME)
endef
export SAVE_CHANGES_SCRIPT
###################################################################################
###################################  help #########################################
###################################################################################
.PHONY: all help build load run run-gpu save clean fullclean
help:
	@echo "Usage:"
	@echo "  make [target] [SHARE=]"
	@echo ""
	@echo "Targets:"
	@echo "  help       - Display this help message (default target)."
	@echo "  build      - Build the Docker image and save tar file // default Dockerfile is ubu22."
	@echo "  build DOCKERFILE=<XXX>  - Build image and save tar with input Dockerfile."
	@echo "  run        - Run the Docker container with GUI support but no GPU. Optionally specify SHARE."
	@echo "  run-gpu    - Run the Docker container with GUI and GPU support. Optionally specify SHARE."
	@echo "  save       - Save changes made in the container back to the Docker image and tar file."
	@echo "  load       - Load Docker image."
	@echo "  clean      - Clean up the Docker environment by removing the container, image, and tar file."

all: help
###################################################################################
############################### Dockerfile DEFAULT (ubu22) ########################
###################################################################################
define DOCKERFILE_CONTENT
# Use a base image
FROM ubuntu:22.04 AS common-base

# Set environment variables to avoid timezone prompt
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Etc/UTC

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    docker.io \
    software-properties-common \
    tzdata \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up a user with no password sudo
RUN mkdir -p /etc/sudoers.d && \
    useradd -m user -s /bin/bash && \
    echo "user:user" | chpasswd && \
    echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

# Ensure the shared directory exists
RUN mkdir -p /home/user/shared && \
    chown -R user:user /home/user/shared

USER user
WORKDIR /home/user

# Add .local/bin to PATH for user-specific scripts
ENV PATH="/home/user/.local/bin:${PATH}"

# Set the default shell to bash
CMD ["/bin/bash"]

# Extend the common-base to install additional packages
FROM common-base AS final

RUN sudo apt-get update && sudo apt-get install -y \
    vim \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*
endef
export DOCKERFILE_CONTENT


define DOCKERFILE_APPEND
## common logic to append to Dockerfile
USER root
RUN mkdir -p /local 
COPY save_changes.sh /usr/local/bin/save_changes
RUN  chmod +x /usr/local/bin/save_changes
## global aliases
RUN echo "alias c='clear'" | tee -a /etc/bash.bashrc
RUN echo "alias tit='source /local/tit.sh $$1'" | tee -a /etc/bash.bashrc
RUN echo "tit $(CONTAINER_NAME)" | tee -a /home/user/.bashrc
## tit
RUN cat > /local/tit.sh <<'EOSCRIPT'
#!/usr/bin/env bash
tit=$$1
PS1="\[\e]0;$$tit\a\]${debian_chroot:+($$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$$ "
EOSCRIPT
RUN chmod +x /local/tit.sh

endef
export DOCKERFILE_APPEND


###################################################################################
###################################  build ########################################
###################################################################################
build_internal: setup_internal_dockerfile
	@echo "Combining internal Dockerfile with injected logic"
	@cat $(DOCKERFILE) Dockerfile.inject > Dockerfile.final
	@echo "Building final image from combined Dockerfile"
	@docker build -t $(IMAGE_NAME) -f Dockerfile.final .
	@echo "Saving Docker image to tar file: $(TAR_FILE)"
	@docker save -o $(TAR_FILE) $(IMAGE_NAME)
	@rm -f save_changes.sh Dockerfile.inject Dockerfile.final

build_external: append_common_docker_logic
	@echo "Combining external Dockerfile ($(DOCKERFILE)) with injected logic"
	@cat $(DOCKERFILE) Dockerfile.inject > Dockerfile.final
	@echo "Building final image from combined Dockerfile"
	@docker build -t $(IMAGE_NAME) -f Dockerfile.final .
	@echo "Saving Docker image to tar file: $(TAR_FILE)"
	@docker save -o $(TAR_FILE) $(IMAGE_NAME)
	@rm -f save_changes.sh Dockerfile.inject Dockerfile.final

build:
	@if [ "$(origin DOCKERFILE)" = "command line" ]; then \
		$(MAKE) build_external; \
	else \
		$(MAKE) build_internal; \
	fi

setup_internal_dockerfile:
	@echo "$$DOCKERFILE_CONTENT" > $(DOCKERFILE)
	$(MAKE) append_common_docker_logic

append_common_docker_logic:
	@echo "$$SAVE_CHANGES_SCRIPT" > save_changes.sh
	@echo "$$DOCKERFILE_APPEND" > Dockerfile.inject 

###################################################################################
###################################  load  ########################################
###################################################################################
load:
	@echo "Loading Docker image from tar file: $(TAR_FILE)"
	@if [ -f $(TAR_FILE) ]; then \
		docker load -i $(TAR_FILE); \
		echo "Docker image $(IMAGE_NAME) loaded successfully."; \
	else \
		echo "Error: Tar file $(TAR_FILE) not found."; \
		exit 1; \
	fi

###################################################################################
###################################  run ##########################################
###################################################################################
connect:
	@if [ $$(docker ps -q -f name=$(CONTAINER_NAME)) ]; then \
		docker exec -it $(CONTAINER_NAME) /bin/bash; \
	else \
		echo "Container $(CONTAINER_NAME) is not running."; \
	fi

run:
	@if [ $$(docker ps -q -f name=$(CONTAINER_NAME)) ]; then \
		echo "Docker container is already running ; connect to $(CONTAINER_NAME)"; \
		$(MAKE) connect; \
	else \
		echo "Running Docker container with GUI support: $(CONTAINER_NAME)"; \
		docker run --privileged --name $(CONTAINER_NAME) --rm -d --net=host \
			--user $(shell id -u):$(shell id -g) \
			-v /var/run/docker.sock:/var/run/docker.sock \
			-v /tmp/.X11-unix:/tmp/.X11-unix \
			-v $(TAR_PATH):/save/ \
			-e DISPLAY=$(DISPLAY) \
			$(if $(SHARE),-v $(SHARE):/home/user/shared:rw) \
			$(IMAGE_NAME) sleep infinity; \
		$(MAKE) connect; \
	fi

stop:
	@if [ $$(docker ps -q -f name=$(CONTAINER_NAME)) ]; then \
		echo "Stopping Docker container: $(CONTAINER_NAME)"; \
		docker stop $(CONTAINER_NAME); \
		exit 0; \
	fi
	@echo "Container $(CONTAINER_NAME) is not running."

run-gpu:
	@echo "Running Docker container with GUI and GPU support: $(CONTAINER_NAME)"
	@docker run --name $(CONTAINER_NAME) --rm -it  --net=host \
		--user $(shell id -u):$(shell id -g) \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v $(TAR_PATH):/save/ \
		-e DISPLAY=$(DISPLAY) \
		--gpus all \
		$(if $(SHARE),-v $(SHARE):/home/user/shared:rw) \
		$(IMAGE_NAME)

###################################################################################
###################################  save  ########################################
###################################################################################
save:
	@echo "Saving container changes to new image..."
	@docker commit $(CONTAINER_NAME) $(IMAGE_NAME)
	@echo "Saving new image to tar file: $(TAR_FILE)"
	@docker save -o $(TAR_FILE) $(IMAGE_NAME)
	@echo "Done."

###################################################################################
###################################  clean ########################################
###################################################################################
clean:
	@echo "Cleaning up Docker environment..."
	@docker rm -f $(CONTAINER_NAME) || true
	@docker rmi $(IMAGE_NAME) || true
	@echo "Basic clean complete."

fullclean: clean
	@echo "Removing the build tar..."
	@rm -f $(TAR_FILE)
	@echo "Full cleanup complete."

