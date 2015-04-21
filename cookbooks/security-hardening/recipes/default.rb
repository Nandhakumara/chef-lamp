search(:users, '*:*').each do |u|
  user u['user_name'] do
    comment u['comment']
    supports manage_home: true
  end

  directory "/home/#{u['user_name']}/.ssh" do
    owner u['user_name']
    group u['user_name']
    mode '700'
  end

  file "/home/#{u['user_name']}/.ssh/authorized_keys" do
    owner u['user_name']
    group u['user_name']
    mode '600'
    content u['ssh_keys'].join("\n")
  end
end

template "/etc/sudoers" do
  source "sudoers.erb"
  mode '0440'
  owner 'root'
  group 'root'
  variables({
     :sudoers_groups => node[:authorization][:sudo][:groups],
     :sudoers_users => node[:authorization][:sudo][:users]
  })
end

template "/etc/ssh/sshd_config" do
  source "sshd.erb"
  mode '0400'
  owner 'root'
  group 'root'
  notifies :restart, 'service[sshd]'
end

service "sshd" do
  supports :start => true, :stop => true, :restart => true, :status => true 
  action :nothing
end

case node['platform_family']
  when 'rhel'
    if node['platform_version'].to_i > 7
      execute "firewall" do
        command << -EOF
          chkconfig firewalld off
          service firewalld stop
          chkconfig iptables on
          service iptables start
        EOF
        not_if { ::File.exists?("/etc/sysconfig/iptables")}
        template "/etc/sysconfig/iptables" do
          source "iptables.erb"
          mode "0600"
          owner "root"
          group 'root'
          variables({
            :allowed_ips => node["authorization"]["firewall"]["ip_allow"],
            :allowed_ports => node["authorization"]["firewall"]["ports"],
            :denied_ips => node["authorization"]["firewall"]["ip_deny"]
          })
          notifies :restart, 'service[iptables]'
        end
      end
    else
      template "/etc/sysconfig/iptables" do
         source "iptables.erb"
         mode "0600"
         owner "root"
         group 'root'
         variables({
           :allowed_ips => node["authorization"]["firewall"]["ip_allow"],
           :allowed_ports => node["authorization"]["firewall"]["ports"],
           :denied_ips => node["authorization"]["firewall"]["ip_deny"]
         })
         notifies :restart, 'service[iptables]'
      end
    end
end

service "iptables" do
  supports :start => true, :stop => true, :restart => true, :status => true 
  action :nothing
end