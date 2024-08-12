# Generate a private key
openssl genpkey -algorithm RSA -out keycloak.key

# Generate a self-signed certificate
openssl req -new -x509 -key keycloak.key -out keycloak.crt -days 365

