
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - rhizome-pi/**/Dockerfile

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
        name: Build and push schemers/rhizome-pi:0
        id: docker_build_rhizome-pi:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: rhizome-pi:0/
          tags: |
            rhizome-pi:0
            rhizome-pi:0-bullseye-slim
            rhizome-pi:latest
