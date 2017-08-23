# Terraform examples for Open Telekom Cloud

## Compatibility List

| Terraform Resource | Status      |
| ------------------ | ----------- |
| Data Sources       | Partial     |
| Block Storage      | Working     |
| Compute            | Working     |
| DNS                | Working     |
| Images             | Working     |
| Networking         | Working     |
| Load Balancer      | Not working |
| Firewall           | Not working |

## Description

There are different examples of terraform scripts, each with a different purpose:

**minimal** 

A minimal Terraform example with just the components to get a virtual machine running and connect to it with a public ip.

**dns**

A bit more complex example, inlcuding handling of DNS and additional storage volumes

**objectstorage**

An example on how to use the object storage that is included in OTC.

**full**

A complete example, showing the full power of terraform. Components can be enabled and disabled via configuration file.

## Quick Start

1. Install [Terraform](https://www.terraform.io)
2. Clone this repository via `git clone https://github.com/OpenTelekomCloud/terraform-otc.git`
3. Switch to terraform directory `cd terraform-otc/minimal`
4. Initialize Terraform provider via `terraform init`
5. Insert your login information into `parameter.tvars`
6. Check if everything looks good with `terraform plan -var-file=parameter.tvars`
7. Apply the changes via `terraform apply -var-file=parameter.tvars`

## Authentication



## Known Issues

### Loadbalancing

### FloatingIP Association

### Network Datasource
