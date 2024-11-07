all: build run

build:
	docker image rm -f mfandrade:latest
	docker image build -t mfandrade/stackio:latest dockerize/

run: build
	docker container run \
		--rm \
		--name stackio-test \
		--publish 8080:8080 \
		mfandrade/stackio:latest
