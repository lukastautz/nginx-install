sudo apt update -y
sudo apt upgrade -y
# sudo apt install -y curl gnupg2 ca-certificates
sudo apt install -y gcc libfcgi-dev ufw nginx-core libnginx-mod-http-headers-more-filter certbot python3-certbot-nginx spawn-fcgi
sudo systemctl enable nginx
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
sudo chmod -R -v 777 /etc/nginx
sudo rm -R /var/www/html
sudo rm /etc/nginx/sites-available/default
sudo echo "index index.html index.htm index.txt index.json index.jpg index.jpeg index.gif index.png;" >> /etc/nginx/sites-available/default
sudo echo "client_max_body_size 1024M;" >> /etc/nginx/sites-available/default
sudo echo "more_set_headers 'Server: FCGI/NGINX';" >> /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "    listen 80;" >> /etc/nginx/sites-available/default
sudo echo "    listen [::]:80 ipv6only=on;" >> /etc/nginx/sites-available/default
sudo echo "    root /var/www/default;" >> /etc/nginx/sites-available/default
sudo echo "    server_name $(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
sudo echo "    location ~ \"^/(static|favicon.ico|robots.txt)/\" {" >> /etc/nginx/sites-available/default
sudo echo "        error_page 404 http://\$server_name/404;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "    location / {" >> /etc/nginx/sites-available/default
sudo echo "        fastcgi_pass unix:/var/sockets/default;" >> /etc/nginx/sites-available/default
sudo echo "        fastcgi_buffering off;" >> /etc/nginx/sites-available/default
sudo echo "        include /etc/nginx/fastcgi_params;" >> /etc/nginx/sites-available/default
sudo echo "    }" >> /etc/nginx/sites-available/default
sudo echo "}" >> /etc/nginx/sites-available/default
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
sudo mkdir /var/www/default/data
sudo chmod -R -v 777 /var
sudo echo 'Here is the app.c and app.fcgi (and favicon.ico + robots.txt) located. NOT MORE!' >> /var/www/default/README
sudo echo 'Here are all static files located. NO DYNAMIC APPLICATIONS!' >> /var/www/default/static/README
sudo echo '#include "fcgi_stdio.h"' >> /var/www/default/app.c
sudo echo '#include <stdlib.h>' >> /var/www/default/app.c
sudo echo 'int main()' >> /var/www/default/app.c
sudo echo '{' >> /var/www/default/app.c
sudo echo '    int count = 0;' >> /var/www/default/app.c
sudo echo '    while (FCGI_Accept() >= 0)' >> /var/www/default/app.c
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
sudo echo '            "\t\t<p>Request number %i on host %s!<hr></p>\n"' >> /var/www/default/app.c
sudo echo '            "\t</body>\n"' >> /var/www/default/app.c
sudo echo '            "</html>",' >> /var/www/default/app.c
sudo echo '            count,' >> /var/www/default/app.c
sudo echo '            getenv("SERVER_NAME")' >> /var/www/default/app.c
sudo echo '        );' >> /var/www/default/app.c
sudo echo '    }' >> /var/www/default/app.c
sudo echo '    return 0;' >> /var/www/default/app.c
sudo echo '}' >> /var/www/default/app.c
cd /usr/include
sudo rm fastcgi.h
sudo rm fcgiapp.h
sudo rm fcgi_config.h
sudo rm fcgimisc.h
sudo rm fcgio.h
sudo rm fcgios.h
sudo rm fcgi_stdio.h
sudo wget –O https://raw.githubusercontent.com/lukastautz/nginx-install/main/fcgi-headers.tar.xz
sudo tar -xf fcgi-headers.tar.xz
sudo rm fcgi-headers.tar.xz
sudo gcc /var/www/default/app.c -lfcgi -o /var/www/default/app.fcgi
sudo mkdir /var/sockets
sudo spawn-fcgi -s/var/sockets/default /var/www/default/app.fcgi
sudo touch /etc/init.d/spawn-fastcgi.sh
sudo chmod 777 /etc/init.d/spawn-fastcgi.sh
sudo echo "# Copyright (C) 2022 Lukas Tautz" >> /etc/init.d/spawn-fastcgi.sh
sudo echo "# Spawn the FastCGI Processes" >> /etc/init.d/spawn-fastcgi.sh
sudo echo "spawn-fcgi -s/var/sockets/default /var/www/default/app.fcgi" >> /etc/init.d/spawn-fastcgi.sh
sudo chmod 700 /etc/init.d/spawn-fastcgi.sh
sudo chmod +x /etc/init.d/spawn-fastcgi.sh
sudo service nginx restart
# Clear unnecessary files:
# sudo rm -R /usr/share/GeoIP
# sudo rm -R /usr/share/man
# sudo rm -R /usr/share/dict
# sudo rm -R /usr/share/doc