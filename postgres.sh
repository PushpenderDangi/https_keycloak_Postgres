#!/bin/bash
podman run -dt \
    --name postgres \
    -p 5432:5432 \
    -e POSTGRES_DB=postgres \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=postgres \
    -e PGDATA=/var/lib/postgresql/data/pgdata \
    -v `pwd`/data:/var/lib/postgresql/data \
    docker.io/postgres:latest
