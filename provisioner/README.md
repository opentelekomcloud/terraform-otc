# Minimal Terraform OTC Example

This script will create the following resources:
* Floating IPs
* Instances
* Keypair
* Network
* Subnet
* Router
* Router Interface
* Security Group (Allow ICMP, 80/tcp, 22/tcp)

## SSH Connection

This example is using _provisioner_ to deploy files on the created virtual machines. This is done via ssh connections, so be sure that you can reach the public IPs on port 22 from the system you run terraform on. The example is prepared to use ssh public key authentication via a running ssh agent that has the corresponding private key loaded. If you don't use ssh agent, want to provide a specific ssh key or want to use password based authentication (which is strongly discouraged) you have to edit the _connection_ section of the _null\_resource_ inside of the `instances.tf` file.

## Available Variables

### Required

* **username** (your OTC username)
* **password** (your OTC password)
* **domain\_name** (your OTC domain name)

### Optional
* **project** (this will prefix all your resources, _default=terraform_)
* **ssh\_pub\_key** (the path to the ssh public key you want to deploy, _default=~/.ssh/id\_rsa.pub_)
* **instance\_count** (affects the number of Floating IPs, Instances, Volumes and Ports, _default=1_)
* **flavor\_name** (flavor of the created instances, _default=s1.medium_)
* **image\_name** (image used for creating instances, _default=Standard\_CentOS\_7\_latest_)

