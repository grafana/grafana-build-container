VERSION="v0.1"
TAG="grafana/build-container"
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

all: build deploy

build:
	docker build -t "${TAG}:${VERSION}" .

deploy:
	docker push "${TAG}:${VERSION}"

run-with-source:
	docker run -ti \
		-v "${GOPATH}/src/github.com/grafana/grafana:/go/src/github.com/grafana/grafana" \
		-e "CIRCLE_BRANCH=local" \
		-e "CIRCLE_BUILD_NUM=0" \
		-w "/go/src/github.com/grafana/grafana" \
		-u "${USER_ID}:${GROUP_ID}" \
		${TAG}:${VERSION} \
		bash