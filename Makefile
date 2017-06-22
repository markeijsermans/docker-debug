IMG := markeijsermans/debug:latest

all: build

build:
	docker build -t $(IMG) .

push:
	docker push $(IMG)
