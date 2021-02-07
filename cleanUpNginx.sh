#! /bin/bash
# Fully remove nginx
echo -e "\nCurrent ngnmx status:\n"
systemctl status nginx.service | head -6
echom "Removing.."
systemctl disable nginx.service > /dev/null
systemctl stop nginx.service > /dev/null
apt-get remove nginx -y > /dev/null
#apt-get purge nginx -y > /dev/null
echo -e "\nCurrent ngnmx status:\n"
systemctl status nginx.service | head -4
cp /var/www/html/index.nginx-debian.html.bak /var/www/html/index.nginx-debian.html