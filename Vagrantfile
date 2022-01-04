# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "archlinux/archlinux"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

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

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "1"
    vb.memory = "256"
    vb.customize ['modifyvm', :id, '--vram', '128']
    vb.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  config.vm.provision "shell", inline: "cd /vagrant && ./vagrant-init.sh", reboot: true

  config.vm.define "as_main" do |as_main|
    as_main.vm.network "private_network", virtualbox__intnet: "as_core", auto_config: false
    as_main.vm.network "public_network", auto_config: false # AS interco interface
    as_main.vm.provision "shell", inline: "cd /vagrant/machines/as_main && ./init.sh"
  end

  config.vm.define "as_user" do |as_user|
    as_user.vm.network "private_network", virtualbox__intnet: "as_core", auto_config: false
    as_user.vm.network "private_network", virtualbox__intnet: "user_access", auto_config: false
    as_user.vm.provision "shell", inline: "cd /vagrant/machines/as_user && ./init.sh"
  end
  
  config.vm.define "as_entr" do |as_entr|
    as_entr.vm.network "private_network", virtualbox__intnet: "as_core", auto_config: false
    as_entr.vm.network "private_network", virtualbox__intnet: "entr_access", auto_config: false
    as_entr.vm.provision "shell", inline: "cd /vagrant/machines/as_entr && ./init.sh"
  end

  config.vm.define "box" do |box|
    box.vm.network "private_network", virtualbox__intnet: "user_access", auto_config: false
    box.vm.network "private_network", virtualbox__intnet: "client_nat", auto_config: false
    box.vm.provision "shell", inline: "cd /vagrant/machines/box && ./init.sh"
  end

  config.vm.define "client" do |client|
    client.vm.network "private_network", virtualbox__intnet: "client_nat", auto_config: false
    client.vm.provision "shell", inline: "cd /vagrant/machines/client && ./init.sh"
  end

  config.vm.define "entr_router" do |entr_router|
    entr_router.vm.network "private_network", virtualbox__intnet: "entr_access", auto_config: false
    entr_router.vm.network "private_network", virtualbox__intnet: "entr_dmz", auto_config: false
    entr_router.vm.network "private_network", virtualbox__intnet: "entr_intra", auto_config: false
    entr_router.vm.provision "shell", inline: "cd /vagrant/machines/entr_router && ./init.sh"
  end

  config.vm.define "entr_dmz" do |entr_dmz|
    entr_dmz.vm.network "private_network", virtualbox__intnet: "entr_dmz", auto_config: false
    entr_dmz.vm.provision "shell", inline: "cd /vagrant/machines/entr_dmz && ./init.sh"
  end

  config.vm.define "entr_intra" do |entr_intra|
    entr_intra.vm.network "private_network", virtualbox__intnet: "entr_intra", auto_config: false
    entr_intra.vm.provision "shell", inline: "cd /vagrant/machines/entr_intra && ./init.sh"
  end
end
