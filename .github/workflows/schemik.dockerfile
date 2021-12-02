
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - schemik/**/Dockerfile

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
        name: Build and push schemers/schemik:1.9
        id: docker_build_schemik:1.9
        uses: docker/build-push-action@v2
        with:
          push: true
          context: schemik:1.9/
          tags: |
            schemik:1.9
            schemik:1
            schemik:1-bullseye-slim
            schemik:latest
