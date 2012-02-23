Vagrant::Config.run do |config|
  config.vm.box = "Centos6.2"
  config.vm.host_name = "chamilo2-stable.vagrantup.com"
  config.ssh.max_tries = 420
  
  config.vm.forward_port 80, 8080
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "modules"
  end
end
