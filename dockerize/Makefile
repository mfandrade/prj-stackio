.PHONY: run image containertest
SHELL=/bin/bash

run: compose.yaml .env
	docker compose up --build

.env:
	@read -s -p "Set a password for the user 'dbuser' in MariaDB: " pw && \
	echo -n "MARIADB_PASSWORD=$$pw" > .env

image:
	@echo 'Water5099!' | docker login -u mfandrade --password-stdin
	@for image in webserver backend; do \
		docker image rm -f mfandrade/stackio-$$image:latest ; \
		docker image build -t mfandrade/stackio-$$image:latest . -f Dockerfile.$$image ; \
		docker image push mfandrade/stackio-$$image:latest ; \
	done

containertest: build .env
	docker container run \
		--rm \
		--name containertest \
		--interactive --tty \
		--publish 8080:8080 \
		--entrypoint /bin/sh \
		mfandrade/stackio:latest

clean:
	@docker logout
	docker image rm -f mfandrade/stackio-webserver:latest 2>/dev/null
	docker image rm -f mfandrade/stackio-backend:latest 2>/dev/null
