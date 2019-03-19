# grafana-build-container
Grafana build container

**Important:** This build has been moved into the main Grafana [repo](https://github.com/grafana/grafana/tree/master/scripts/build/ci-build).

## Description

This is a container for cross-platform builds of Grafana. You can run it locally using the Makefile.

## Makefile targets

* `make run-with-local-source-copy`
  - Starts the container locally and copies your local sources into the container
* `make run-with-local-source-live`
  - Starts the container (as your user) locally and maps your Grafana project dir into the container
* `make update-source`
  - Updates the sources in the container from your local sources
* `make stop`
  - Kills the container
* `make attach`
  - Opens bash within the running container

