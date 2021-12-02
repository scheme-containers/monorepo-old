
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - chibi/**/Dockerfile

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
        name: Build and push schemers/chibi:head
        id: docker_build_chibi:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: chibi:head/
          tags: |
            chibi:head
            chibi:head-bullseye-slim
      -
        name: Build and push schemers/chibi:0
        id: docker_build_chibi:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: chibi:0/
          tags: |
            chibi:0
            chibi:0-bullseye-slim
            chibi:latest
