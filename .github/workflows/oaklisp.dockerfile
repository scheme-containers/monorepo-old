
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - oaklisp/**/Dockerfile

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      -
        name: Checkout
        uses: actions/checkout@v2
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1
      -
        name: Login to DockerHub
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}
      -
        name: Build and push schemers/oaklisp:1
        id: docker_build_oaklisp:1
        uses: docker/build-push-action@v2
        with:
          push: true
          context: oaklisp:1/
          tags: |
            oaklisp:1
            oaklisp:1-bullseye-slim
            oaklisp:latest
