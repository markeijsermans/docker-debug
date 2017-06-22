IMG := markeijsermans/debug:latest

all: deps build

deps:
	go get .

build:
	GOOS=linux GOARCH=amd64 go build -v -o simple-server .
	docker build -t $(IMG) .

push:
	docker push $(IMG)
