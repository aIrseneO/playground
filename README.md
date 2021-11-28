# devop
Common DevOps Tools Configurations

## Kubernetes playground
### How to use it:
Spin up two nodes, the master (should always be first) and one worker:
```bash
$ vagrant up master
$ vagrant up worker101
```
To have a node join the master node run:
```bash
$ vagrant provision master --provision-with generateJoinCommand
$ vagrant provision <nodeName> --provision-with joinMasterNode
```