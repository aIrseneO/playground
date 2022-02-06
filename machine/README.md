## Machines: [ ubuntu | centos | opensuse | ... ]
> ### Ubuntu Context:
* #### Set Context:
  ```bash
  eval `./machine/ubuntu.sh`
  # or
  source <(./machine/ubuntu.sh)
	```
* #### Use it:
  ```bash
  vagrant up ubuntu

  _PATH=shared/mydefault-conf.sh _ARGS="vagrant root" \
	vagrant provision ubuntu --provision-with script
  ```
* #### Clear Context:
  ```bash
  eval `./machine/none.sh`
  # or
  source <(./machine/none.sh)
  ```