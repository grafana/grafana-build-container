VERSION="crosscompile"
TAG="grafana/build-container"
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

all: build deploy

build:
	docker build -t "${TAG}:${VERSION}" .

deploy:
	docker push "${TAG}:${VERSION}"

run:
	docker run -ti \
		-e "CIRCLE_BRANCH=local" \
		-e "CIRCLE_BUILD_NUM=0" \
		${TAG}:${VERSION} \
		bash

run-with-local-source:
	docker run -d \
		-e "CIRCLE_BRANCH=local" \
		-e "CIRCLE_BUILD_NUM=0" \
		-w "/go/src/github.com/grafana/grafana" \
		--name grafana-build \
		${TAG}:${VERSION} \
		bash -c "/tmp/bootstrap.sh; tail -f /dev/null"
	docker cp "${GOPATH}/src/github.com/grafana/grafana" grafana-build:/go/src/github.com/grafana/
	docker exec -ti grafana-build bash

update-source:
	docker cp "${GOPATH}/src/github.com/grafana/grafana" grafana-build:/go/src/github.com/grafana/	

attach:
	docker exec -ti grafana-build bash

stop:
	docker kill grafana-build
	docker rm grafana-build