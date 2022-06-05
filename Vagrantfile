# -*- mode: ruby -*-
# vi: set ft=ruby :

def calculate_usage(host_val, usage) return usage < 1 ? (host_val * usage).to_i : usage end
def gb_to_mb(gb) return gb * 1024 end

SPLIT_DIR = File.basename(Dir.getwd).split('.')

CUSTOM = {
  # Becomes the name of the directory with dot ie. /tmp/a.b.c => b.c
  NAME: SPLIT_DIR.length > 1 ? SPLIT_DIR[-2, 2].join('.') : SPLIT_DIR[0],

  HOST: {
    CPUS: 8,                   # Physical CPUs on host
    MEMORY: gb_to_mb(16),      # Total memory on host in MB,
  },
  # Resources provisioned either as absolute amount or percentage floored i.e 0.75 = 70%
  GUEST: {
    CPUS: 1,
    MEMORY: 0.10,
  },

  # Addtionioal network interfaces for the VM in addition to the NAT
  NETWORKS: {
  #   PRIVATE: {                            # (Optional) Vagrant's host-only network
  #     NAME: 'vboxnet3'                    # (Optional) Name of the host-only interface to use
  #     IP: '192.168.56.50',                # (Optional) Static IP address to use within the network
  #     # (Optional) If set, uses the named Virtualbox internal network instead of host-only
  #     INTERNAL_NETWORK: 'mynetwork',      # true to use default 'intnet' or name of the internal network
  #   },
  #   PUBLIC: {                     # (Optional) Public bridge network
  #     INTERFACE: 'wlp9s0',        # (Optional) Host interface to use, will prompt if left out
  #     STATIC: {                   # (Optional) Static IP address and gateway, replaces DHCP
  #       IP: '192.168.5.53',
  #       GATEWAY: '192.168.5.1',
  #     },
  #   },
  },

  # OPTIONAL FEATURES

  # Set up SOCKS proxy on given port while running `vagrant ssh`
  # SOCKS_PORT: 44480,

  # Shared dir
  # SYNCED_DIR: {
    # HOST: "#{ENV['HOME']}/projects",
    # GUEST: '/projects',
  # },

  ADD_ONS: false, # Install Virtualbox Add-Ons
  UPDATES: false, # Run apt-get update etc. on install

  # Oh-my-tmux-config
  OMT: true,

  # Optixal's Neovim config
  NVIM: true,

  # The desktop environment you want to install: kubuntu, lubuntu, ubuntu, xubuntu...
  GUI: false,
}

ADD_ONS = CUSTOM[:ADD_ONS]
GUEST = CUSTOM[:GUEST]
GUI = CUSTOM[:GUI]
HOST = CUSTOM[:HOST]
NAME = CUSTOM[:NAME]
NVIM = CUSTOM[:NVIM]
OMT = CUSTOM[:OMT]
PRIVATE = CUSTOM[:NETWORKS][:PRIVATE]
PUBLIC = CUSTOM[:NETWORKS][:PUBLIC]
SOCKS_PORT = CUSTOM[:SOCKS_PORT]
SYNCED_DIR = CUSTOM[:SYNCED_DIR]
UPDATES = CUSTOM[:UPDATES]

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/jammy64'
  config.vm.hostname = NAME

  config.vm.provider 'virtualbox' do |vb|
    vb.name = NAME
    vb.memory = calculate_usage HOST[:MEMORY], GUEST[:MEMORY]
    vb.cpus = calculate_usage HOST[:CPUS], GUEST[:CPUS]
    vb.gui = GUI ? true : false
    vb.check_guest_additions = ADD_ONS ? true : false
  end

  if PRIVATE then
    config.vm.network 'private_network', {
      ip: PRIVATE[:IP],
      name: PRIVATE[:NAME],
      nic_type: 'virtio',
      type: PRIVATE[:IP] ? nil : 'dhcp',
      virtualbox__intnet: PRIVATE[:INTERNAL_NETWORK],
    }.compact
  end

  if PUBLIC then
    IP, GATEWAY = [
      PUBLIC[:STATIC] ? PUBLIC[:STATIC][:IP] : nil,
      PUBLIC[:STATIC] ? PUBLIC[:STATIC][:GATEWAY] : nil,
    ]
    config.vm.network 'public_network', {
      auto_config: (IP && GATEWAY) ? false : true,
      bridge: PUBLIC[:INTERFACE],
      hostname: (IP && GATEWAY) ? false : true,
      ip: IP,
      use_dhcp_assigned_default_route: (IP && GATEWAY) ? false : true,
    }.compact
    if (IP && GATEWAY) then
      config.vm.provision 'shell', {
        run: 'always',
        inline: "route add default gw #{GATEWAY}",
      }
    end
  end

  config.vm.provision 'file',
    source: './provision/bashrc',
    destination: "${HOME}/.bashrc"

  config.vm.provision 'shell',
    privileged: false,
    inline: 'export XDG_CACHE_HOME="${HOME}/.cache"; export XDG_CONFIG_HOME="${HOME}/.config"; export XDG_DATA_HOME="${HOME}/.local/share"; export XDG_STATE_HOME="${HOME}/.local/state"'

  if UPDATES then
    config.vm.provision 'shell',
      inline: 'apt-get update -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get autoclean -y'
  end

  if GUI then
    config.vm.provision 'shell',
      inline: "apt-get install -y #{GUI}-desktop"
  end

  if NVIM then
    config.vm.provision 'shell',
      inline: 'snap install nvim --classic'

    config.vm.provision 'file',
      source: './provision/optixal-neovim-config',
      destination: "${HOME}/etc/optixal-neovim-config"

    config.vm.provision 'shell',
      privileged: false,
      inline: 'cd  "${HOME}/etc/optixal-neovim-config" && cd convenience && ./install.sh'
  end

  if OMT then
    config.vm.provision 'file',
      source: './provision/oh-my-tmux',
      destination: "${HOME}/etc/oh-my-tmux"

    config.vm.provision 'shell',
      privileged: false,
      inline: 'cd  "${HOME}/etc/oh-my-tmux" && ln -s .tmux.conf "${HOME}" && cp ./tmux.conf.local "${HOME}"'
  end

  if SYNCED_DIR then config.vm.synced_folder SYNCED_DIR[:HOST], SYNCED_DIR[:GUEST] end
  if SOCKS_PORT then config.ssh.extra_args = '-D', String(SOCKS_PORT) end
end
