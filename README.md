# Vagrant/VirtualBox configuration for connecting with Veikkaus VPN
Simple yet flexible Vagrant configuration for a ubuntu/focal64

#### Features
  * Automatic provisioning and scripts for installing `nvm`, `tmux` and `vim-awesome`
  * Script for connecting to Veikkaus VPN via openconnect
  * Automatic folder sharing with host system
  * Automatic SOCKS5 proxy
  * Optional static IP for the VM

#### Requirements
  * Oracle VirtualBox
  * Vagrant

## Usage
Clone the repository into a folder named <hostname>.<domain> of your choice. This will determine the hostname of the VM. Change the settings in Vagrantfile to suit your needs. The default settings should be more or less reasonable.

Start up the VM with `vagrant up` after you _can_ run the installation scripts should you need these features.

#### Configuration
Most configuration is done and is changable in Vagrantfile. For the VPN connection, credentials need to be entered in the `openconnect-pulse.sh` file on the VM.

In order to route a browser using the tunnel, an active SSH connection (`vagrant ssh` with port forwarding set ing Vagrantfile by default) to VM and the VM connected to the VPN. Afterwards you can change your browser's settings to use the SOCKS5-proxy for both web traffic and DNS requests.

Example configuration in Firefox:
![alt text1][logo]

[logo]: documentation-assets/firefox-network-settings.png "Firefox network settings"

![alt text](documentation-assets/firefox-network-settings.png "Title Text")
