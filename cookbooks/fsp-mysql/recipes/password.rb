search(:passbook, '*:*').each do |pass|
  execute "Update MySQL root password" do
    command "mysqladmin --user=root --password='' password #{pass['passwd']}"
    only_if "mysqladmin --user=root --password='' version"
    sensitive true
  end
end