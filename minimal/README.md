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

