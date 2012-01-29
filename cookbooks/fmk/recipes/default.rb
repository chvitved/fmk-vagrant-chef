t4Path = "/pack/trifork-4.1.35"
baseDir = t4Path + "/domains/"
domainName = "fmk"
serverName = "fmk"

execute "create domain" do
  command "./eas domain create " + baseDir + " " + domainName + " " + serverName
  cwd t4Path + "/server/bin"
  creates baseDir + domainName
  action :run
end

