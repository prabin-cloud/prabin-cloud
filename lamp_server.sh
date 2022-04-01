#!/bin/bash
#written by prabin_aryal

# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

#updating the sevrer
sudo apt update

#lets install apache web server first
echo "installing apache web server..."
sudo apt install apache2

#enabling and allowing apache in the UFW firewall
ufw enable
ufw allow OpenSSH
sudo ufw allow in "Apache"
sudo ufw status
#you can cehck if the apache is installed and working from http://your_server_ip

#Installing MySQL
echo "installing MYSQL...."
sudo apt install mysql-server
sudo mysql_secure_installation
#selcet "yse" and set the password strength for your mysql user (my recomendation is 1)
#enter password
#It's better you disallow remote root logins, if you have to access mysql remotely, access it from a sudo user

#Installing PHP
echo "Installing PHP..."
sudo apt install php libapache2-mod-php php-mysql
#check PHP version
php -v

#Installing phpMyAdmin
echo "Installing phpMyAdmin..."
sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl
#For the server selection, choose apache2 <$>[warning] Warning: When the prompt appears, apache2 is highlighted, but not selected. If you do not hit SPACE to select Apache, the installer will not move the necessary files during installation. Hit SPACE, TAB, and then ENTER to select Apache.

#if you have used the validate password option in your mysql setup, there might be some error while installing the phpmyadmin, to solve this issue please abort the process and follow the steps below
# sudo mysql
# mysql -u root -p
# UNINSTALL COMPONENT "file://component_validate_password";
#Then try installing the phpmyadmin package again and it will work as expected:
# sudo apt install phpmyadmin
#Once phpMyAdmin is installed, you can open the MySQL prompt once again with sudo mysql or mysql -u root -p and then run the following command to re-enable the Validate Password component:
# INSTALL COMPONENT "file://component_validate_password";

#continued PHPmyadmin installation
sudo phpenmod mbstring
sudo systemctl restart apache2

#Allowing root user to access database through phpmyadmin dashboard.
# sudo mysql
# SELECT user,authentication_string,plugin,host FROM mysql.user;
# ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'password';
#If any issue occurs change to native mysql authentication
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; 



