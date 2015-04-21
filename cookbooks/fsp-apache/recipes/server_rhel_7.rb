node['fsp-apache']['package'].each do |name|
  package name do
    action :install
  end
end

directory node['fsp-apache']['vhosts_dir'] do
  action :create
  mode "0755"
  recursive true
  owner "root"
  group "root"
end

service "httpd" do
  action [:enable, :start]
end

template node['fsp-apache']['vhost_default'] do
  source "default.conf.erb"
  mode "0644"
  owner "root"
  group "root"
end

template node['fsp-apache']['conf_file'] do
  source "http.conf-7.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, 'service[httpd]'
end

package "ntp" do
  action :install
end

service "ntpd" do
  action [:enable, :start]
end