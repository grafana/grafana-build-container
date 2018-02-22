VERSION="v0.1"
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

all: build deploy

build:
	docker build -t "grafana/build-container:${VERSION}" .

deploy:
	docker push "grafana/build-container:${VERSION}"

run-with-source:
	docker run -ti \
		-v "${GOPATH}/src/github.com/grafana/grafana:/go/src/github.com/grafana/grafana" \
		-e "CIRCLE_BRANCH=local" \
		-e "CIRCLE_BUILD_NUM=0" \
		-w "/go/src/github.com/grafana/grafana" \
		-u "${USER_ID}:${GROUP_ID}" \
		grafana/build-container:${VERSION} \
		bash