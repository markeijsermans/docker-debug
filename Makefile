IMG := markeijsermans/debug
TAG := v1

build:
	docker build -t $(IMG):$(TAG) .
	docker tag $(IMG):$(TAG) $(IMG):latest

push:
	docker push $(IMG):$(TAG)
	docker push $(IMG):latest
