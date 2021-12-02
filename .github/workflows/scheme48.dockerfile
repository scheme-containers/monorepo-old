
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - scheme48/**/Dockerfile

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
        name: Build and push schemers/scheme48:1
        id: docker_build_scheme48:1
        uses: docker/build-push-action@v2
        with:
          push: true
          context: scheme48:1/
          tags: |
            scheme48:1
            scheme48:1.9
            scheme48:1-bullseye-slim
            scheme48:latest
