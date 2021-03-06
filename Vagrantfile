# -*- mode: ruby -*-
# vi: set ft=ruby :

CURRENT_DIR = File.basename(Dir.getwd) # For example database.lan

HOST_MEMORY = 8 * 1024  # Total memory on host in MB (default 8 GB)
HOST_CPUS = 2           # Total CPUs on host

MEMORY_USE_PERCENTAGE = 75 # Percentage of host's memory provisioned for the VM
CPUS_USE_PERCENTAGE = 100  # Percentage of host's CPUs provisioned for the VM

SOCKS_PORT = "44480"     # If uncommented, allows automatic bridge forming on 'vagrant ssh'

# Optional synced folder between the host and the guest
# SYNCED_DIR = {
#   HOST: ENV["HOME"] + "/projects",
#   GUEST: "/projects",
# }

# Optional static IP address for the VM
# NETWORK = {
#   INTERFACE: "eno1",
#   IP: "192.168.1.1",
# }

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = CURRENT_DIR
  config.vm.provider "virtualbox" do |vb|
    vb.name = CURRENT_DIR
    vb.memory = (HOST_MEMORY * 100.0 / MEMORY_USE_PERCENTAGE).to_i
    vb.cpus = (HOST_CPUS * 100.0 / CPUS_USE_PERCENTAGE).to_i
  end

  unless (defined?(NETWORK)).nil?
  then
    config.vm.network "public_network",
      hostname: true,
      bridge: NETWORK[:INTERFACE],
      use_dhcp_assigned_default_route: true,
      ip: NETWORK[:IP]
  end

  unless (defined?(SYNCED_DIR)).nil? then config.vm.synced_folder SYNCED_DIR[:HOST], SYNCED_DIR[:GUEST] end
  unless (defined?(SOCKS_PORT)).nil? then config.ssh.extra_args = "-D", SOCKS_PORT end

  config.vm.provision "file", source: "./provision/home", destination: "/home/vagrant"
  config.vm.provision "shell", reboot: true, inline: <<-PRIVILEGED_SCRIPT
    apt-get update -y
    apt-get install -y build-essential curl git python3-pip tmux vim wget openconnect
    apt-get dist-upgrade -y
    apt-get autoremove -y
    apt-get autoclean -y
  PRIVILEGED_SCRIPT
end
