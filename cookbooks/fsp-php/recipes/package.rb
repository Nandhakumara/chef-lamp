node['fsp-php']['packages'].each do |pkg|
    package pkg do
      action :install
    end
end

template "/etc/httpd/conf.d/phpMyAdmin.conf" do
  source "phpMyAdmin.conf.erb"
  mode "0644"
  owner "root"
  group "root"
  notifies :restart, 'service[httpd]', :immediately
end

include_recipe "fsp-php::ini"