# Vagrant/VirtualBox configuration with openconnect
Simple yet flexible Vagrant configuration based on a ubuntu/focal64 base box. Ideally used for accessing a Pulse VPN and sharing content and proxying HTTP traffic for the host.

#### Features
  * Automatic provisioning and scripts for installing `nvm`, `tmux` and `neovim`
  * Script for connecting to VPN via pulse protocol
  * Automatic folder sharing with host system
  * Automatic SOCKS5 proxy
  * Optional static IP for the VM

#### Requirements
  * Oracle VirtualBox (with compatible Guest Additions for some features)
  * Vagrant

## Usage
  1. Clone the repository and its submodules into a folder named \<hostname>.\<domain> of your choice (`git clone --recurse-submodules https://github.com/relicode/vagrant-base.git mydomain.lan && cd mydomain.lan && git submodule update --init --recursive`). This will determine the hostname of the VM. If needed, change the `CUSTOM.NAME` property in Vagrantfile.
  2. Edit the configuration in Vagrantfile `CUSTOM` hash.
  3. Start up the VM with `vagrant up`.

#### Configuration
In order to route a browser using the tunnel, an active SSH connection (`vagrant ssh` with port forwarding set in Vagrantfile) to VM and the VM connected to a VPN. Afterwards you can change your browser's settings to use the **SOCKS5-proxy** with **port** set in Vagrantfile for both web traffic and **DNS** requests.

Example configuration for Firefox:
![alt text1][logo]

[logo]: documentation-assets/firefox-network-settings.png "Firefox network settings"
