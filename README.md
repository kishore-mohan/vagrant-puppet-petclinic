# vagrant-puppet-petclinic


## Vagrant Container

* Launches the `puppetlabs/centos-7.0-64-puppet` box from [PuppetLabs Vagrant Box](http://puppet-vagrant-boxes.puppetlabs.com/)

    ```
config.vm.box = "puppetlabs/centos-7.0-64-puppet"
```

* Allocates 2 vcpu and 1024 MB of RAM

   ```
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
```

* Uses the [Vagrant Shell provisionner](https://docs.vagrantup.com/v2/provisioning/shell.html) to install the required Puppet modules. [librarian-puppet](https://github.com/rodjek/librarian-puppet) was not chosen because its install took almost 1 min and we wanted the procedure to be as short as possible for live demos.

   ```
    config.vm.provision :shell do |shell|
    shell.inline = "
                  sudo puppet module install puppetlabs-stdlib;
                  sudo puppet module install puppetlabs-java;
                  sudo puppet module install puppetlabs-tomcat;
                  sudo puppet module install puppetlabs-firewall;"
  end
  ```

* Uses the [Vagrant Puppet Apply Provisioner](https://docs.vagrantup.com/v2/provisioning/puppet_apply.html)
   * Note: There are 2 different puppet manifests: 
      * `default.pp`: download jenkins.war from the internet
      * `default-jenkins.pp`: expects the Jenkins job to drop jenkins.war under `modules/petclinic/files/`
   
  
     ```
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
    puppet.options=["--verbose", "--reports http" ,"--reporturl=http://jenkins.localdomain:8090/puppet/report"]
  end
```

# Puppet notification to Jenkins

 * Ensure that the puppet-agent (the Vagrant/VirtualBox guest) has network visibility to the Jenkins server (the host):
 
   ```
  config.vm.network "private_network", type: "dhcp"   
```

 * Inject the matching hostname "jenkins.localdomain" in the `/etc/hosts` file of the linux-puppet-agent server. The IP is decided by Vagrant according to the behaviour of Vagrant `type:"dhcp"` . See `./manifest/default.pp` 
 
   ```
host { 'jenkins.localdomain':
    ip => '172.28.128.1',
}
```