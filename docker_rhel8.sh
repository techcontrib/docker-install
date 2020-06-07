#!/bin/bash
sudo dnf config-manager \
--add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install --nobest docker-ce
sudo systemctl enable --now docker
sudo systemctl is-active docker
# add current user to docker group so there is no need to use sudo when running docker
sudo usermod -aG docker $(whoami)
