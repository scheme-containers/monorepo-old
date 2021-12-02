
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - sizzle/**/Dockerfile

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
        name: Build and push schemers/sizzle:0
        id: docker_build_sizzle:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: sizzle:0/
          tags: |
            sizzle:0
            sizzle:0-bullseye-slim
            sizzle:latest
