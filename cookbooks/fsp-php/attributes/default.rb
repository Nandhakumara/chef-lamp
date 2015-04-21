# http://php.net/downloads.php
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: php
# Attribute:: default
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['fsp-php']['install_method'] = 'package'
default['fsp-php']['bin'] = 'php'

default['fsp-php']['pear'] = 'pear'
default['fsp-php']['pecl'] = 'pecl'

lib_dir = kernel['machine'] =~ /x86_64/ ? 'lib64' : 'lib'

default['fsp-php']['directives'] = {}

case node['platform_family']
when 'rhel', 'fedora'
  default['fsp-php']['conf_dir']      = '/etc'
  default['fsp-php']['ext_conf_dir']  = '/etc/php.d'
  default['fsp-php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
  default['fsp-php']['pear_dir']      = '/usr/share/pear'
  default['fsp-php']['session_dir']   = '/var/lib/php/session'
  default['fsp-php']['upload_dir']    = '/var/lib/php/uploads'
  default['fsp-php']['essentials']    = %w{autoconf bison flex gcc gcc-c++ kernel-devel make m4 patch}
  default['fsp-php']['packages']      = %w{php php-devel php-common php-pear php-cli php-pear php-pdo php-mysql php-gd php-mbstring php-xml php-soap php-curl phpmyadmin}
when 'debian'
  default['fsp-php']['conf_dir']      = '/etc/php5/cli'
  default['fsp-php']['apache_conf_dir'] = '/etc/php5/apache2'
  default['fsp-php']['cgi_conf_dir']  = '/etc/php5/cgi'
  default['fsp-php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['fsp-php']['pear_dir']      = '/usr/share/php'
  default['fsp-php']['session_dir']   = '/var/lib/php5/session5'
  default['fsp-php']['upload_dir']    = '/var/lib/php5/uploads'
  default['fsp-php']['essentials']    = %w{autoconf binutils-doc bison build-essential flex gettext ncurses-dev}
else
  default['fsp-php']['conf_dir']      = '/etc/php5/cli'
  default['fsp-php']['apache_conf_dir'] = '/etc/php5/apache2'
  default['fsp-php']['cgi_conf_dir']  = '/etc/php5/cgi'
  default['fsp-php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['fsp-php']['pear_dir']      = '/usr/share/php'
  default['fsp-php']['session_dir']   = '/var/lib/php5/session5'
  default['fsp-php']['upload_dir']    = '/var/lib/php5/uploads'
  default['fsp-php']['essentials']    = %w{autoconf bison flex gcc gcc-c++ kernel-devel make m4 patch}
end


default['fsp-php']['tmpfs'] = true
default['fsp-php']['tmpfs_size'] = '128M'
default['fsp-php']['template'] = "php.ini.erb"
default['fsp-php']['ini']['cookbook'] = "fsp-php"
default['fsp-php']['url'] = 'http://us1.php.net/get'
default['fsp-php']['version'] = '5.6.7'
default['fsp-php']['prefix_dir'] = '/usr/local'

default['fsp-php']['configure_options'] = %W{--prefix=node['fsp-php']['prefix_dir']
                                         --with-libdir=#{lib_dir}
                                         --with-config-file-path=node['fsp-php']['conf_dir']
                                         --with-config-file-scan-dir=node['fsp-php']['ext_conf_dir']
                                         --with-pear
                                         --enable-fpm
                                         --with-zlib
                                         --with-openssl
                                         --with-kerberos
                                         --with-bz2
                                         --with-curl
                                         --enable-ftp
                                         --enable-zip
                                         --enable-exif
                                         --with-gd
                                         --enable-gd-native-ttf
                                         --with-gettext
                                         --with-gmp
                                         --with-mhash
                                         --with-iconv
                                         --with-imap
                                         --with-imap-ssl
                                         --enable-sockets
                                         --enable-soap
                                         --with-xmlrpc
                                         --with-mcrypt
                                         --enable-mbstring
                                         --with-t1lib
                                         --with-mysql
                                         --with-mysql-sock
                                         --with-pdo-mysql}

default['fsp-php']['secure_functions']['disable_functions'] = 'dl,posix_kill,posix_mkfifo,posix_setuid,proc_close,proc_open,proc_terminate,shell_exec,system,leak,posix_setpgid,posix_setsid,proc_get_status,proc_nice,show_source,virtual,proc_terminate,inject_code,define_syslog_variables,syslog,posix_uname'