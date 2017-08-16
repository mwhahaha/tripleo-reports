
all: build

IMAGE_NAME = tripleo-reports-centos7

build:
	docker build -t $(IMAGE_NAME) .

app:
	s2i build webapp/ $(IMAGE_NAME) $(IMAGE_NAME)-app

test:
	docker run -p 8080:8080 $(IMAGE_NAME)-app

shell:
	docker run -it $(IMAGE_NAME) /bin/bash

#test:
#	docker build -t $(IMAGE_NAME)-candidate .
#	IMAGE_NAME=$(IMAGE_NAME)-candidate webapp/run
