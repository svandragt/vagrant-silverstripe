# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.synced_folder "./", "/vagrant", owner: "www-data", group: "www-data"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.network "private_network", type: "dhcp"
  config.vm.host_name = "silverstripe.dev"

   config.vm.provider "virtualbox" do |vb|
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  end

  config.vm.provision :shell, :path => "vagrant/provision.sh"
end
