usr="vagrant"
t4Path = "/pack/trifork-4.1.35"
baseDir = t4Path + "/domains/"
domainName = "fmk"
serverName = "fmk"

#create fmk domain in t4
execute "create domain" do
  command "./eas domain create " + baseDir + " " + domainName + " " + serverName
  user usr
  cwd t4Path + "/server/bin"
  creates baseDir + domainName
  action :run
end

#remove authentication when deploying to t4
file "/home/" + usr + "/.triforklogin" do
    owner usr
    mode "0755"
    action :create
    content "127.0.1.1trifork.password=795fe3553b9b3b547e74833e430c745a\n" +
            "127.0.1.1trifork.login=administrator\n"
end

#setup .bash_profile
template "/home/" + usr + "/.bash_profile"  do
    source "bash_profile.erb"
    owner usr
end

#HACK
#somehow one recipe end up making open jdk the default
#we need oracle
link "/usr/lib/jvm/default-java" do
    to "/usr/lib/jvm/jdk1.6.0_37"
end
