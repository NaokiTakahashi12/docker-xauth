
DOCKERFILE := Dockerfile
PROJECT := xauth
ORIGIN := $(shell git remote get-url origin | sed -e 's/^.*@//g')
REVISION := $(shell git rev-parse --short HEAD)
DOCKERFILES := $(sort $(wildcard */$(DOCKERFILE)))
USERNAME := naokitakahashi12

# Directory identities
XAUTH := xauth

# Image type
ALPINE := alpine

# Build image tag name
XAUTH_ALPINE_TAG := $(ALPINE)

define dockerbuild
	@docker build \
		--file $1 \
		--build-arg GIT_REVISION=$(REVISION) \
		--build-arg GIT_ORIGIN=$(ORIGIN) \
		--tag $2 \
	.
endef

.PHONY: all
all: help

.PHONY: build
build: $(XAUTH_ALPINE_TAG)

$(XAUTH_ALPINE_TAG): $(XAUTH)/$(ALPINE)/$(DOCKERFILE)
	$(eval DOCKERIMAGE := "$(USERNAME)/$(PROJECT):$@")
	$(call dockerbuild, $<, $(DOCKERIMAGE))

.PHONY: clean
clean:
	@docker image rm $(USERNAME)/$(PROJECT):$(XAUTH_ALPINE_TAG)

.PHONY: pull
pull:
	@docker pull $(USERNAME)/$(PROJECT):$(XAUTH_ALPINE_TAG)

.PHONY: help
help:
	@echo ""
	@echo " make <command> [option]"
	@echo ""
	@echo " Support commands"
	@echo " help  : print support commands"
	@echo " build : building docker images"
	@echo " clean : clean docker images"
	@echo " pull  : pulling docker images from registry"
	@echo ""
	@echo " Options"
	@echo " See the 'make --help'"
	@echo ""

