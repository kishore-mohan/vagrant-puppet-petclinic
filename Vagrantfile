# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provision :shell do |shell|
    shell.inline = "
                  sudo puppet module install puppetlabs-stdlib;
                  sudo puppet module install puppetlabs-java;
                  sudo puppet module install stahnma/epel;
                  sudo puppet module install puppetlabs-tomcat;
                  sudo puppet module install puppetlabs-firewall;"
  end

  # https://docs.vagrantup.com/v2/provisioning/puppet_apply.html
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
    puppet.options=["--verbose"]
  end
end
