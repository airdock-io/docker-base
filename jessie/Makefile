NAME = airdock/base
VERSION = jessie

.PHONY: all build tag_latest release debug run

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

tag_latest:
	@docker tag $(NAME):$(VERSION) $(NAME):latest

release: build tag_latest
	docker push $(NAME)
	@echo "Create a tag v-$(VERSION)"
	@git tag v-$(VERSION)
	@git push origin v-$(VERSION)

debug:
	docker run -t -i $(NAME):$(VERSION)

run:
	@echo "IPAddress =" $$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $$(docker run -d $(NAME):$(VERSION)))
