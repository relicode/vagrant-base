# -*- mode: ruby -*-
# vi: set ft=ruby :

CURRENT_DIR = File.basename(Dir.getwd) # For example database.lan

HOST_MEMORY = 16 * 1024 # Total memory on host (MB)
HOST_CPUS = 2           # Total CPUs on host

MEMORY_USE_PERCENTAGE = 75
CPUS_USE_PERCENTAGE = 100

# SOCKS_PORT = "44480"

# SYNCED_DIR = {
#   HOST: ENV["HOME"] + "/projects",
#   GUEST: "/projects",
# }

# NETWORK = {
#   INTERFACE: "eno1",
#   IP: "192.168.1.1",
# }

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = CURRENT_DIR
  config.vm.provider "virtualbox" do |vb|
    vb.memory = (HOST_MEMORY * MEMORY_USE_PERCENTAGE / 100.0).to_i
    vb.cpus = (HOST_CPUS * CPUS_USE_PERCENTAGE / 100.0).to_i
  end

  if defined?(NETWORK)
  then
    config.vm.network "public_network",
      hostname: true,
      bridge: NETWORK["INTERFACE"],
      use_dhcp_assigned_default_route: true,
      ip: NETWORK["IP"]
  end

  if defined?(SYNCED_DIR) then config.vm.synced_folder SYNCED_DIR["HOST"], SYNCED_DIR["GUEST"] end
  if defined?(SOCKS_PORT) then config.ssh.extra_args = "-D", SOCKS_PORT end

  config.vm.provision "file", source: "./provision/home", destination: "/home/vagrant"
  config.vm.provision "shell", reboot: true, inline: <<-PRIVILEGED_SCRIPT
    apt-get update -y
    apt-get install -y build-essential curl git python3-pip tmux vim wget
    apt-get dist-upgrade -y
    apt-get autoremove -y
    apt-get autoclean -y
  PRIVILEGED_SCRIPT
end
