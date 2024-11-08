.PHONY: run build containertest

run: compose.yaml database.pw
	docker compose up --build

database.pw:
	@read -p "Set a password for the user 'dbuser' in MariaDB: " pw && \
	echo -n $$pw > database.pw

build:
	docker image rm -f mfandrade:latest
	docker image build -t mfandrade/stackio:latest .

containertest: build database.pw
	docker container run \
		--rm \
		--name containertest \
		--interactive --tty \
		--publish 8080:8080 \
		--volume $(CURDIR)/database.pw:/var/tmp/database.pw:ro \
		--entrypoint /bin/sh \
		mfandrade/stackio:latest

