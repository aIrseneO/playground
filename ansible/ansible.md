```bash
sudo yum install ansible

sudo yum install epel-release
sudo yum install python-pip
sudo pip install ansible
sudo pip install --upgrade ansible

sudo pip install ansible==2.4

```

```bash
ansible-playbook -i inventory playbook.yml -K
ansible-config list
ansible-config view
ansible-config dump
```

```bash
ansible -m ping host/all
ansible -a "<command>" host/all
```

```yaml
---
# - name: Print hello message
#   hosts: machines
#   gather_facts: no
#   tasks:
#   - debug:
#       # msg: Hello from Ansible!
#       var: ansible_facts

- name: Test
  hosts: machine1
  tasks:
  - shell: cat /etc/hosts
    register: result 
  - debug:
      var: result.stdout

# - name: Install packages
#   become: yes
#   hosts: machines
#   tasks:
#   - apt:
#       name: terminator
#       state: latest
#   - package:
#       name: git
#       state: installed

# - name: Start services
#   hosts: machines
#   tasks:
#   - services:
#       name: ssh
#       state: started
#       enabled: yes

# - name: Add Firewalld rule
#   hosts: machines
#   tasks:
#   - firewalld:
#       port: 22/tcp
#       service: ssh
#       source: 0.0.0.0
#       zone: public
#       state: enabled
#       permanent: yes
#       immediate: yes
```