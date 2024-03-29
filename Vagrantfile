# -*- mode: ruby -*-
# vi: set ft=ruby :

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure("2") do |config|
  # For a complete reference, the online documentation is at
  # https://docs.vagrantup.com.
  # Every Vagrant development environment requires a box. They can be search at
  # https://vagrantcloud.com/search.

  # Global______________________________________________________________________
  # If option `run: "never"` is set named provisioner can be call with
  # `vagrant up <name|id> --provision-with <provisioner-name>`
  
  # Default provider
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = "1"
    vb.memory = "1024"
  end
 
  # Disable the default synced folder
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.synced_folder "shared", "/vagrant", mount_options: ["ro"]

  config.vm.provision "docker", type: "shell", run: "never",
    path: "shared/bootstrap-docker-ubuntu.sh"

  #TODO: fix
  config.vm.provision "myconf", type: "shell", run: "never",
    path: "shared/mydefault-conf.sh", args: "vagrant root"

  #TODO: Use a personalized ssh conf `mySshConfig`?
  config.vm.provision "file", run: "once", source: "shared/ssh_config",
    destination: "/home/vagrant/.ssh/config"

  config.vm.provision "private", type: "shell", run: "never",
    path: "shared/googleDownload.sh", args: "#{ENV['ID']} #{ENV['OUT']}"

  # Default Machine (for testing)_______________________________________________
  config.vm.define "test", primary: true do |default|
    default.vm.hostname = "test"
    default.vm.box = "generic/ubuntu1804"

    # Networking
    #default.vm.network "forwarded_port", guest: 80, host: 8080
	default.vm.network "forwarded_port", guest: 80, host: 8080,
	  host_ip: "127.0.0.1"
	#default.vm.network "private_network", ip: "192.168.33.10"
	#config.vm.network "public_network"

    default.vm.provider "virtualbox" do |vb|
      vb.name = "test"
    end

    default.vm.provision "staticHosts", type: "shell", run: "once",
      inline: "#"

    default.vm.provision "shell", run: "once", inline: <<-SHELL
      apt-get update -y
      apt-get install -y man man-db git
    SHELL
  end

  # Expore Linux Distros________________________________________________________
  # TODO: https://www.vagrantup.com/docs/networking/public_network
  # Update Networking

  NBR_DISTROS=3

  DISTRO1="ubuntu";				IP1="192.168.42.10"
  VM_NAME1="ubuntu";			HOSTNAME1="ubuntu";
  IMAGE1="generic/ubuntu1804";	PROVIDER1="virtualbox"
  BOOTSTRAP_FILE1="shared/bootstrap-ubuntu.sh"

  DISTRO2="centos";				IP2="192.168.42.11"
  VM_NAME2="centos";			HOSTNAME2="centos";
  IMAGE2="centos/7";			PROVIDER2="virtualbox" 
  BOOTSTRAP_FILE2="shared/bootstrap-centos.sh"

  DISTRO3="opensuse";			IP3="192.168.42.12"
  VM_NAME3="opensuse";			HOSTNAME3="opensuse";
  IMAGE3="generic/opensuse42";	PROVIDER3="virtualbox"
  BOOTSTRAP_FILE3="shared/bootstrap-opensuse.sh"
 
  # TODO: Use
  $script = <<-'SCRIPT'
    echo #{IP1} #{HOSTNAME1} >> /etc/hosts
    echo #{IP2} #{HOSTNAME2} >> /etc/hosts
    echo #{IP3} #{HOSTNAME3} >> /etc/hosts
  SCRIPT


  # TODO:  Use a loop if possible
  # Distro 1: Ubuntu............................................................
  config.vm.define "#{VM_NAME1}", autostart: false do |distro|
    distro.vm.hostname = "#{HOSTNAME1}"
    distro.vm.box = "#{IMAGE1}"
    distro.vm.network "private_network", ip: "#{IP1}", auto_config: false

    distro.vm.provider "#{PROVIDER1}" do |vb|
      vb.name = "#{VM_NAME1}"
    end

    distro.vm.provision "staticHosts", type: "shell", inline: <<-SHELL
      echo #{IP1} #{HOSTNAME1} >> /etc/hosts
      echo #{IP2} #{HOSTNAME2} >> /etc/hosts
      echo #{IP3} #{HOSTNAME3} >> /etc/hosts
    SHELL

    distro.vm.provision "shell", run: "once", path: "#{BOOTSTRAP_FILE1}"
  end

  # Distro 2: CentOs............................................................
  config.vm.define "#{VM_NAME2}", autostart: false do |distro|
    distro.vm.hostname = "#{HOSTNAME2}"
    distro.vm.box = "#{IMAGE2}"
    distro.vm.network "private_network", ip: "#{IP2}", auto_config: false

    distro.vm.provider "#{PROVIDER2}" do |vb|
      vb.name = "#{VM_NAME2}"
    end

    distro.vm.provision "staticHosts", type: "shell", inline: <<-SHELL
      echo #{IP1} #{HOSTNAME1} >> /etc/hosts
      echo #{IP2} #{HOSTNAME2} >> /etc/hosts
      echo #{IP3} #{HOSTNAME3} >> /etc/hosts
    SHELL

    distro.vm.provision "shell", run: "once", path: "#{BOOTSTRAP_FILE2}"
  end

  # Distro 3: OpenSuse..........................................................
  config.vm.define "#{VM_NAME3}", autostart: false do |distro|
    distro.vm.hostname = "#{HOSTNAME3}"
    distro.vm.box = "#{IMAGE3}"
    distro.vm.network "private_network", ip: "#{IP3}", auto_config: false

    distro.vm.provider "#{PROVIDER3}" do |vb|
      vb.name = "#{VM_NAME3}"
    end

    distro.vm.provision "staticHosts", type: "shell", inline: <<-SHELL
      echo #{IP1} #{HOSTNAME1} >> /etc/hosts
      echo #{IP2} #{HOSTNAME2} >> /etc/hosts
      echo #{IP3} #{HOSTNAME3} >> /etc/hosts
    SHELL

    distro.vm.provision "shell", run: "once", path: "#{BOOTSTRAP_FILE3}"
  end

  # Docker Practices____________________________________________________________
  config.vm.define "docker", autostart: false do |docker|
    docker.vm.hostname = "docker"
    docker.vm.box = "generic/ubuntu1804"
    docker.vm.network "public_network", ip: "192.168.0.242"
    # Port for Jenkins
    #docker.vm.network "forwarded_port", guest: 8080, host: 8080
    #docker.vm.network "forwarded_port", guest: 50000, host: 50000

    docker.vm.provider "virtualbox" do |vb|
      vb.name = "docker"
      vb.gui = false
      vb.cpus = "3"
      vb.memory = "2048"
    end

    docker.vm.provision "staticHosts", type: "shell", run: "once", inline: "#"

	docker.vm.provision "shell", run: "once",
      path: "shared/bootstrap-docker-ubuntu.sh"
  end

  # GKE_________________________________________________________________________
  # TODO: Test and Update
  # Ubuntu for gke Virtual Machine
  #config.vm.define "gke", autostart: false do |gvm|
    #gvm.vm.hostname = "gke"
    #gvm.vm.box = "generic/ubuntu1804"
    #gvm.vm.network "private_network", ip: "172.16.24.20"
    #gvm.vm.synced_folder "shared", "/vagrant_data",type:"virtualbox"
    #gvm.vm.boot_timeout = 500

    #gvm.vm.provider "virtualbox" do |vb|
      #vb.name = "gke"
      #vb.gui = false
      #vb.cpus = "1"
      #vb.memory = "1024"
    #end
    
    #gvm.vm.provision "staticHosts", type: "shell", run: "once", inline: "#"

    #gvm.vm.provision "shell", run: "once", path: "shared/bootstrap-gke.sh"
  #end

# Minikube______________________________________________________________________
  config.vm.define "minikube", autostart: false do |mk|
    mk.vm.hostname = "minikube"
    mk.vm.box = "generic/ubuntu1804"
    mk.vm.network "private_network", ip: "172.16.42.8"
	mk.vm.boot_timeout = 500

    mk.vm.provider "virtualbox" do |vb|
      vb.name = "minikube"
      vb.gui = false
      vb.cpus = "4"
      vb.memory = "4096"
    end

    K8S_VERSION_MK="1.22.4-00"

    mk.vm.provision "staticHosts", type: "shell", run: "once", inline: "#"

    mk.vm.provision "shell", run: "once",
      path: "shared/bootstrap-docker-ubuntu.sh"

    mk.vm.provision  "shell", run: "once",
      path: "shared/k8s/bootstrap-k8s-tools.sh", args: "#{K8S_VERSION_MK} kubectl"

    mk.vm.provision "shell", run: "once",
      path: "shared/bootstrap-minikube-node.sh"
  end

# Minnaker
  config.vm.define "minnaker", autostart: false do |minnik|
    minnik.vm.hostname = "minnaker"
    minnik.vm.box = "generic/ubuntu1804"
    minnik.vm.network "public_network", ip: "192.168.0.90"
	minnik.vm.boot_timeout = 500

    minnik.vm.provider "virtualbox" do |vb|
      vb.name = "minnaker"
      vb.gui = false
      vb.cpus = "4"
      vb.memory = "10240"
    end

    minnik.vm.provision "staticHosts", type: "shell", run: "once", inline: "#"

#    minnik.vm.provision "shell", run: "once",
#      path: "shared/bootstrap-minnaker-node.sh", args: "192.168.0.90"

  end
 
# HA K8S Cluster________________________________________________________________
  #TODO Deploy a Load Balancer for HA Cluster

  CALICO_VERSION	= "v3.21"
  K8S_VERSION		= "1.22.4-00"
  # https://docs.projectcalico.org/getting-started/kubernetes/requirements
  CIDR				= "192.168.0.0/16"

  # Check each IP address availability before use, e.g.: `nmap 192.168.100/32`
  MastersIP			= "192.168.0"
  MinMaster			= 100;				MaxMaster = 100

  WorkersIP			= "192.168.0"
  MinWorker			= 110;				MaxWorker = 112

  config.vm.provision "staticHosts", type: "shell", run: "once",
    inline: <<-SHELL
    i=#{MinMaster}
    while [[ "$i" -le "#{MaxMaster}" ]] ; do
      echo #{MastersIP}.$i master$i >> /etc/hosts
      echo -e "\nhost\tmaster$i" >> /home/vagrant/.ssh/config
      echo -e "hostname\t#{MastersIP}.$i" >> /home/vagrant/.ssh/config
      i=$(($i+1))
    done

    i=#{MinWorker}
    while [[ "$i" -le "#{MaxWorker}" ]] ; do
      echo #{WorkersIP}.$i worker$i >> /etc/hosts
      echo -e "\nhost\t\tworker$i" >> /home/vagrant/.ssh/config
      echo -e "hostname\t#{WorkersIP}.$i" >> /home/vagrant/.ssh/config
      i=$(($i+1))
    done
	mkdir /root/.ssh
	cp /home/vagrant/.ssh/config /root/.ssh/config
  SHELL

  config.vm.provision "generateJoinCommand", type: "shell", run: "never",
    path: "shared/k8s/bootstrap-k8s-join-token.sh"

  config.vm.provision "joinMasterNode", type: "shell", run: "never",
    path: "shared/k8s/bootstrap-k8s-join-master.sh", env: {MASTER:ENV['MASTER']}

  config.vm.provision "helm", type: "shell", run: "never",
    path: "shared/k8s/bootstrap-k8s-helm.sh"

  config.vm.provision "metalLB", type: "shell", run: "never",
    path: "shared/k8s/bootstrap-k8s-metalLB.sh", env: {IP:ENV['IP']}

  config.vm.provision "nfsStorage", type: "shell", run: "never",
    path: "shared/k8s/bootstrap-k8s-storage-class.sh", env: {NFS:ENV['NFS']}

  config.vm.provision "octant", type: "shell", run: "never",
    path: "shared/k8s/bootstrap-k8s-octant.sh"

#  config.vm.provision "jenkinsX", type: "shell", run: "never",
#    path: "shared/k8s/bootstrap-k8s-jenkinsx.sh"

  # Master Node(s)..............................................................
  (MinMaster..MaxMaster).each do |i|
    config.vm.define "master#{i}", autostart: false do |masteri|
      masteri.vm.hostname = "master#{i}"
      masteri.vm.box = "generic/ubuntu1804"
      masteri.vm.box_version = "3.6.4"
      masteri.vm.box_check_update = false
      masteri.vm.network "public_network", ip: "#{MastersIP}.#{i}"

      masteri.vm.provider "virtualbox" do |vb|
        vb.name = "master#{i}"
        vb.gui = false
        vb.cpus = "3"
        vb.memory = "3072"
      end

      masteri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-packages.sh"
      masteri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-swap-firewall.sh"
      masteri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-iptables.sh"
      masteri.vm.provision "shell", run: "once",
        path: "shared/bootstrap-docker-ubuntu.sh"
      masteri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-cri.sh"
      masteri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-kube-tools.sh",
        args: "#{K8S_VERSION} kubelet kubeadm kubectl"
      masteri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-init.sh",
        args: "#{MastersIP}.#{i} #{K8S_VERSION} #{CIDR}"
      masteri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-cni.sh", args: "#{CALICO_VERSION}"
    end
  end

  # Workers Node(s).............................................................
  (MinWorker..MaxWorker).each do |i|
    config.vm.define "worker#{i}", autostart: false do |workeri|
      workeri.vm.hostname = "worker#{i}"
      workeri.vm.box = "generic/ubuntu1804"
      workeri.vm.box_version = "3.6.4"
      workeri.vm.box_check_update = false
      workeri.vm.network "public_network", ip: "#{WorkersIP}.#{i}"

      workeri.vm.provider "virtualbox" do |vb|
        vb.name = "worker#{i}"
        vb.gui = false
        vb.cpus = "1"
        vb.memory = "2048"
      end

      workeri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-packages.sh"
      workeri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-swap-firewall.sh"
      workeri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-iptables.sh"
      workeri.vm.provision "shell", run: "once",
        path: "shared/bootstrap-docker-ubuntu.sh"
      workeri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-cri.sh"
      workeri.vm.provision "shell", run: "once",
        path: "shared/k8s/bootstrap-k8s-kube-tools.sh",
        args: "#{K8S_VERSION} kubelet kubeadm kubectl"
    end
  end

end

# Clean up:
#	Remove virtual Box interface `vboxnetX`:
#		$ VBoxManage hostonlyif remove vboxnetX

# Reference(s):
#https://www.vagrantup.com/docs
