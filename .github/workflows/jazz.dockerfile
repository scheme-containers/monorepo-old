
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - jazz/**/Dockerfile

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
        name: Build and push schemers/jazz:head
        id: docker_build_jazz:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: jazz:head/
          tags: |
            jazz:head
            jazz:head-bullseye-slim
