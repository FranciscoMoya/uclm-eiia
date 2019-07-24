sudo mkdir -p /var/run/eii
sudo chown nginx:nginx /var/run/eii
sudo systemctl restart nginx
sudo /usr/local/bin/uwsgi --ini wsgi.ini 

