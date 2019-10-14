CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitorpassword';
GRANT SELECT on sys.* to 'monitor'@'%';
FLUSH PRIVILEGES;

CREATE USER 'kulguy'@'%' IDENTIFIED BY 'yoganteng';
GRANT ALL PRIVILEGES on *.* to 'kulguy'@'%';
FLUSH PRIVILEGES;