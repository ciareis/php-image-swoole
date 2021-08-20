php:
	- cd base-php && DOCKER_BUILDKIT=1 docker build -t ciareis/php-swoole-alpine:php-8.0 . --network=host
	- cd base-php && DOCKER_BUILDKIT=1 docker build -t ciareis/php-swoole-alpine:latest . --network=host
	- docker push ciareis/php-swoole-alpine:php-8.0
	- docker push ciareis/php-swoole-alpine:latest

build:
	- cd base-php && DOCKER_BUILDKIT=1 docker build -t ciareis/php-swoole-alpine:php-8.0 . --network=host
