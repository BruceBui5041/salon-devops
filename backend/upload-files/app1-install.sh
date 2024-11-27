#!/bin/bash

# Update system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install prerequisites
sudo apt-get install -y \
    curl \
    wget \
    git \
    build-essential

# Download Go 1.22
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz

# Remove any existing Go installation
sudo rm -rf /usr/local/go

# Extract Go to /usr/local
sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

# Set up Go environment variables
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
echo 'export GOPATH=$HOME/go' >> ~/.profile
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.profile

# Load the new environment variables
source ~/.profile

# Clean up downloaded archive
rm go1.22.0.linux-amd64.tar.gz

# Source the existing .env file for git credentials
if [ -f ".env" ]; then
    source .env
    
    # Clone the repository using the token
    if [ ! -z "$GITHUB_TOKEN" ] && [ ! -z "$REPO_URL" ]; then
        # Extract the repository name from the URL
        REPO_NAME=$(basename "$REPO_URL" .git)
        
        # Clone the repository using the token
        git clone https://${GITHUB_TOKEN}@${REPO_URL#https://}
        
        if [ $? -eq 0 ]; then
            echo "Repository cloned successfully!"
            
            # Navigate to the repository directory
            cd $REPO_NAME
            
            # Copy dev.env from the original directory to the repo directory
            if [ -f "../dev.env" ]; then
                cp ../dev.env .env
                echo "Backend .env file updated with dev.env contents"
                
                # Build the Go application
                echo "Building Go application..."
                go mod download
                go build -o app
                
                if [ $? -eq 0 ]; then
                    echo "Go application built successfully!"
                    
                    # Start the application in the background
                    echo "Starting the application..."
                    nohup ./app > app.log 2>&1 &
                    
                    # Save the PID for later use if needed
                    echo $! > app.pid
                    echo "Application started with PID $(cat app.pid)"
                else
                    echo "Failed to build Go application"
                    exit 1
                fi
            else
                echo "dev.env not found in the original directory"
                exit 1
            fi
            
        else
            echo "Failed to clone repository"
            exit 1
        fi
    else
        echo "GITHUB_TOKEN or REPO_URL not found in .env file"
        exit 1
    fi
else
    echo ".env file not found in current directory"
    exit 1
fi

# Verify Go installation
go version

echo "Installation completed successfully!"