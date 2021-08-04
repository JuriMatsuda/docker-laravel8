.DEFAULT_GOAL := help

build-local: ## [dev] 開発環境を構築する
	docker-compose run --rm php composer install
	docker-compose run --rm php php artisan key:generate
	docker-compose run --rm php php artisan migrate:fresh
	docker-compose run --rm php php artisan passport:keys
	docker-compose run --rm php php artisan migrate:fresh
	docker-compose run --rm php php artisan db:seed
	# docker-compose run --rm php php artisan migrate:fresh --seed --database=mysql_testing
	docker-compose run --rm php php artisan passport:client --personal --no-interaction
	docker-compose run --rm node yarn install
	docker-compose run --rm node yarn run dev


serve: ## [dev] php container をlocalhost:8000で起動する
	docker-compose up php mysql nginx

login-php: ## [dev] php container をlocalhost:8000で起動する
	docker exec -it php /bin/bash

login-nginx:
	docker exec -it nginx ash

composer-install: ## [dev] Run composer install
	docker-compose run --rm php composer install

artisan: ## [dev] Run artisan
	docker-compose run --rm php php artisan

tinker: ## [dev] Run Tinker
	docker-compose run --rm php php artisan tinker

ide-helper: ## [dev] ide-helperを実行する
	docker-compose run --rm php php artisan ide-helper:eloquent
	docker-compose run --rm php php artisan ide-helper:generate
	docker-compose run --rm php php artisan ide-helper:meta

# migrate: ## migrate
# 	docker-compose run --rm php php artisan migrate:fresh --seed
# 	docker-compose run --rm php php artisan passport:client --personal --no-interaction

yarn-install: ## [dev] yarn install
	docker-compose run --rm node yarn install

yarn-dev: ## [dev] yarn run dev
	docker-compose run --rm node yarn run dev

yarn-watch: ## [dev] yarn run watch
	docker-compose run --rm node yarn run watch

seed: ## DB migrate refresh
	docker-compose run --rm php php artisan migrate:fresh
	docker-compose run --rm php composer dump-autoload
	docker-compose run --rm php php artisan db:seed

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
