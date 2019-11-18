# Add hostname
sudo cp /vagrant/sources/hosts /etc/hosts

# Copy APT sources list
sudo cp /vagrant/sources/sources.list /etc/apt/
sudo cp /vagrant/sources/mongodb-org-4.2.list /etc/apt/sources.list.d/

# Add MongoDB repo key
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -

# Update Repository
sudo apt-get update
# sudo apt-get upgrade -y

# Install MongoDB
sudo apt-get install -y mongodb-org

sudo systemctl start mongod

# sudo cp /vagrant/config/mongodConfig1.conf /etc/mongod.conf

# sudo systemctl restart mongod

# mongo mongoConfig1:27019 < /vagrant/scriptmongo/config1