#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Require root privileges!"
   exit 1
fi

cat << "EOF"
Installing LAMP stack with phpMyAdmin on Ubuntu/Mint                 
EOF

echo -e "\e[31mUpdating your system\e[0m"
apt update
echo -e "\e[31mInstalling Apache2 server ...\e[0m"
apt install apache2 -y
echo -e "\e[31mChecking firewall/UFW status\e[0m"
ufw app list
echo -e "\e[31mAllow Apache2 traffic on port 80\e[0m"
ufw allow in "Apache"
echo -e "\e[31mVerify the change\e[0m"
ufw status
service apache2 start
echo -e "\e[31mApache2 successfully installed and running\e[0m"
echo -e "\e[31mInstalling MySQL ...\e[0m"
echo -e "\e[31mConfirm installation by typing y|Y and hit ENTER\e[0m"
apt install mysql-server -y
mysql_secure_installation -y
echo -e "\e[31mMySQL successfully installed\e[0m"
echo -e "\e[31mInstalling PHP ...\e[0m"
apt install php libapache2-mod-php php-mysql -y
echo -e "\e[31mPHP successfully installed\e[0m"
echo -e "\e[31mInstalling PHP MyAdmin ...\e[0m"
apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y
service apache2 restart
service mysql start
echo -e "\e[31mServices successfully installed and running ...\e[0m"
echo -e "\e[31m###############################################################\e[0m"
echo -e "Verify installation by typing php --version and mysql -V"
echo -e "Check localhost, http://127.0.0.1 and http://127.0.0.1/phpmyadmin"
echo -e "\n"
echo -e "Open MySQL prompt using sudo mysql -u root -p and type command below"
echo -e "\n"
cat << "EOF"
mysql> CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'yourpassword';
mysql> GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
mysql> FLUSH PRIVILEGES;
mysql> EXIT
* Now you can login phpMyAdmin using these credentials
EOF
echo -e "\e[31m###############################################################\e[0m"
