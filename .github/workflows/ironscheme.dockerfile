
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - ironscheme/**/Dockerfile

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
        name: Build and push schemers/ironscheme:1.0-mono
        id: docker_build_ironscheme:1.0-mono
        uses: docker/build-push-action@v2
        with:
          push: true
          context: ironscheme:1.0-mono/
          tags: |
            ironscheme:1.0-mono
            ironscheme:mono
      -
        name: Build and push schemers/ironscheme:1.0
        id: docker_build_ironscheme:1.0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: ironscheme:1.0/
          tags: |
            ironscheme:1.0
            ironscheme:1
            ironscheme:1-bullseye-slim
            ironscheme:latest
