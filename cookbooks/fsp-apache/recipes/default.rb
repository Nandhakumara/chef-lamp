#
# Cookbook Name:: fsp-apache
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform_family']
when 'rhel'
  if node['platform_version'].to_i > 7
    include_recipe 'fsp-apache::server_rhel_7'
    include_recipe 'fsp-apache::modules'
  else
    include_recipe 'fsp-apache::server_rhel_6'
    include_recipe 'fsp-apache::modules'
  end
when 'debian'
  include_recipe 'fsp-apache::server_debian'
else
  fail "Unsupported platform '#{node['platform_family']}'"
end