# Introduction
This is a vagrant box which runs on `Ubuntu Xenial LTS`. The box will also install the follwing packages:
- Nginx - lastest version
- PHP 7.2
- Node.js 9 and NPM 5
- Composer - latest version

The machine will also stop and remove `Apache` as a part of installation.



# Installation
Before running any of following commands, make sure `Vagrant` is installed in your machine. For more information and install Vagrant go to the [Vagrant offical website](https://www.vagrantup.com/).

Because it is a vagrant box, you can run the machine with this command:
```
vagrant up
```

When the installation finished, you can view the local webserver in your favourite browser in `http://localhost:8080` address.

# Other
## Private network IP
Following line make the current machine accessible from current network:
```
config.vm.network "private_network", ip: "192.168.13.2"
```

## Virtual box guest addition
In order to prevent virtual box guest addition to update the machin(s) automatically, add this line in the `Vagrantfile`:
```
config.vbguest.auto_update = false
```
But first you need to check if `vagrant-vbguest` has installed. You can check it by running this command:
```
vagrant plugin list
```

## Two machines
In order to have two boxes in one `Vagrantfile` you should fallow the following pattern.
```
Vagrant.configure("2") do |config|
    # These 2  lines will effect on both machines
    config.vm.box = "ubuntu/xenial64"
    config.vm.provision :shell, path: "./scripts/common.sh"

    config.vm.define "db" do |db|
        db.vm.provision :shell, path: "./scripts/db.sh"
        db.vm.hostname = "database-server"
        db.vm.network "private_network", ip: "192.168.13.2"
    end

    config.vm.define "web" do |web|
        web.vm.provision :shell, path: "./scripts/web.sh"
        web.vm.hostname = "web-server"
        web.vm.network "forwarded_port", guest: 80, host: 8080
        web.vm.network "private_network", ip: "192.168.13.3"
    end
end
```