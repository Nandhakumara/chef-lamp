node['fsp-repo']['repo'].each do |name|
  package name do
    action :install
  end
end

execute "update" do
  command "rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm"
  not_if  "rpm -qa | grep remi"
end

template "/etc/yum.repos.d/epel.repo" do
  source "epel-repo_6.erb"
  owner 'root'
  group 'root'
  mode '0644'
end

template "/etc/yum.repos.d/remi.repo" do
  source "remi-repo_6.erb"
  owner 'root'
  group 'root'
  mode '0644'
end