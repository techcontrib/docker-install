#!/bin/bash
sudo dnf config-manager \
--add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install --nobest docker-ce
sudo systemctl enable --now docker
sudo systemctl is-active docker
# add current user to docker group so there is no need to use sudo when running docker
sudo usermod -aG docker $(whoami)

cat <<'EOF'>/docker.install
#!/bin/bash

# Install required packages.
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

# Install container-selinux. 
# Check for latest version: http://mirror.centos.org/centos/7/extras/x86_64/Packages/.
sudo yum install -y \
  http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.107-3.el7.noarch.rpm
  
# Set up Docker repository.
sudo yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker CE and tools.
sudo yum install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io
EOF