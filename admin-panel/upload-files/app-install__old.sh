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

# Clone and set up repository
if [ -f ".env" ]; then
    source .env
    
    if [ ! -z "$GITHUB_TOKEN" ] && [ ! -z "$REPO_URL" ]; then
        REPO_NAME=$(basename "$REPO_URL" .git)
        git clone https://${GITHUB_TOKEN}@${REPO_URL#https://}
        
        if [ $? -eq 0 ]; then
            cd $REPO_NAME
            
            if [ -f "../dev.env" ]; then
                cp ../dev.env .env
                echo "Environment configured"
                
                # Install dependencies and build
                sudo npm install
                sudo npm run build
                
                if [ $? -eq 0 ]; then
                    # Start Next.js in production
                    sudo npm install -g pm2
                    sudo pm2 start npm --name "nextjs" -- start
                    
                    # Save PM2 process list
                    sudo pm2 save
                    
                    # Setup PM2 startup script
                    sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu
                    
                    echo "Next.js application deployed successfully!"
                else
                    echo "Build failed"
                    exit 1
                fi
            else
                echo "dev.env not found"
                exit 1
            fi
        else
            echo "Repository clone failed"
            exit 1
        fi
    else
        echo "Missing GitHub credentials"
        exit 1
    fi
else
    echo "Missing .env file"
    exit 1
fi

echo "Deployment completed!"
