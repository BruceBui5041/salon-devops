#!/bin/bash

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --backend-ip)
        BACKEND_IP="$2"
        shift 2
        ;;
        --db-ip)
        DB_IP="$2"
        shift 2
        ;;
        *)
        echo "Unknown parameter: $1"
        exit 1
        ;;
    esac
done

# Validate required parameters
if [ -z "$BACKEND_IP" ] || [ -z "$DB_IP" ]; then
    echo "Missing required parameters. Usage: $0 --backend-ip <ip> --db-ip <ip>"
    exit 1
fi

# Update system packages
sudo yum update -y

# Install troubleshooting tools
sudo yum install -y telnet nc

# Install nginx and stream module
sudo amazon-linux-extras enable nginx1
sudo yum install -y nginx nginx-mod-stream

# Create main nginx configuration
sudo tee /etc/nginx/nginx.conf <<EOF
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;
}

stream {
    upstream mysql_backend {
        server ${DB_IP}:3306;
    }

    server {
        listen 3306;
        proxy_connect_timeout 300;
        proxy_timeout 300;
        proxy_pass mysql_backend;
    }
}
EOF

# Create HTTP proxy configuration
sudo tee /etc/nginx/conf.d/proxy.conf <<EOF
server {
    listen 2888;
    server_name localhost;
    error_log /var/log/nginx/error.log debug;

    location / {
        proxy_pass http://${BACKEND_IP}:2888;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_connect_timeout 300;
        proxy_send_timeout 300;
        proxy_read_timeout 300;
    }
}
EOF

# Remove default nginx configuration
sudo rm -f /etc/nginx/conf.d/default.conf

# Test nginx configuration
sudo nginx -t

# Start and enable nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Test network connectivity
echo "Testing connection to backend instance..."
nc -zv ${BACKEND_IP} 2888 || echo "Warning: Backend connection test failed"

# Test MySQL connectivity
echo "Testing connection to database..."
nc -zv ${DB_IP} 3306 || echo "Warning: Database connection test failed"