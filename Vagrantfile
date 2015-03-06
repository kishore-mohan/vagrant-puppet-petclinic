# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "private_network", type: "dhcp"

 config.puppet_install.puppet_version = "3.7.4"

  config.vm.provider "virtualbox" do |v|
  #  v.memory = 1024
#    v.cpus = 1
#  v.customize ["modifyvm", :id, "--accelerate3d", "off"]
  end
# config.vm.synced_folder ".", "/vagrant", disabled: true 
  config.vm.provision :shell do |shell|
    shell.inline = "
                  sudo puppet module install puppetlabs-stdlib;
                  sudo puppet module install puppetlabs-java;
                  sudo puppet module install puppetlabs-tomcat;
                  sudo puppet module install puppetlabs-firewall;"
  end

  # https://docs.vagrantup.com/v2/provisioning/puppet_apply.html
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
    puppet.options=["--verbose --debug", "--reports http" ,"--reporturl=http://jenkins.localdomain:8090/puppet/report"]        
  end
end
