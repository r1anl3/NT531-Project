#!/bin/bash

# Define the HTML content
html_content='
<html>
    <head>
        <title>Welcome to your_domain!</title>
    </head>
    <body>
        <h1>Success!  The your_domain server block is working!</h1>
    </body>
</html>
'
server_content='
server {
        listen 80;
        listen [::]:80;

        root /var/www/your_domain/html;
        index index.html index.htm index.nginx-debian.html;

        server_name your_domain www.your_domain;

        location / {
                try_files $uri $uri/ =404;
        }
}
'

# Write the HTML content to a file
echo "$html_content" > index.html

echo "HTML file created successfully."

echo "STEP1: INSTALLING NGINX"
sudo apt update
sudo apt install nginx

echo "STEP2: ADJUSTING FIREWALL"
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw status

echo "STEP3: CHECKING WEB SERVER"
systemctl status nginx

echo "STEP4: SETTING UP SERVER BLOCKS"
read -p "Your domain: " your_domain
sudo mkdir -p /var/www/$your_domain/html
sudo chown -R $USER:$USER /var/www/$your_domain/html
sudo chmod -R 755 /var/www/$your_domain
cd /var/www/$your_domain/html

echo "DONE"