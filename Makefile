IMAGE_REGISTRY=port
IMAGE_REPO=k8s
IMAGE_TAG=latest

.PHONY: help

SHELL:=/bin/bash
.ONESHELL:

help: ## This help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: ## Build the container.
	docker build --tag $(IMAGE_REGISTRY)/$(IMAGE_REPO):$(IMAGE_TAG) .

k8screate: build ## Build and run the iso for testing.
	docker run -t --rm \
		--privileged \
		--volume /:/mnt/rootfs:rw \
		--env action="create" \
		$(IMAGE_REGISTRY)/$(IMAGE_REPO):$(IMAGE_TAG)

#ssh -o StrictHostKeyChecking=accept-new -o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null ubuntu@harbor-k8s-1.lan "cat ~/.kube/config" > ~/.kube/config