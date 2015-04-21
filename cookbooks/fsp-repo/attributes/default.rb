default['fsp-repo']['repo'] = %w{epel-release}

case node['platform_family']
when 'rhel'
  if node['platform_version'].to_i > 7
    default['fsp-repo']['epel-uri'] = 'http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-*.noarch.rpm'
    default['fsp-repo']['remi-uri'] = 'http://rpms.famillecollet.com/enterprise/remi-release-7.rpm'
  else
    default['fsp-repo']['epel-uri'] = 'http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-*.noarch.rpm'
    default['fsp-repo']['remi-uri'] = 'http://rpms.famillecollet.com/enterprise/remi-release-6.rpm'
  end
end
