# DNS Terraform OTC Example

This script will create the following resources:
* DNS Zone
* DNS Record Set
* Volumes
* Floating IPs
* Neutron Ports
* Instances
* Keypair
* Network
* Subnet
* Router
* Router Interface
* Security Group (Allow ICMP, 80/tcp, 22/tcp)

## Available Variables

### Required

* username (your OTC username)
* password (your OTC password)
* domain\_name (your OTC domain name)
* dnszone (name of the dns zone to create)_

### Optional
* project (this will prefix all your resources, _default=terraform_)
* ssh\_pub\_key (the path to the ssh public key you want to deploy, _default=~/.ssh/id\_rsa.pub_)
* instance\_count (affects the number of Floating IPs, Instances, Volumes and Ports, _default=1_)
* flavor\_name (flavor of the created instances, _default=s1.medium_)
* image\_name (image used for creating instances, _default=Standard\_CentOS\_7\_latest_)
* dnsname (name of the dns record set, _default=webserver_)
* disk\_size\_gb (size of the volumes in gigabytes, _default=10_)
