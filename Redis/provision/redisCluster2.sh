sudo cp /vagrant/sources/sources.list /etc/apt/

# dependency
sudo apt update
sudo apt install build-essential tcl -y
sudo apt install libjemalloc-dev -y
sudo apt install tmux -y

# install redis
sudo apt install redis-server -y

# configuration
cd ~
mkdir redis
cp /vagrant/redis-config/redisCluster2.conf redis/redis.conf
cp /vagrant/sentinel-config/redisCluster2.conf redis/sentinel.conf
touch redis/redis.log
touch redis/sentinel.log

# allow port
sudo ufw allow 6379
sudo ufw allow 26379

# start redis
sudo redis-server redis/redis.conf --daemonize yes
sudo redis-server redis/sentinel.conf --sentinel --daemonize yes