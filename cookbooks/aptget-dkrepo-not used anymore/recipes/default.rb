template "/etc/apt/sources.list" do
    source "sources.list.erb"
end

execute "apt-get-update" do
  command "apt-get update"
end