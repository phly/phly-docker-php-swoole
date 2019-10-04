# phly-docker-php-swoole Makefile
#
# Build the docker image from the Dockerfile present.
#

SWOOLEVERSION?=4.4.7

.PHONY : all standard alpine

all: standard alpine

alpine:
	@echo "Creating alpine container"
	@echo "- Building alpine container"
	- docker build --memory-swap -1 -t phly-docker-php-swoole:7.3-alpine -f ./alpine.Dockerfile --build-arg SWOOLEVERSION=$(SWOOLEVERSION) .
	@echo "- Tagging alpine image"
	- docker tag phly-docker-php-swoole:7.3-alpine mwop/phly-docker-php-swoole:7.3-alpine
	@echo "- Pushing alpine image to hub"
	- docker push mwop/phly-docker-php-swoole:7.3-alpine

standard:
	@echo "Creating standard container"
	@echo "- Building standard container"
	- docker build --memory-swap -1 -t phly-docker-php-swoole:7.3 -f ./Dockerfile --build-arg SWOOLEVERSION=$(SWOOLEVERSION) .
	@echo "- Tagging standard image"
	- docker tag phly-docker-php-swoole:7.3 mwop/phly-docker-php-swoole:7.3
	@echo "- Pushing standard image to hub"
	- docker push mwop/phly-docker-php-swoole:7.3
