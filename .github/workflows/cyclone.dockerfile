
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - cyclone/**/Dockerfile

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
        name: Build and push schemers/cyclone:head
        id: docker_build_cyclone:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: cyclone:head/
          tags: |
            cyclone:head
            cyclone:head-bullseye-slim
      -
        name: Build and push schemers/cyclone:0
        id: docker_build_cyclone:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: cyclone:0/
          tags: |
            cyclone:0
            cyclone:head-bullseye-slim
            cyclone:latest
