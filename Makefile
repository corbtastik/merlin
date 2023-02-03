# -----------------------------------------------------------------------------
# Merlin Makefile for building a container image
# -----------------------------------------------------------------------------
IMAGE_NAME=merlin
IMAGE_TAG=v1.0
# -----------------------------------------------------------------------------
# Make merlin container image
# -----------------------------------------------------------------------------
image:
	@podman build -f Containerfile -t $(IMAGE_NAME):$(IMAGE_TAG) .
	@podman tag $(IMAGE_NAME):$(IMAGE_TAG) $(IMAGE_NAME):latest

run:
	@podman run --name $(IMAGE_NAME)-run --rm -it $(IMAGE_NAME):$(IMAGE_TAG) /bin/bash