#!/bin/bash

apt update 

# Set the Server Timezone to CST
echo "Europe/Kiev" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

apt install pwgen mc vim-nox -y
apt install git apache2 php7.0 php7.0-cli -y
MYSQL_PASS=$(pwgen 20 1)
# Install MySQL Server in a Non-Interactive mode. 
echo "mysql-server-5.7 mysql-server/root_password password $MYSQL_PASS" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password $MYSQL_PASS" | sudo debconf-set-selections
apt install mysql-server-5.7 -y

cat >> /root/password.txt <<EOF
MySQL
user: root
password: $MYSQL_PASS
EOF

# Install additional software
apt install python-software-properties supervisor -y
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt install nodejs -y


# node-js modules
npm install pm2

# Composer
wget https://getcomposer.org/composer.phar -O composer
chmod +x composer
mv ./composer /usr/local/bin/

ssh-keyscan -H bitbucket.org >> ~/.ssh/known_hosts

cd /var/www/
git clone git@bitbucket.org:tenantcloud/tenantcloud.com.git

