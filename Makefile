# phly-docker-php-swoole Makefile
#
# Build the docker image from the Dockerfile present.
#

VERSION := $(shell date +%Y%m%d%H%M)

.PHONY : all image

all: image

image:
	@echo "Creating container"
	@echo "- Building container"
	- docker build -t phly-docker-php-swoole -f ./Dockerfile .
	@echo "- Tagging image"
	- docker tag phly-docker-php-swoole:latest mwop/phly-docker-php-swoole:$(VERSION)
	@echo "- Pushing image to hub"
	- docker push mwop/phly-docker-php-swoole:$(VERSION)
