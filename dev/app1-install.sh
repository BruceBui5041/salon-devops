#!/bin/bash

# Update system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install prerequisites
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker CE
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add current user to docker group
sudo usermod -aG docker ubuntu

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create application directory
sudo mkdir -p /app
sudo chown -R ubuntu:ubuntu /app
cd /app

# Create environment file with secure permissions
cat <<EOF > .env
GITHUB_TOKEN=ghp_S2LM182i7JnpjpvsYc23sNJ7hX03yfJww
REPO_URL=https://github.com/BruceBui5041/salon_be.git
MYSQL_ROOT_PASSWORD=root
EOF

# Secure the .env file
chmod 600 .env

# Clone the repository (if needed)
if [ ! -d "salon_be" ]; then
    git clone \$REPO_URL
fi

# Wait for Docker to be ready
while ! sudo docker info >/dev/null 2>&1; do
    echo "Waiting for Docker to be ready..."
    sleep 1
done

# Start containers
sudo docker-compose up -d

# Display container status
sudo docker-compose ps

echo "Installation completed!"