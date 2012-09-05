user = "vagrant"

apt_repository "best mirror" do
  uri "mirror://mirrors.ubuntu.com/mirrors.txt"
  components ["main", "restricted", "universe", "multiverse", "lucid-updates"]
  action :add
end

directory "/pack" do
  owner user
  group user
  mode "0755"
  action :create
end

package "curl" do
    action :install
end

service "riak" do # there is a bug so this does not work in the riak cookbook
    action :start
end