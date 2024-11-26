IMAGE_NAME := us-east1-docker.pkg.dev/dex-public/spark-platform/spark-all-in-one
DOCKERFILE := Dockerfile
LAST_TAG := $(shell git describe --tags --abbrev=0)

# Default target
all: build

# Build the Docker image
build:
	@echo "Building Docker image: $(IMAGE_NAME):$(LAST_TAG)"
	docker build -t $(IMAGE_NAME):$(LAST_TAG) -f $(DOCKERFILE) .

# Push the Docker image to a registry
push:
	@echo "Pushing Docker image: $(IMAGE_NAME):$(LAST_TAG)"
	docker push $(IMAGE_NAME):$(LAST_TAG)

# Clean up dangling images (optional)
clean:
	@echo "Cleaning up dangling Docker images"
	docker image prune -f

# Show the last Git tag
tag:
	@echo "Last Git tag: $(LAST_TAG)"

.PHONY: all build push clean tag
