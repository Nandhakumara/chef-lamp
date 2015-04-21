case node['platform_family']
when 'rhel'
  if node['platform_version'].to_i > 7
    include_recipe 'fsp-mysql::server_rhel_7'
    include_recipe 'fsp-mysql::password'
  else 
    include_recipe 'fsp-mysql::server_rhel_6'
    include_recipe 'fsp-mysql::password'
  end
end