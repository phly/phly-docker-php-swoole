# phly-docker-php-swoole Makefile
#
# Build the docker image from the Dockerfile present.
#

SWOOLEVERSION?=4.2.12

.PHONY : all standard alpine

all: standard alpine

alpine:
	@echo "Creating alpine container"
	@echo "- Building alpine container"
	- docker build -t phly-docker-php-swoole:7.2-alpine -f ./alpine.Dockerfile --build-arg SWOOLEVERSION=$(SWOOLEVERSION) .
	@echo "- Tagging alpine image"
	- docker tag phly-docker-php-swoole:7.2-alpine mwop/phly-docker-php-swoole:7.2-alpine
	@echo "- Pushing alpine image to hub"
	- docker push mwop/phly-docker-php-swoole:7.2-alpine

standard:
	@echo "Creating standard container"
	@echo "- Building standard container"
	- docker build -t phly-docker-php-swoole:7.2 -f ./Dockerfile --build-arg SWOOLEVERSION=$(SWOOLEVERSION) .
	@echo "- Tagging standard image"
	- docker tag phly-docker-php-swoole:7.2 mwop/phly-docker-php-swoole:7.2
	@echo "- Pushing standard image to hub"
	- docker push mwop/phly-docker-php-swoole:7.2
