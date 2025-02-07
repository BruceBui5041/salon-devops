#!/bin/bash

# System updates and prerequisites
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/' /etc/needrestart/needrestart.conf
export NEEDRESTART_MODE=a
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y curl wget git build-essential

# Install Node.js 20.x
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm@11.0.0

# Verify Node.js installation
if ! command -v node &> /dev/null; then
    echo "Node.js installation failed"
    exit 1
fi

# Set up swap for t4g.micro
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Deploy Next.js application
if [ -f ".env" ]; then
    # Check if .next directory exists
    if [ -d ".next" ]; then
        echo "Found .next bundle"
        
        # Install production dependencies
        sudo npm ci --only=production
        
        if [ $? -eq 0 ]; then
            echo "Dependencies installed successfully"
            
            # Install and setup PM2
            sudo npm install -g pm2
            
            # Stop any existing PM2 process
            sudo pm2 stop nextjs 2>/dev/null || true
            sudo pm2 delete nextjs 2>/dev/null || true
            
            # Start Next.js in production
            sudo pm2 start npm --name "nextjs" -- start
            
            # Save PM2 process list
            sudo pm2 save
            
            # Setup PM2 startup script
            sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu
            
            echo "Next.js application deployed successfully!"
        else
            echo "Failed to install dependencies"
            exit 1
        fi
    else
        echo ".next bundle not found"
        exit 1
    fi
else
    echo "Missing .env file"
    exit 1
fi

echo "Deployment completed!"