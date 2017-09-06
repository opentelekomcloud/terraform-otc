# Minimal Terraform OTC Example

This script will create the following resources:
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

* username
* password
* domain\_name

### Optional
* instance\_count (affects the number of Floating IPs, Instances and Ports, _default=1_)
* flavor\_name (flavor of the created instances, _default=s1.medium_)
* image\_name (image used for creating instances, _default=Standard\_CentOS\_7\_latest_)
