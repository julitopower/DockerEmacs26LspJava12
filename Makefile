all:

.PHONY: build run
build:
	docker build -t julitopower/dockeremacs26java8 .

run:
	docker run -it --rm -v $(shell pwd):/opt/src/ julitopower/dockeremacs26java8 /bin/bash
