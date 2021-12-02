
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - unsyntax/**/Dockerfile

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
        name: Build and push schemers/unsyntax:head
        id: docker_build_unsyntax:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: unsyntax:head/
          tags: |
            unsyntax:head
            unsyntax:head-bullseye-slim
            unsyntax:latest
