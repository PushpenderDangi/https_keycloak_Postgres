#!/bin/bash

podman run -d \
  --name keycloak \
  -p 8443:8443 \
  -v ~/https_keycloak/conf:/opt/keycloak/conf \
  -v ~/https_keycloak/certs:/opt/keycloak/conf/certs \
  -e KEYCLOAK_ADMIN=admin \
  -e KEYCLOAK_ADMIN_PASSWORD=admin \
  -e KC_DB=postgres \
  -e KC_DB_USERNAME=postgres \
  -e KC_DB_PASSWORD=postgres \
  -e KC_DB_URL=jdbc:postgresql://192.168.122.1/postgres \
  quay.io/keycloak/keycloak:24.0.5 \
  start-dev \
  --http-port=8080 \
  --https-port=8443 \
  --https-certificate-file=/opt/keycloak/conf/certs/keycloak.crt \
  --https-certificate-key-file=/opt/keycloak/conf/certs/keycloak.key
