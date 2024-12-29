#!/bin/bash
sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/' /etc/needrestart/needrestart.conf
export NEEDRESTART_MODE=a
export DEBIAN_FRONTEND=noninteractive

# System update
sudo apt-get update -y
sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install -y wget lsb-release gnupg curl
sudo mkdir -p /etc/mysql/mysql.conf.d/

# Add MySQL repository for x86
wget https://repo.mysql.com/mysql-apt-config_0.8.24-1_all.deb
sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.24-1_all.deb
sudo apt-get update

# Install MySQL
sudo apt-get install -y mysql-common mysql-client mysql-server

# Load environment variables
source .env

# Configure MySQL
sudo tee /etc/mysql/mysql.conf.d/mysqld.cnf > /dev/null <<EOF
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
log-error       = /var/log/mysql/error.log
bind-address    = 0.0.0.0
symbolic-links=0
EOF

# Setup directories
sudo mkdir -p /var/run/mysqld /var/log/mysql
sudo chown -R mysql:mysql /var/run/mysqld /var/log/mysql

# Start MySQL
sudo systemctl start mysql
sudo systemctl enable mysql

# Wait for MySQL startup
until sudo mysqladmin ping --silent; do
    sleep 2
done

# Configure root access
sudo mysql --connect-expired-password <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Import databases
for sql_file in db/*.sql; do
    if [ -f "$sql_file" ]; then
        echo "Importing $sql_file..."
        sudo mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" < "$sql_file"
    fi
done


sudo systemctl restart mysql
echo "MySQL installation complete"