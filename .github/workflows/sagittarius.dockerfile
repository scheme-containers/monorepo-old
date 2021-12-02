
name: docker-actions

on:
  push:
    branches:
      - 'master'
    paths:
      - sagittarius/**/Dockerfile

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
        name: Build and push schemers/sagittarius:head
        id: docker_build_sagittarius:head
        uses: docker/build-push-action@v2
        with:
          push: true
          context: sagittarius:head/
          tags: |
            sagittarius:head
            sagittarius:head-bullseye-slim
      -
        name: Build and push schemers/sagittarius:0
        id: docker_build_sagittarius:0
        uses: docker/build-push-action@v2
        with:
          push: true
          context: sagittarius:0/
          tags: |
            sagittarius:0
            sagittarius:0-bullseye-slim
            sagittarius:latest
