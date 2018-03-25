# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.provision :file,
    source: "./files/provisionFile.txt",
    destination: "~/provisionFile.tx"

  config.vm.provision :shell, path: "./scripts/bootstrap.sh"

  config.vm.provider :virtualbox do |vb|
    vb.name = "Ubuntu-Xenial-PHP-Essential"
  end

  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Prevent Virtual box guest addition for auto update
  # check if the plugin has already installed
  # vagrant plugin list
  #config.vbguest.auto_update = false

end
