# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "modionut/deb8apache"
  # fix default: stdin: is not a tty
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # config.vm.network "forwarded_port", guest: 80, host: 8081
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.network "public_network"
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
  #   vb.gui = true
      vb.memory = "2048"
  end
  # config.vm.network :private_network, ip: "192.168.56.42"
  config.vm.network "private_network", type: "dhcp"

  config.vm.provision :puppet, :options => ["--debug --trace --verbose"] do |puppet|
      puppet.manifests_path = 'puppet/manifests'
      puppet.manifest_file  = "init.pp"
      puppet.module_path = "puppet/modules"
  end

  config.vm.synced_folder "./", "/vagrant",
	id: "vagrant-root",
	owner: "vagrant",
	group: "www-data",
	mount_options: ["dmode=775,fmode=664"]

  config.vm.provision :shell, :path => "bootstrap.sh"

end
