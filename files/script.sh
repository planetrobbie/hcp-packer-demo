#!/bin/sh
sudo su <<HERE
apt-get update
apt-get install unzip
curl https://releases.hashicorp.com/vault/1.8.4/vault_1.8.4_linux_amd64.zip --output /usr/local/bin/vault.zip
unzip /usr/local/bin/vault.zip -d /usr/local/bin/
HERE
