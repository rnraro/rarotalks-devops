#!/bin/bash
set -ex
sudo apt update -y
echo "Instalando s.o packages"
sudo apt install -y curl vim net-tools 
echo "Instalando docker"
sudo curl -sSL https://get.docker.com | sh
sudo usermod -a -G docker ${USER}

# Run Mario App
docker run -d -p 80:8080 rarodevops/rarotalks-mario