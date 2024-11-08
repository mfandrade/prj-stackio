.PHONY: run build containertest


run: compose.yaml database.pw
	docker compose up --build

database.pw:
	@read -p "Set a password for the user 'dbuser' in MariaDB: " pw && \
	echo $$pw > database.pw

build:
	docker image rm -f mfandrade:latest
	docker image build -t mfandrade/stackio:latest dockerize/

containertest: build
	docker container run \
		--interactive --tty \
		--rm \
		--name stackio-test \
		--publish 8080:8080 \
		mfandrade/stackio:latest \
		/bin/sh
