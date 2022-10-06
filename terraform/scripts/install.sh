#!/bin/bash
set -ex
sudo apt update -y
echo "Instalando packages"
sudo apt install curl htop vim net-tools
echo "Instalando docker"
curl -sSL https://get.docker.com | sh
sudo service docker start
sudo usermod -a -G docker ${USER}

# BeerAPI
#docker run -d -p 80:3000 rarodevops/rarotalks-beer

# Mario
#docker run -d -p 80:8080 rarodevops/rarotalks-mario