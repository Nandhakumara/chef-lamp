case node['platform_family']
when 'rhel'
  default['fsp-apache']['package'] = ['httpd']
  default['fsp-apache']['bin'] = 'httpd'
  default['fsp-apache']['vhosts_dir'] = '/etc/httpd/vhosts.d/'
  default['fsp-apache']['vhost_default'] = '/etc/httpd/vhosts.d/default.conf'
  default['fsp-apache']['conf_dir'] = '/etc/httpd/conf.d'
  default['fsp-apache']['conf_file'] = '/etc/httpd/conf/httpd.conf'
  default['fsp-apache']['log_dir'] = '/var/log/httpd/'
  default['fsp-apache']['modules'] = %w{mod_ssl openssl-devel mod_evasive mod_security}
when 'debian'
  default['fsp-apache']['package'] = ['apache2']
  default['fsp-apache']['bin'] = 'apache2'
  default['fsp-apache']['vhosts_dir'] = '/etc/apache2/sites.available/'
  default['fsp-apache']['vhost_default'] = '/etc/apache2/sites.available/default.conf'
  default['fsp-apache']['conf_dir'] = '/etc/apache2/'
  default['fsp-apache']['conf_file'] = '/etc/apache2/apache2.conf'
else
  default['fsp-apache']['bin'] = 'httpd'
  default['fsp-apache']['vhosts_dir'] = '/etc/httpd/vhosts.d/'
  default['fsp-apache']['vhost_default'] = '/etc/httpd/vhosts.d/default.conf'
  default['fsp-apache']['conf_dir'] = '/etc/httpd/conf.d'
  default['fsp-apache']['conf_file'] = '/etc/httpd/conf/httpd.conf'
  default['fsp-apache']['log_dir'] = '/var/log/httpd/'
end

default['fsp-apache']['rhel']['template'] = "http.conf.erb"
default['fsp-apache']['debian']['template'] = "apache.conf.erb"
default['fsp-apache']['cookbook'] = "fsp-apache"