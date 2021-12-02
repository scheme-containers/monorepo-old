
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - elk/**/Dockerfile

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
        name: Build and push schemers/elk:3
        id: docker_build_elk:3
        uses: docker/build-push-action@v2
        with:
          push: true
          context: elk:3/
          tags: |
            elk:3
            elk:3-bullseye-slim
            elk:latest
