execute "install rpm" do
  command "yum localinstall #{node['fsp-mysql']['server']['repo-uri']} -y"
  not_if  "rpm -qa | grep mysql-community-release"
end

node['fsp-mysql']['server']['packages'].each do |server|
  package server do
    action :install
  end
end

service "mysqld" do
  action [:enable, :start]
end

template "/etc/my.cnf" do
  source "my.cnf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[mysqld]'
end