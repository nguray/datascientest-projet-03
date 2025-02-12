#!/bin/bash

sudo apt update
curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
sudo systemctl start docker
sudo usermod -aG docker ubuntu
sudo systemctl restart docker
echo "tout roule :)"
