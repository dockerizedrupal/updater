VERSION = "0.1.1"

require 'yaml'

required_plugins = %w(vagrant-vbguest)

required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

MEMORY_SIZE = 512

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.hostname = "updater"

  config.vm.provider "virtualbox" do |v|
    name = "dockerizedrupal-updater-" + VERSION

    name.gsub!(".", "-")

    v.name = name
    v.memory = MEMORY_SIZE
  end

  config.vm.provision "shell", inline: "initctl emit vagrant-ready", run: "always"

  config.vm.provision "shell" do |s|
    s.inline = <<-SHELL
      MEMORY_SIZE="${1}"

      swap_create() {
        local memory_size="${1}"
        local swap_size=$((${memory_size}*2))

        swapoff -a

        fallocate -l "${swap_size}m" /swapfile

        chmod 600 /swapfile

        mkswap /swapfile
        swapon /swapfile

        echo "/swapfile none swap sw 0 0" >> /etc/fstab

        sysctl vm.swappiness=10
        echo "vm.swappiness=10" >> /etc/sysctl.conf

        sysctl vm.vfs_cache_pressure=50
        echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
      }

      swap_create "${MEMORY_SIZE}"
    SHELL

    s.args = [
      MEMORY_SIZE,
    ]
  end
end
