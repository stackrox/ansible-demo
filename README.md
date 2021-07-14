# Install Red Hat Advanced Cluster Security for Kubernetes on OpenShift/CRC - Red Hat CodeReady Containers
Deploy Red Hat Advanced Cluster Security for Kubernetes Demo ( Apps and Pipelines ) on OpenShift 4.x or CRC in a easy and automated way.

## PREREQUISITES

- OpenShift Cluster or CRC - Red Hat CodeReady Containers 

#### Minimum Requirements to run the demo workload on top of CRC: [Configuring the virtual machine](https://code-ready.github.io/crc/#configuring-the-virtual-machine_gsg)

- Minimum 4 vCPU (additional are strongly recommended).
- Minimum 16 GB RAM (additional memory is strongly recommended).

### Ansible 2.9
- [Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 
- python3-pyyaml
- python3-openshift
- python3-jmespath


### Define crc variable to deploy RHACS on CRC

| Variable | Bool |
| -------- | -------- | 
| crc    |  true or false     |

### Steps

#### Configuring the CRC Virtual Machine
---
```
crc config set cpus 4
crc config set memory 16384
```

#### Installing RHACS and Demo workloads - RHEL/Centos
---

Install EPEL on CentOS
```
yum install epel-release -y
```

```
yum install python3-pyyaml python3-jmespath python3-openshift ansible -y
ansible-galaxy collection install kubernetes.core
git clone https://github.com/stackrox/ansible-demo
cd ansible-demo/playbooks
```

You can use the **rhacs-install.yaml** as example, please change the credentials before running the playbook.

rhacs-install.yaml file Example
---
```
- hosts: localhost
  vars:
    crc: true
  roles:
  - stackrox_central
  - stackrox_sensor
  - stackrox_demo_apps
  - stackrox_demo_pipeline
```

Login to crc/ocp using a Cluster-Admin user.
---
```
oc login -u kubeadmin https://api.crc.testing:6443 
```

Running the playbook.
---
```
ansible-playbook rhacs-install.yaml
```

It might take a bit of time, so grab a coffee and enjoy :)
