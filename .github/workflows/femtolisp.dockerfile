
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - femtolisp/**/Dockerfile

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
        name: Build and push schemers/femtolisp:head-lambdaconservatory
        id: docker_build_femtolisp:head-lambdaconservatory
        uses: docker/build-push-action@v2
        with:
          push: true
          context: femtolisp:head-lambdaconservatory/
          tags: |
            femtolisp:head-lambdaconservatory
            femtolisp:head-lambdaconservatory-bullseye-slim
      -
        name: Build and push schemers/femtolisp:head
        id: docker_build_femtolisp:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: femtolisp:head/
          tags: |
            femtolisp:head
            femtolisp:head-bullseye-slim
