# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "52"
client_key               "#{current_dir}/52.pem"
validation_client_name   "nandhacheflearn-validator"
validation_key           "#{current_dir}/nandhacheflearn-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/nandhacheflearn"
cookbook_path            ["#{current_dir}/../cookbooks"]
encrypted_data_bag_secret "#{current_dir}/encrypted_data_bag_secret"

knife[:rackspace_api_username] = "nandha.a"
knife[:rackspace_api_key] = "4e0261d6f95544f7ae76f9ca797fd784"
knife[:rackspace_region] = "ORD"

