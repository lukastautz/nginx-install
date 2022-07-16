sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl gnupg2 ca-certificates lsb-release
sudo apt install -y nginx
sudo systemctl enable nginx
sudo apt install -y ufw
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
sudo chmod -R -v 777 /var
sudo chmod -R -v 777 /etc/nginx
sudo apt install -y nginx-extras
sudo apt install -y certbot python3-certbot-nginx
sudo rm /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "    listen 80;" >> /etc/nginx/sites-available/default
sudo echo "    listen [::]:80 ipv6only=on;" >> /etc/nginx/sites-available/default
#sudo echo "    include snippets/snakeoil.conf;" >> /etc/nginx/sites-available/default
sudo echo "    server_tokens off;" >> /etc/nginx/sites-available/default
sudo echo "    more_set_headers 'Server: cBin/nginx';" >> /etc/nginx/sites-available/default
sudo echo "    root /var/www/default;" >> /etc/nginx/sites-available/default
sudo echo "    index index.html index.htm index.jpg index.jpeg index.gif index.json index.txt;" >> /etc/nginx/sites-available/default
sudo echo "    server_name $(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
sudo echo "    client_max_body_size 1024M;" >> /etc/nginx/sites-available/default
sudo echo "    location / {" >> /etc/nginx/sites-available/default
sudo echo "        error_page 404 http://\$server_name;" >> /etc/nginx/sites-available/default
sudo echo "        try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location ~ /cgi/ $ {" >> /etc/nginx/sites-available/default
sudo echo "        gzip on;" >> /etc/nginx/sites-available/default
sudo echo "        fastcgi_pass 127.0.0.1:9999;" >> /etc/nginx/sites-available/default
sudo echo "        include /etc/nginx/fastcgi_params;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location ~ .c$ {" >> /etc/nginx/sites-available/default
sudo echo "        deny all;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location ~ .h$ {" >> /etc/nginx/sites-available/default
sudo echo "        deny all;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "}" >> /etc/nginx/sites-available/default
#sudo echo "server {" >> /etc/nginx/sites-available/default
#sudo echo "    listen 80;" >> /etc/nginx/sites-available/default
#sudo echo "    listen [::]:80 ipv6only=on;" >> /etc/nginx/sites-available/default
#sudo echo "    server_tokens off;" >> /etc/nginx/sites-available/default
#sudo echo "    more_set_headers 'Server: siteMngr/nginx';" >> /etc/nginx/sites-available/default
#sudo echo "    server_name $(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
#sudo echo "    return 302 https://\$server_name\$request_uri;" >> /etc/nginx/sites-available/default
#sudo echo "}" >> /etc/nginx/sites-available/default
sudo rm /etc/nginx/nginx.conf
sudo echo 'user root;' >> /etc/nginx/nginx.conf
sudo echo 'worker_processes auto;' >> /etc/nginx/nginx.conf
sudo echo 'pid /var/run/nginx.pid;' >> /etc/nginx/nginx.conf
sudo echo 'include /etc/nginx/modules-enabled/*.conf;' >> /etc/nginx/nginx.conf
sudo echo 'events {' >> /etc/nginx/nginx.conf
sudo echo '    worker_connections 512;' >> /etc/nginx/nginx.conf
sudo echo '}' >> /etc/nginx/nginx.conf
sudo echo 'http {' >> /etc/nginx/nginx.conf
sudo echo '    sendfile on;' >> /etc/nginx/nginx.conf
sudo echo '    tcp_nopush on;' >> /etc/nginx/nginx.conf
sudo echo '    types_hash_max_size 2048;' >> /etc/nginx/nginx.conf
sudo echo '    server_tokens off;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/mime.types;' >> /etc/nginx/nginx.conf
sudo echo '    default_type application/octet-stream;' >> /etc/nginx/nginx.conf
sudo echo '    ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;' >> /etc/nginx/nginx.conf
sudo echo '    ssl_prefer_server_ciphers on;' >> /etc/nginx/nginx.conf
sudo echo '    access_log /dev/null;' >> /etc/nginx/nginx.conf
sudo echo '    error_log /dev/null;' >> /etc/nginx/nginx.conf
sudo echo '    gzip on;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/conf.d/*.conf;' >> /etc/nginx/nginx.conf
sudo echo '    include /etc/nginx/sites-enabled/*;' >> /etc/nginx/nginx.conf
sudo echo '}' >> /etc/nginx/nginx.conf
sudo apt install -y build-essential
sudo mkdir /var/www/default
sudo chmod -R -v 777 /var/www
sudo apt install -y libfcgi-dev spawn-fcgi
#sudo gcc /var/www/default/index.c -o /var/www/default/index.cbin
sudo service nginx restart
