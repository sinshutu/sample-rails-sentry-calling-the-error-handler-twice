#! /bin/bash

docker-compose build
docker-compose run --rm rails bundle exec rspec . -fd
