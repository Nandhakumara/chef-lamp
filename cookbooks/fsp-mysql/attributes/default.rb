case node['platform_family']
when 'rhel', 'fedora'
  if node['platform_version'].to_i > 7
    default['fsp-mysql']['client']['packages'] = %w[mysql mysql-devel]
    default['fsp-mysql']['server']['packages'] = %w[mysql-community-server]
    default['fsp-mysql']['server']['packages']['repo-uri']  = 'http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm'
  else
    default['fsp-mysql']['client']['packages'] = %w[mysql mysql-devel]
    default['fsp-mysql']['server']['packages'] = %w[mysql-community-server]
    default['fsp-mysql']['server']['repo-uri']  = 'http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm'
  end
when 'debian'
  if debian_before_squeeze? || ubuntu_before_lucid?
    default['fsp-mysql']['client']['packages'] = %w[mysql-client libmysqlclient15-dev]
    default['fsp-mysql']['server']['packages'] = %w[mysql]
  else
    default['fsp-mysql']['client']['packages'] = %w[mysql-client libmysqlclient-dev]
  end
else
  default['fsp-mysql']['client']['packages'] = %w[mysql-client libmysqlclient-dev]
end

default['fsp-mysql']['config']['file']  = '/etc/my.cnf'
default['fsp-mysql']['service_name'] = 'default'

# used in grants.sql
default['fsp-mysql']['allow_remote_root'] = false
default['fsp-mysql']['remove_anonymous_users'] = true
default['fsp-mysql']['root_network_acl'] = nil

default['fsp-mysql']['config_dir'] = '/etc/mysql'
default['fsp-mysql']['data_dir'] = '/var/lib/mysql'

# ports and bind address
default['fsp-mysql']['port'] = '3306'
# if you want server to be a stand-alone set bind_ip to 127.0.0.1 not nil
default['fsp-mysql']['bind_ip'] = nil

default['fsp-mysql']['server_package_action'] = 'install'