template "/etc/php.ini" do
	source "php.ini.erb"
	cookbook "fsp-php"
	owner 'root'
	group 'root'
	mode '0644'
  variables({
    'short_open_tag' => 'On',
    'open_basedir' => '',
    'max_execution_time' => '300',
    'max_input_time' => '300',
    'memory_limit' => '128M',
    'error_reporting' => 'E_ALL & ~E_DEPRECATED & ~E_NOTICE',
    'display_errors' => 'Off',
    'error_log' => '',
    'register_globals' => 'Off',
    'register_long_arrays' => 'Off',
    'post_max_size' => '32M',
    'magic_quotes_gpc' => 'Off',
    'allow_url_fopen' => 'On',
    'allow_url_include' => 'Off',
    'always_populate_raw_post_data' => 'Off',
    'upload_max_filesize' => '32M',
    'sendmail_path' => '/usr/sbin/sendmail.postfix -t -i'
})
  notifies :restart, 'service[httpd]', :immediately
end