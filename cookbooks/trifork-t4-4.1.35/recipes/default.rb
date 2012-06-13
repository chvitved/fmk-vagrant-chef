install_dir = "/pack/trifork-4.1.35"
user = "vagrant"

directory install_dir do
  owner user
  group user
  mode "0755"
  action :create
end

link "/pack/trifork" do
    to install_dir
end

remote_directory install_dir do
  source "t4-plain"
  files_backup 0
  files_owner user
  files_group user
  files_mode "0755"
  mode "0755"
end

directory install_dir + "/domains" do
  owner user
  group user
  mode "0755"
  action :create
end

directory install_dir + "/server/license" do
  owner user
  group user
  mode "0755"
  action :create
end

remote_file install_dir + "/server/license/license.txt" do
  source "license.txt"
  mode "0755"
end


