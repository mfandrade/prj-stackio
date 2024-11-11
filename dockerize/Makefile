.PHONY: run image containertest

run: compose.yaml database.pw
	docker compose up --build

database.pw:
	@read -p "Set a password for the user 'dbuser' in MariaDB: " pw && \
	echo -n $$pw > database.pw

image:
	@echo 'Water5099!' | docker login -u mfandrade --password-stdin
	@for image in webserver backend; do \
		docker image rm -f mfandrade/stackio-$$image:latest ; \
		docker image build -t mfandrade/stackio-$$image:latest . -f Dockerfile.$$image ; \
		docker image push mfandrade/stackio-$$image:latest ; \
	done

containertest: build database.pw
	docker container run \
		--rm \
		--name containertest \
		--interactive --tty \
		--publish 8080:8080 \
		--volume $(CURDIR)/database.pw:/var/tmp/database.pw:ro \
		--entrypoint /bin/sh \
		mfandrade/stackio:latest

clean:
	@docker logout
	docker image rm -f mfandrade/stackio-webserver:latest 2>/dev/null
	docker image rm -f mfandrade/stackio-backend:latest 2>/dev/null
