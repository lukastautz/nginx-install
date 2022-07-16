sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl gnupg2 ca-certificates lsb-release build-essential libfcgi-dev nginx ufw nginx-extras certbot python3-certbot-nginx
sudo systemctl enable nginx
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
sudo chmod -R -v 777 /etc/nginx
sudo rm -R /var/www/html
sudo rm /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "    listen 80;" >> /etc/nginx/sites-available/default
sudo echo "    listen [::]:80 ipv6only=on;" >> /etc/nginx/sites-available/default
#sudo echo "    include snippets/snakeoil.conf;" >> /etc/nginx/sites-available/default
sudo echo "    server_tokens off;" >> /etc/nginx/sites-available/default
sudo echo "    more_set_headers 'Server: FCGI/NGINX';" >> /etc/nginx/sites-available/default
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
sudo echo "        fastcgi_pass 0.0.0.0:9999;" >> /etc/nginx/sites-available/default
sudo echo "        include /etc/nginx/fastcgi_params;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location ~ .c$ {" >> /etc/nginx/sites-available/default
sudo echo "        deny all;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location ~ .fcgi$ {" >> /etc/nginx/sites-available/default
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
sudo mkdir /var/www/default
sudo chmod -R -v 700 /var
sudo chmod -R -v 777 /var/www
sudo echo '#include "fcgi_stdio.h"' >> /var/www/default/app.c
sudo echo '#include <stdlib.h>' >> /var/www/default/app.c
sudo echo 'int main()' >> /var/www/default/app.c
sudo echo '{' >> /var/www/default/app.c
sudo echo '    int count = 0;' >> /var/www/default/app.c
sudo echo '    while(FCGI_Accept() >=0 )' >> /var/www/default/app.c
sudo echo '    {' >> /var/www/default/app.c
sudo echo '        count++;' >> /var/www/default/app.c
sudo echo '        printf(' >> /var/www/default/app.c
sudo echo '            "Content-type: text/html\n\n"' >> /var/www/default/app.c
sudo echo '            "<!DOCTYPE html>\n"' >> /var/www/default/app.c
sudo echo '            "<html>\n"' >> /var/www/default/app.c
sudo echo '            "\t<head>\n"' >> /var/www/default/app.c
sudo echo '            "\t\t<meta charset=\"UTF-8\">\n"' >> /var/www/default/app.c
sudo echo '            "\t\t<title>Hello World from FastCGI!</title>\n"' >> /var/www/default/app.c
sudo echo '            "\t</head>\n"' >> /var/www/default/app.c
sudo echo '            "\t<body>\n"' >> /var/www/default/app.c
sudo echo '            "\t\t<h1>Hello World from FastCGI!</h1>\n"' >> /var/www/default/app.c
sudo echo '            "\t\t<p>This is the %i view!</p>\n"' >> /var/www/default/app.c
sudo echo '            "\t</body>\n"' >> /var/www/default/app.c
sudo echo '            "</html>",' >> /var/www/default/app.c
sudo echo '            count' >> /var/www/default/app.c
sudo echo '        );' >> /var/www/default/app.c
sudo echo '    }' >> /var/www/default/app.c
sudo echo '    return 0;' >> /var/www/default/app.c
sudo echo '}' >> /var/www/default/app.c
cd /usr/include
sudo wget –O https://raw.githubusercontent.com/lukastautz/nginx-install/main/fcgi-headers.tar.xz
sudo tar -xf --overwrite fcgi-headers.tar.xz
sudo rm fcgi-headers.tar.xz
sudo gcc /var/www/default/app.c -lfcgi -o /var/www/default/app.fcgi
sudo cgi-fcgi -connect 0.0.0.0:9999 /var/www/default/app.fcgi
sudo service nginx restart
