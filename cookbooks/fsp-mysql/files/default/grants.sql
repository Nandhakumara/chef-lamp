use mysql;
# remove remote access for root user
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

# Remove anonymous users
DELETE FROM mysql.user WHERE User='';

# Remove test database and access to it
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';

# Set the password for root@localhost
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('BnXC8PRGVKYVfzQ9AGETZ4ypyZkJs7AHDcv9');