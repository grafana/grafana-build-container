VERSION="v0.1"

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
		grafana/build-container:${VERSION} \
		bash