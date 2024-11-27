#!/bin/bash

# Update system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install MySQL Server
sudo apt-get install -y mysql-server

# Load environment variables
source .env

# Configure MySQL to allow remote connections
sudo sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Start MySQL service
sudo systemctl start mysql
sudo systemctl enable mysql

# Secure MySQL installation and set root password
# First, set the root password using ALTER USER
sudo mysql --user=root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Initialize database with SQL files
for sql_file in db/*.sql; do
    if [ -f "$sql_file" ]; then
        echo "Executing $sql_file..."
        sudo mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" < "$sql_file"
    fi
done

# Restart MySQL to apply changes
sudo systemctl restart mysql

echo "Installation completed!"