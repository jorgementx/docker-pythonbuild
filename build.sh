#!/bin/sh

PYTHON_VERSION=3.13
docker build -t jorgementx/pythonbuild:${PYTHON_VERSION}-alpine . -f Dockerfile-onbuild --build-arg PYTHON_VERSION=${PYTHON_VERSION} --push
