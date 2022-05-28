#!/bin/bash
# Copyright (C) 2022 Lukas Tautz
# Version: PHP7.4
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl gnupg2 ca-certificates lsb-release
sudo apt install -y nginx
sudo systemctl enable nginx
sudo apt install -y ufw
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'Nginx HTTPS'
sudo apt install -y php-fpm
sudo apt install -y php-mbstring php-xml php-gd php-curl php-bcmath
sudo rm -r /var/www/html
sudo rm -r /etc/apache2
sudo chmod -R -v 777 /var
sudo chmod -R -v 777 /etc/php
sudo chmod -R -v 777 /etc/nginx
sudo apt install -y nginx-extras
sudo apt install -y certbot python3-certbot-nginx
sudo rm /etc/nginx/sites-available/default
sudo echo "server {" >> /etc/nginx/sites-available/default
sudo echo "        listen 80 default_server;" >> /etc/nginx/sites-available/default
sudo echo "        listen [::]:80 default_server;" >> /etc/nginx/sites-available/default
sudo echo "        server_tokens off;" >> /etc/nginx/sites-available/default
sudo echo "        more_set_headers 'Server: NGINX';" >> /etc/nginx/sites-available/default
sudo echo "        root /var/www/$(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
sudo echo "        index index.html index.htm index.php index.jpg index.jpeg index.gif index.json index.txt;" >> /etc/nginx/sites-available/default
sudo echo "        server_name $(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
sudo echo "        client_max_body_size 1024M;" >> /etc/nginx/sites-available/default
sudo echo "        location / {" >> /etc/nginx/sites-available/default
sudo echo "                error_page 404 http://$(hostname -I | sed 's/ *$//g');" >> /etc/nginx/sites-available/default
sudo echo "                try_files \$uri \$uri/ =404;" >> /etc/nginx/sites-available/default
sudo echo "        }" >> /etc/nginx/sites-available/default
sudo echo "        location ~ .php$ {" >> /etc/nginx/sites-available/default
sudo echo "        include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-available/default
sudo echo "        fastcgi_pass unix:/var/run/php/php-fpm.sock;" >> /etc/nginx/sites-available/default
sudo echo "        }" >> /etc/nginx/sites-available/default
sudo echo "}" >> /etc/nginx/sites-available/default
sudo mkdir /var/www/$(hostname -I | sed 's/ *$//g')
sudo chmod -R -v 777 /var/www
sudo echo "<h1>NGINX is running&#33;</h1>" >> /var/www/$(hostname -I | sed 's/ *$//g')/index.php
sudo echo "<p>You can activate TLS with executing 'sudo certbot --nginx -d DOMAIN'. Then, you must restart NGINX with 'sudo service nginx restart'.</p>" >> /var/www/$(hostname -I | sed 's/ *$//g')/index.php
sudo echo "<h2>PHP Info:</h2>" >> /var/www/$(hostname -I | sed 's/ *$//g')/index.php
sudo echo "<?php" >> /var/www/$(hostname -I | sed 's/ *$//g')/index.php
sudo echo "phpinfo();" >> /var/www/$(hostname -I | sed 's/ *$//g')/index.php
sudo echo "?>" >> /var/www/$(hostname -I | sed 's/ *$//g')/index.php
sudo rm /etc/php/7.4/fpm/php.ini
sudo echo '[PHP]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'engine = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'short_open_tag = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'precision = 14' >> /etc/php/7.4/fpm/php.ini
sudo echo 'output_buffering = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'zlib.output_compression = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'implicit_flush = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'unserialize_callback_func =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'serialize_precision = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'disable_functions = pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wifcontinued,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_get_handler,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,pcntl_async_signals,pcntl_unshare,' >> /etc/php/7.4/fpm/php.ini
sudo echo 'disable_classes =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'zend.enable_gc = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'zend.exception_ignore_args = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'expose_php = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'max_execution_time = 60' >> /etc/php/7.4/fpm/php.ini
sudo echo 'max_input_time = 60' >> /etc/php/7.4/fpm/php.ini
sudo echo 'memory_limit = 1152M' >> /etc/php/7.4/fpm/php.ini
sudo echo 'error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT' >> /etc/php/7.4/fpm/php.ini
sudo echo 'display_errors = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'display_startup_errors = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'log_errors = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'log_errors_max_len = 1024' >> /etc/php/7.4/fpm/php.ini
sudo echo 'ignore_repeated_errors = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'ignore_repeated_source = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'report_memleaks = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'variables_order = "GPCS"' >> /etc/php/7.4/fpm/php.ini
sudo echo 'request_order = "GP"' >> /etc/php/7.4/fpm/php.ini
sudo echo 'register_argc_argv = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'auto_globals_jit = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'post_max_size = 1024M' >> /etc/php/7.4/fpm/php.ini
sudo echo 'auto_prepend_file =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'auto_append_file =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'default_mimetype = "text/html"' >> /etc/php/7.4/fpm/php.ini
sudo echo 'default_charset = "UTF-8"' >> /etc/php/7.4/fpm/php.ini
sudo echo 'doc_root =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'user_dir =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'enable_dl = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'file_uploads = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'upload_max_filesize = 512M' >> /etc/php/7.4/fpm/php.ini
sudo echo 'max_file_uploads = 100' >> /etc/php/7.4/fpm/php.ini
sudo echo 'allow_url_fopen = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'allow_url_include = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'default_socket_timeout = 60' >> /etc/php/7.4/fpm/php.ini
sudo echo '[CLI Server]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'cli_server.color = On' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Date]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[filter]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[iconv]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[imap]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[intl]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[sqlite3]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Pcre]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Pdo]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Pdo_mysql]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'pdo_mysql.default_socket=' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Phar]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[mail function]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'SMTP = localhost' >> /etc/php/7.4/fpm/php.ini
sudo echo 'smtp_port = 25' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mail.add_x_header = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo '[ODBC]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'odbc.allow_persistent = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'odbc.check_persistent = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'odbc.max_persistent = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'odbc.max_links = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'odbc.defaultlrl = 4096' >> /etc/php/7.4/fpm/php.ini
sudo echo 'odbc.defaultbinmode = 1' >> /etc/php/7.4/fpm/php.ini
sudo echo '[MySQLi]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.max_persistent = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.allow_persistent = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.max_links = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.default_port = 3306' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.default_socket =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.default_host =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.default_user =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.default_pw =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqli.reconnect = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo '[mysqlnd]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqlnd.collect_statistics = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'mysqlnd.collect_memory_statistics = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo '[OCI8]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[PostgreSQL]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'pgsql.allow_persistent = On' >> /etc/php/7.4/fpm/php.ini
sudo echo 'pgsql.auto_reset_persistent = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo 'pgsql.max_persistent = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'pgsql.max_links = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'pgsql.ignore_notice = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo 'pgsql.log_notice = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo '[bcmath]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'bcmath.scale = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo '[browscap]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Session]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.save_handler = files' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.use_strict_mode = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.use_cookies = 1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.use_only_cookies = 1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.name = PHPSESSID' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.auto_start = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.cookie_lifetime = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.cookie_path = /' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.cookie_domain =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.cookie_httponly =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.cookie_samesite =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.serialize_handler = php' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.gc_probability = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.gc_divisor = 1000' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.gc_maxlifetime = 1440' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.referer_check =' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.cache_limiter = nocache' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.cache_expire = 180' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.use_trans_sid = 0' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.sid_length = 26' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.trans_sid_tags = "a=href,area=href,frame=src,form="' >> /etc/php/7.4/fpm/php.ini
sudo echo 'session.sid_bits_per_character = 5' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Assertion]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'zend.assertions = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo '[COM]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[mbstring]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[gd]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[exif]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[Tidy]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'tidy.clean_output = Off' >> /etc/php/7.4/fpm/php.ini
sudo echo '[soap]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'soap.wsdl_cache_enabled=1' >> /etc/php/7.4/fpm/php.ini
sudo echo 'soap.wsdl_cache_dir="/tmp"' >> /etc/php/7.4/fpm/php.ini
sudo echo 'soap.wsdl_cache_ttl=86400' >> /etc/php/7.4/fpm/php.ini
sudo echo 'soap.wsdl_cache_limit = 5' >> /etc/php/7.4/fpm/php.ini
sudo echo '[sysvshm]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[ldap]' >> /etc/php/7.4/fpm/php.ini
sudo echo 'ldap.max_links = -1' >> /etc/php/7.4/fpm/php.ini
sudo echo '[dba]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[opcache]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[curl]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[openssl]' >> /etc/php/7.4/fpm/php.ini
sudo echo '[ffi]' >> /etc/php/7.4/fpm/php.ini
sudo service nginx restart
sudo service php7.4-fpm restart
printf "\n"
printf "\n"
echo "NGINX Web Server and PHP 7.4 are succesfully installed!"
echo "It's recommended to reboot Linux, but it's not needed"
echo "The PHP files are located in /var/www."
echo "The NGINX settings files are located in /etc/nginx/sites-available"
echo "The php.ini file is located in /etc/php/7.4/fpm"
printf "\n"
echo "You can open the standard page under http://$(hostname -I | sed 's/ *$//g')."
