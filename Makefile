.SILENT:

help: # Show this help
	@echo Make targets:
	@egrep -h ":\s+# " $(MAKEFILE_LIST) | \
	  sed -e 's/# //; s/^/    /' | \
	  column -s: -t

docker-image: # Create Evon-Bootstrap Docker image
	docker build -f Dockerfile . -t linuxdojo/evon-bootstrap

docker-publish: # publish docker image
	docker login
	docker push linuxdojo/evon-bootstrap

all: # Build and publish docker image
	make docker-image
	make docker-publish
