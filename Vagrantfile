# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'puppetlabs/centos-7.2-64-nocm'
  # config.vm.box = 'rhel6-nitc-40g'
  # config.vm.provision :hosts, sync_hosts: true

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

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
  config.vm.provider 'parallels' do |prl|
    prl.memory = 512
    prl.cpus = 1
  end

  config.vm.provider 'vmware_fusion' do |vmw|
    vmw.vmx['memsize'] = 512
  end

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = 512
  end

  # config.vm.provider 'vmware_fusion' do |v|
  #   # Customize the amount of memory on the VM:
  #   v.vmx['memsize'] = 1024
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  install_puppet_script = <<SCRIPT
yum -y localinstall http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet
/opt/puppetlabs/bin/puppet module install puppetlabs-firewall
SCRIPT

  config.vm.provision :shell,
                      inline: install_puppet_script

  config.vm.define :consul0 do |consul0|
    consul0.vm.network 'private_network', ip: '10.20.1.4'

    # Provision the database
    install_consul0 = <<SCRIPT
/opt/puppetlabs/bin/puppet module install KyleAnderson/consul
/opt/puppetlabs/bin/puppet apply /vagrant/manifests/consul0.pp --modulepath=/etc/puppetlabs/code/environments/production/modules
SCRIPT

    consul0.vm.provision :shell,
                         inline: install_consul0
  end

  config.vm.define :consul1 do |consul1|
    consul1.vm.network 'private_network', ip: '10.20.1.5'

    # Provision the database
    install_consul1 = <<SCRIPT
/opt/puppetlabs/bin/puppet module install KyleAnderson/consul
/opt/puppetlabs/bin/puppet apply /vagrant/manifests/consul1.pp --modulepath=/etc/puppetlabs/code/environments/production/modules
SCRIPT

    consul0.vm.provision :shell,
                         inline: install_consul1
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
