props = eval(File.open('myconfig') {|f| f.read })
Vagrant::Config.run do |config|
 
  config.vm.box = "base64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  ipAddress = "172.24.24.24"
  config.vm.network :hostonly, ipAddress
  
  config.vm.customize [
 	"modifyvm", :id,
  	"--name", "FMK VM",
  	"--memory", "2048"
  ]
  
  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
   config.vm.forward_port  3306, 3306  #mysql
   config.vm.forward_port  8080, 8080  #t4 web
   config.vm.forward_port  8090, 8090  #t4 console
   config.vm.forward_port  8000, 8000  #t4 java debug port
   config.vm.forward_port  8098, 8098  #riak http 
   config.vm.forward_port  8087, 8087  #riak pb

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # props are loaded at the top from the file myconfig
  config.vm.share_folder "projects", "/projects", props[:projects]
  
  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "default" 
    chef.add_recipe "riak"
    chef.add_recipe "java"
    chef.add_recipe "ant"
    chef.add_recipe "gradle::tarball" 
    chef.add_recipe "mysql::server"
    chef.add_recipe "trifork-t4-4.1.35"
    chef.add_recipe "fmk"
    chef.add_recipe "timezone"

 
    # You may also specify custom JSON attributes:
    chef.json.merge!({
      :mysql => {
        :server_root_password => "",
		:bind_address => "0.0.0.0",
		:allow_remote_root => true  
      },
      :riak => {
		:core => {:http => [["0.0.0.0", 8098]] },
		:kv => {
			:pb_ip => "0.0.0.0",
			:pb_port => 8087
		}
      },
      :java => {
        :install_flavor => "openjdk"
      },
    :tz => "Europe/Copenhagen"
    })
   
  end

end

