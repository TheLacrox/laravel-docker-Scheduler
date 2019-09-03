-include .env
container=${APP_SLUG}_php-fpm

up:
	docker-compose up -d

start: up

stop:
	docker-compose stop

down: stop
restart: stop up

rebuild: clean
	docker-compose build --force-rm --no-cache
	docker-compose up -d

build: clean
	docker-compose build
	docker-compose up -d

clean:
	docker-compose rm -vsf
	docker-compose down -v --remove-orphans

jumpin:
	docker exec -it ${container} bash

composer-install:
	docker exec ${container} composer install --ignore-platform-reqs --prefer-dist

migrate:
	docker exec ${container} php artisan migrate -n

migrate-fresh:
	docker exec ${container} php artisan migrate:fresh -n

seed:
	docker exec ${container} php artisan db:seed -n

app-init:
	docker exec ${container} cp .env.example .env
	docker exec ${container} php artisan storage:link -n
	docker exec ${container} php artisan key:generate -n

dev: up composer-install app-init migrate-fresh

run: 
	cd .\application &	npm i
	cd .\application &	npm run dev