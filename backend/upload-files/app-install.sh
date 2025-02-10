#!/bin/bash

sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/' /etc/needrestart/needrestart.conf
export NEEDRESTART_MODE=a
export DEBIAN_FRONTEND=noninteractive

# Update system packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install prerequisites
sudo apt-get install -y \
    curl \
    wget \
    git \
    build-essential

# Download Go 1.22 for AMD64
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz

# Check if download was successful
if [ ! -f "go1.22.0.linux-amd64.tar.gz" ]; then
    echo "Failed to download Go"
    exit 1
fi

# Remove any existing Go installation
sudo rm -rf /usr/local/go

# Extract Go to /usr/local
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

# Set up Go environment variables globally
sudo tee /etc/profile.d/go.sh << 'EOF'
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
EOF

# Make the script executable
sudo chmod +x /etc/profile.d/go.sh

# Source the Go environment immediately
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Clean up downloaded archive
rm -f go1.22.0.linux-amd64.tar.gz

# Add memory management for t4g.micro
# Create a swap file to help with memory constraints
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Verify Go installation is accessible
if ! command -v go &> /dev/null; then
    echo "Go installation failed or not accessible"
    exit 1
fi

# Source the existing dev.env file
if [ -f "dev.env" ]; then
    tar -xzf project.tar.gz
    rm project.tar.gz

    cp dev.env .env
    echo "Backend .env file updated with dev.env contents"
    
    # Check if the application binary exists
    if [ -f "app" ]; then
        echo "Starting the application..."
        
        # Start the application in the background
        nohup ./app > app.log 2>&1 &
        
        # Save the PID for later use
        echo $! > app.pid
        echo "Application started with PID $(cat app.pid)"
    else
        echo "Application binary 'app' not found in current directory"
        exit 1
    fi
else
    echo "dev.env file not found in current directory"
    exit 1
fi

# Final verification of Go installation
go version

echo "Installation completed successfully!"