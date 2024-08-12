Setting up Keycloak in a Podman container with HTTPS involves several steps. Here’s a comprehensive guide to help you achieve this:

1. Prepare Your Environment
Ensure you have Podman installed on your system. If not, you can install it using your package manager. For example:

# On Debian/Ubuntu
sudo apt update
sudo apt install podman

# On CentOS/RHEL
sudo dnf install podman
2. Obtain a TLS/SSL Certificate
You need a valid TLS/SSL certificate and its corresponding private key. You can either use a certificate from a trusted Certificate Authority (CA) or generate a self-signed certificate for testing purposes.

To generate a self-signed certificate, use OpenSSL:

# Generate a private key
openssl genpkey -algorithm RSA -out keycloak.key

# Generate a self-signed certificate
openssl req -new -x509 -key keycloak.key -out keycloak.crt -days 365
This will create keycloak.key (the private key) and keycloak.crt (the certificate).

3. Create a Keycloak Configuration File
Create a keycloak directory on your host system to store Keycloak configuration and your certificates:

mkdir -p ~/keycloak/{conf,certs}
Copy the certificate and key files into the certs directory:


cp keycloak.crt ~/keycloak/certs/
cp keycloak.key ~/keycloak/certs/
Create a keycloak.conf file in the conf directory to configure Keycloak with HTTPS:


# ~/keycloak/conf/keycloak.conf
# Ensure the Keycloak container uses HTTPS
https.certificate.file=/opt/keycloak/conf/certs/keycloak.crt
https.certificate.key.file=/opt/keycloak/conf/certs/keycloak.key
4. Run Keycloak with Podman
Use Podman to run Keycloak with the HTTPS configuration. You can use the official Keycloak image from Docker Hub.

Here’s a command to run Keycloak with HTTPS:


podman run -d \
  --name keycloak \
  -p 8443:8443 \
  -v ~/keycloak/conf:/opt/keycloak/conf \
  -v ~/keycloak/certs:/opt/keycloak/conf/certs \
  quay.io/keycloak/keycloak:latest \
  start-dev \
  --http-port=8080 \
  --https-port=8443 \
  --https-certificate-file=/opt/keycloak/conf/certs/keycloak.crt \
  --https-certificate-key-file=/opt/keycloak/conf/certs/keycloak.key
5. Access Keycloak
After the container is up and running, you can access Keycloak via HTTPS at https://localhost:8443.
