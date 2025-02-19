#!/bin/bash

# Update system packages
sudo yum update -y

# Install AWS CLI and tools
sudo yum install -y aws-cli telnet nc

# Install nginx and stream module
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx nginx-mod-stream

# Create main nginx configuration
sudo tee /etc/nginx/nginx.conf <<EOL
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

# HTTP settings
http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;
    client_max_body_size 50M;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;
}

# Stream configuration
stream {
    upstream mysql_backend {
        server ${db_private_ip}:3306;
    }

    server {
        listen 3306;
        proxy_connect_timeout 300;
        proxy_timeout 300;
        proxy_pass mysql_backend;
    }
}
EOL

# Create HTTP proxy configuration
sudo tee /etc/nginx/conf.d/proxy.conf <<EOL
server {
    listen 2888;
    server_name localhost;
    error_log /var/log/nginx/error.log debug;
    client_max_body_size 50M;

    location / {
        proxy_pass http://${backend_private_ip}:2888;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_connect_timeout 300;
        proxy_send_timeout 300;
        proxy_read_timeout 300;
        client_max_body_size 50M;

        # WebSocket specific settings
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

server {
    listen 3000;
    server_name localhost;
    error_log /var/log/nginx/error.log debug;

    location / {
        proxy_pass http://${admin_panel_private_ip}:3000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_connect_timeout 300;
        proxy_send_timeout 300;
        proxy_read_timeout 300;
        client_max_body_size 50M;

        # WebSocket specific settings
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
EOL

# Remove default nginx configuration
sudo rm -f /etc/nginx/conf.d/default.conf

# Test nginx configuration before starting
sudo nginx -t

# Start and enable nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Test network connectivity
echo "Testing connection to backend instance..."
nc -zv ${backend_private_ip} 2888

# Test MySQL connectivity
echo "Testing connection to database..."
nc -zv ${db_private_ip} 3306