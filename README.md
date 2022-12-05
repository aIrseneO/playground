# Playgrounds
## Master node:
```bash
bash myvagrant.sh nodes/master.yml up master
```

## Worker node
```bash
bash myvagrant.sh nodes/worker1.yml up worker1
```

## Join
Manually, from the master node get join command by running:
```bash
kubeadm token create --print-join-command
```
then run it in the  worker node.

## Destroy/Clean up

```bash
bash myvagrant.sh nodes/worker1.yml destroy -f
bash myvagrant.sh nodes/master.yml destroy -f
```