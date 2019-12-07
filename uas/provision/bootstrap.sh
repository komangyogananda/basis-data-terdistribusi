# Referensi:
# https://pingcap.com/docs/stable/how-to/deploy/from-tarball/testing-environment/

# Update the repositories
# sudo yum update -y

# Copy open files limit configuration
sudo cp /vagrant/config/tidb.conf /etc/security/limits.d/

# Enable max open file
sudo sysctl -w fs.file-max=1000000

# Copy atau download TiDB binary dari http://download.pingcap.org/tidb-v3.0-linux-amd64.tar.gz
cp /vagrant/installer/tidb-v3.0-linux-amd64.tar.gz .

# Extract TiDB binary
tar -xzf tidb-v3.0-linux-amd64.tar.gz && mv tidb-v3.0-linux-amd64 tidb

# Install MariaDB to get MySQL client, Git, and Nano.
sudo yum -y install mariadb git nano

# Download and Extract Node Exporter
cp /vagrant/installer/node_exporter-0.18.1.linux-amd64.tar.gz .
tar -xzf node_exporter-0.18.1.linux-amd64.tar.gz