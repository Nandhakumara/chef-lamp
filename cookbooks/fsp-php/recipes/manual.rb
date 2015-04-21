version = node['fsp-php']['version']

remote_file "#{Chef::Config[:file_cache_path]}/php-#{version}.tar.gz" do
  source "#{node['fsp-php']['url']}/php-#{version}.tar.gz/from/this/mirror"
  mode '0644'
  not_if "which node['fsp-php']['bin']"
end

if node['fsp-php']['ext_dir']
  directory node['fsp-php']['ext_dir'] do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
  ext_dir_prefix = "EXTENSION_DIR=#{node['fsp-php']['ext_dir']}"
else
  ext_dir_prefix = ''
end

bash 'build fsp-php' do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -zxf php-#{version}.tar.gz
  (cd php-#{version} && #{ext_dir_prefix} ./configure #{configure_options})
  (cd php-#{version} && make && make install)
  EOF
  not_if "which node['fsp-php']['bin']"
end

directory node['fsp-php']['conf_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

directory node['fsp-php']['ext_conf_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

include_recipe "fsp-php::ini"