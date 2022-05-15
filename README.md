# nginx-install
## PHP 8.0:
### No JIT:
```bash
sudo wget -O - https://raw.githubusercontent.com/lukastautz/nginx-install/main/php8_nojit.sh | bash
```
### 256MB JIT:
```bash
sudo wget -O - https://raw.githubusercontent.com/lukastautz/nginx-install/main/php8_256jit.sh | bash
```
### 512MB JIT:
```bash
sudo wget -O - https://raw.githubusercontent.com/lukastautz/nginx-install/main/php8_512jit.sh | bash
```
### 1024MB JIT:
```bash
sudo wget -O - https://raw.githubusercontent.com/lukastautz/nginx-install/main/php8_1024jit.sh | bash
```
### 2048MB JIT:
```bash
sudo wget -O - https://raw.githubusercontent.com/lukastautz/nginx-install/main/php8_2048jit.sh | bash
```
<hr>

## PHP 7.4:
```bash
sudo wget -O - https://raw.githubusercontent.com/lukastautz/nginx-install/main/php7.4.sh | bash
```
<hr>

## Requirements:
The only requirement is sudo!
You can install sudo as root very simple:
```bash
apt install sudo
adduser USER sudo
```
USER is the user who installs NGINX and PHP.
