secrets = Chef::EncryptedDataBagItem.load("secrets", "mysql")

if secrets && mysql_passwords = secrets[node.chef_environment] 
  path="#{current_dir}/encrypted_data_bag_secret"
  server_root_password = mysql_passwords['root']
  system_passwd = mysql_passwords['fspadmin']
end


execute "Update MySQL root password" do  # ~FC009 - `sensitive`
  command "mysqladmin --user=root --password='' password '#{server_root_password}'"
  only_if "mysqladmin --user=root --password='' version"
  sensitive true
end