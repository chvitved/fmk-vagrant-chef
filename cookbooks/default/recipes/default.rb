apt_repository "best mirror" do
  uri "mirror://mirrors.ubuntu.com/mirrors.txt"
  components ["main", "restricted", "universe", "multiverse", "lucid-updates"]
  action :add
end

directory "/pack" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

