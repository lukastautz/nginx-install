sudo service apache2 stop
sudo apt purge -y apache2-bin apache2-data apache2-utils apache2
sudo apt autoremove -y
sudo rm -R -v /usr/sbin/apache2
sudo rm -R -v /usr/sbin/apache2ctl
sudo rm -R -v /usr/lib/apache2
sudo rm -R -v /usr/share/apache2
sudo rm -v /usr/share/man/man8/apache2.8.gz
sudo rm -R -v /var/lib/apache2
sudo rm -R -v /run/apache2
sudo rm -R -v /var/cache/apache2
sudo rm -R -v /var/lib/apache2
sudo rm -R -v /var/lock/apache2
sudo rm -R -v /var/log/apache2
sudo rm -R -v /var/run/apache2