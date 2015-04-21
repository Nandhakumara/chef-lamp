node['fsp-apache']['package'].each do |name|
  package name do
    action :install
  end
end