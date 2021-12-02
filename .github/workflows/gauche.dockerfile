
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - gauche/**/Dockerfile

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
        name: Build and push schemers/gauche:head
        id: docker_build_gauche:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: gauche:head/
          tags: |
            gauche:head
            gauche:head-bullseye-slim
      -
        name: Build and push schemers/gauche:0
        id: docker_build_gauche:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: gauche:0/
          tags: |
            gauche:0
            gauche:0-bullseye-slim
            gauche:latest
