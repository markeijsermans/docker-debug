IMG := markeijsermans/debug

all: build-kitchen-sink build-bootstrap

build-bootstrap:
	cd bootstrap-debug && docker build -t $(IMG):alpine .

build-kitchen-sink:
	cd kitchen-sink-debug && docker build -t $(IMG):kitchen-sink .
	docker tag $(IMG):kitchen-sink $(IMG):latest

push:
	docker push $(IMG):alpine
	docker push $(IMG):kitchen-sink
	docker push $(IMG):latest
