#!/bin/sh
# Created for the busybox shell

set -e

_repo="grafana/build-container"
_build_tag="$_repo:build"

docker build -t $_build_tag .
docker login -u "$DOCKER_USER" -p "$DOCKER_PASS"

if [ "$CIRCLE_BRANCH" == "master" ]; then
    _master_tag="$_repo:master"
    echo "Pushing $_master_tag to Docker Hub"
    docker tag $_build_tag $_master_tag
    docker push $_master_tag
fi

set +e
echo "$CIRCLE_TAG" | egrep "^v.+$"
IS_RELEASE=$?
set -e

if [ $IS_RELEASE -eq 0 ]; then
    _version=$(echo $CIRCLE_TAG | cut -d "v" -f2)
    _release_tag="$_repo:$_version"
    echo "Pushing $_release_tag to Docker Hub"
    docker tag $_build_tag $_release_tag
    docker push $_release_tag
fi