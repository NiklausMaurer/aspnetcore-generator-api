#!/usr/bin/env bash

image="my-registry:55000/gen:ci-$1"

docker build -t $image .

docker push $image
