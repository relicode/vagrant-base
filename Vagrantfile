# -*- mode: ruby -*-
# vi: set ft=ruby :

CURRENT_DIR = File.basename(Dir.getwd)  # For example database.lan
MEMORY = 16 * 1024                      # Host memory
CPUS = 2                                # Host CPUs

MEMORY_USE_PERCENTAGE = 75
CPU_USE_PERCENTAGE = 100

# Floor the result
MEMORY_TO_USE = (MEMORY * MEMORY_USE_PERCENTAGE / 100.0).to_i
CPUS_TO_USE = (CPUS * CPU_USE_PERCENTAGE / 100.0).to_i

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = CURRENT_DIR
  config.vm.provider "virtualbox" do |v|
    v.memory = MEMORY_TO_USE
    v.cpus = CPUS_TO_USE
  end

  # config.vm.network "public_network",
    # hostname: true,
    # bridge: "eno1",
    # use_dhcp_assigned_default_route: true,
    # ip: "192.168.1.1"

  config.vm.provision "file", source: "./provision/home", destination: "/home/vagrant"
  config.vm.provision "shell", reboot: true, inline: <<-PRIVILEGED_SCRIPT
    apt-get update -y
    apt-get install -y build-essential curl git inetutils-tools python3-pip tmux vim wget
    apt-get dist-upgrade -y
    apt-get autoremove -y
    apt-get autoclean -y
  PRIVILEGED_SCRIPT
end
