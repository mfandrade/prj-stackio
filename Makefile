.PHONY: run build containertest


run: dockerize/compose.yaml
	docker compose up --build

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
