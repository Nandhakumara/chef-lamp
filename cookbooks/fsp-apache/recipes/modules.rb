node['fsp-apache']['modules'].each do |modul|
  package modul do
    action :install
  end
end