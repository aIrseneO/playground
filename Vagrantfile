# -*- mode: ruby -*-
# vi: set ft=ruby :

################################################################################
#     Copyright (c) 2022 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

ENV['VAGRANT_BOX_UPDATE_CHECK_DISABLE']		= 'yes'
ENV['VAGRANT_CHECKPOINT_DISABLE']			= 'yes'
ENV['VAGRANT_DISABLE_VBOXSYMLINKCREATE']	= 'yes'
ENV['VAGRANT_NO_PARALLEL']					= 'yes'

PATH = ENV["_PATH"] || "void.sh"
ARGS = ENV["_ARGS"] || ""

Vagrant.configure("2") do |config|
  # For a complete reference, the online documentation is at
  # https://docs.vagrantup.com.

  # Enable provisioning with a shell script.
  config.vm.provision "script", type: "shell", run: "never",
    path: "#{PATH}", args: "#{ARGS}"

  config.vm.define "#{ENV['NAME']}", autostart: false do |node|

    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    node.vm.box = "#{ENV['IMAGE']}"
    node.vm.box_version = "#{ENV['TAG']}"

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    node.vm.box_check_update = false

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    if ENV['NETWORK'] == 'public'
      node.vm.network "public_network", ip: "#{ENV['IP']}"
    end

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    if ENV['NETWORK'] == 'private'
      node.vm.network "private_network", ip: "#{ENV['IP']}"
    end

    # Set the hostname.
    node.vm.hostname = "#{ENV['HOSTNAME']}"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    #
    # For VirtualBox:
    if ENV['PROVIDER'] == 'virtualbox'
      node.vm.provider "#{ENV['PROVIDER']}" do |vb|
        vb.gui = false
        vb.cpus = "#{ENV['CPU']}"
        vb.memory = "#{ENV['MEMORY']}"
        vb.name = "#{ENV['NAME']}"
      end
    end
  end
end

# Clean up private network on host:
#	Remove virtual Box interface `vboxnetX`:
#		$ VBoxManage hostonlyif remove vboxnetX

# Reference(s):
#https://www.vagrantup.com/docs
