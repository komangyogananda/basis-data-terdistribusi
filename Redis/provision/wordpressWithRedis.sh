# set source list
sudo cp /vagrant/sources/sources.list /etc/apt/

# dependency
sudo apt update
sudo apt install libaio1 libmecab2 -y

# Setting input for installation
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password admin'
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password admin'

# lamp
sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

# prepare mysql
sudo mysql -u root -padmin < /vagrant/mysql/wordpress.sql

# wordpress
sudo a2enmod rewrite
sudo systemctl restart apache2
cd /tmp
cp /vagrant/sources/latest.tar.gz /tmp
tar xzvf latest.tar.gz
sudo cp -a /tmp/wordpress/. /var/www/html/wordpress
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress/
sudo mkdir /var/www/html/wordpress/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/