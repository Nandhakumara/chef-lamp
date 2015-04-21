case node['platform_family']
when 'rhel'
  data_bag("vhosts").each do |site|
    site_data = data_bag_item("vhosts", site)
    project_root = site_data["projectfolder"]
    site_protocol = site_data["id"]
    document_root = "/var/www/#{project_root}"

    template "node['fsp-apache']['vhosts_dir']/#{site_name}.conf" do
      source "custom-vhosts.erb"
      mode "0644"
      variables(
        :document_root => document_root,
        :port => site_data["port"]
      )
      notifies :restart, "service[httpd]"
    end
 
  directory document_root do
    mode "0755"
    recursive true
  end
end

when 'debian'
  data_bag("vhosts").each do |site|
  site_data = data_bag_item("vhosts", site)
  project_root = site_data["projectfolder"]
  site_protocol = site_data["id"]
  document_root = "/var/www/#{site_name}"
 
  template "/etc/apache2/sites-available/#{site_name}" do
    source "custom-vhost.erb"
    mode "0644"
    variables(
      :document_root => document_root,
      :port => site_data["port"]
    )
  end
 
  execute "a2ensite #{site_name}" do
    not_if do
      ::File.symlink?("/etc/apache2/sites-enabled/#{site_name}")
    end
    notifies :restart, "service[apache2]"
  end
 
  directory document_root do
    mode "0755"
    recursive true
  end
end
end