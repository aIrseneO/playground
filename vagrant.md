# Vagrant

## Everyday use commands:
```bash
vagrant init # initializes a new Vagrant environment by creating a Vagrantfile
```
### Manage boxes (images)
```bash
vagrant box list # List all boxes on the system
vagrant box add <name, url, or path> # Add a box to the system
vagrant box remove <name> # Remove a box from the system
```

### Instance of a box:
```bash
vagrant up [vm-name] # Spin up an instance of the box
vagrant halt [vm-name] # Shut down the instance/VM peacefully
vagrant destroy [vm-name] # Destroy the instance/VM of the box
vagrant [suspend | resume | reload] [vm-name] # Self explanatory
```

NOTE: 
- ```vm-name``` is defined in the Vagrantfile.
- if no ```vm-name``` is supplied the above commands will be applied to all \
	configured VMs which don't have the `autostart` set to `false`.

### Provision a running VM
```bash
vagrant provision <vm-name> --provision-with <provision Names>
vagrant provision --help
```

### Check Boxes
```bash
vagrant box list
vagrant box --help # For more
```

### Others:
```bash
vagrant status # Check the status of all instances
vagrant ssh <vm-name> # ssh into a VM instance

vagrant [command] --help # Check other commands of vagrant
```

## Vagrant Boxes: [here](https://app.vagrantup.com/boxes/search)
## Vagrant Documentation: [here](https://www.vagrantup.com/docs/index)
