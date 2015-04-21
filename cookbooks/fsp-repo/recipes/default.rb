#
# Cookbook Name:: yumrepo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "epel-release" do 
	action :install
end

case node['platform_family']
when 'rhel'
  if node['platform_version'].to_i > 7
    include_recipe 'fsp-repo::server_rhel_7'
  else 
    include_recipe 'fsp-repo::server_rhel_6'
  end
end