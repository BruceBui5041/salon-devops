#!/bin/bash

# Update system packages
sudo apt-get update
sudo apt-get upgrade -y

# Install MySQL Server with explicit package resolution
sudo apt-get install -y wget lsb-release gnupg curl
sudo mkdir -p /etc/mysql/mysql.conf.d/

# Add MySQL APT repository
wget https://dev.mysql.com/get/mysql-apt-config_0.8.24-1_all.deb
sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.24-1_all.deb
sudo apt-get update

# Install MySQL packages explicitly
sudo apt-get install -y mysql-common
sudo apt-get install -y mysql-client
sudo apt-get install -y mysql-server

# Load environment variables
source .env

# Create MySQL configuration file
sudo tee /etc/mysql/mysql.conf.d/mysqld.cnf > /dev/null <<EOF
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
log-error       = /var/log/mysql/error.log
bind-address    = 0.0.0.0
symbolic-links=0
EOF

# Create MySQL directories if they don't exist
sudo mkdir -p /var/run/mysqld
sudo mkdir -p /var/log/mysql
sudo chown -R mysql:mysql /var/run/mysqld
sudo chown -R mysql:mysql /var/log/mysql

# Start MySQL service
sudo systemctl start mysql || sudo service mysql start
sudo systemctl enable mysql || sudo update-rc.d mysql defaults

# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
while ! sudo mysqladmin ping --silent; do
    sleep 1
done

# Initialize MySQL root password and permissions
sudo mysql --connect-expired-password <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
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

# Final MySQL restart to apply all changes
sudo systemctl restart mysql || sudo service mysql restart

echo "Installation completed!"