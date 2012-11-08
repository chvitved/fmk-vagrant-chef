props = eval(File.open('myconfig') {|f| f.read })
Vagrant::Config.run do |config|
 
  config.vm.box = "base32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  config.vm.box_url = "http://nexus.ci82.trifork.com/content/repositories/trifork-internal/vagrantfiles/lucid32/2/lucid32-2.box"
  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host only network IP, allowing you to access it
  # via the IP.
  config.vm.network :hostonly,  "33.33.33.10"  

  config.vm.customize [
 	"modifyvm", :id,
  	"--name", "FMK VM",
  	"--memory", "2048",
	"--cpus", "4"
  ]
  config.vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"] # make the vpn connection from the host machine work for the image
  
  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
   config.vm.forward_port  3306, 3306  #mysql
   config.vm.forward_port  8080, 8080  #t4 web
   config.vm.forward_port  8090, 8090  #t4 console
   config.vm.forward_port  8070, 8070  #t4 deploy
   config.vm.forward_port  8000, 8000  #t4 java debug port
   config.vm.forward_port  8098, 8098  #riak http 
   config.vm.forward_port  8087, 8087  #riak pb

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # props are loaded at the top from the file myconfig
  config.vm.share_folder "projects", "/projects", props[:projects]
  config.vm.share_folder "ivy", "/home/vagrant/.ivy2", props[:ivy2]
  #config.vm.share_folder "v-root", "/vagrant", "."
  
  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "riak"
    chef.add_recipe "default" # default start risk as there is a bug. riak cookbook at github blames this on the chef version
    chef.add_recipe "java"
    chef.add_recipe "ant"
    chef.add_recipe "gradle::tarball" 
    chef.add_recipe "mysql::server"

    chef.add_recipe "trifork-t4-4.1.35"
    chef.add_recipe "fmk"
    chef.add_recipe "timezone"
    chef.add_recipe "ntp"
    # You may also specify custom JSON attributes:
    chef.json.merge!({
      :mysql => {
        :server_root_password => "",
		:bind_address => "0.0.0.0",
		:allow_remote_root => true  
      },
	# I could not make all the riak attributes work when putting them in here instead I have changed the riak cookbook attributes/default.rb
	:riak => {:config => {
			:riak_kv => {
				:storage_backend => "riak_kv_eleveldb_backend"
			}
		}
      },
      :java => {
        :install_flavor => "oracle",
	:oracle => {
       	  "accept_oracle_download_terms" => true
        }
      },
      :gradle => {:version=>"1.0"},
      :tz => "Europe/Copenhagen"
    })
   
  end

end

