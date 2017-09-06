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
| Load Balancer      | Partial     |
| Firewall           | Not working |

## Description

There are different examples of terraform scripts, each with a different purpose:

**minimal** 

A minimal Terraform example with just the components to get a virtual machine running and connect to it with a public ip. If you are new to Terraform, this is the recommended example to start with.

**dns**

A bit more complex example, inlcuding handling of DNS and additional storage volumes. If you already worked with Terraform or you got the minimal example running and want to explore more, try this example.

**objectstorage**

An example on how to use the object storage that is included in OTC by utilizing the AWS provider.

**provisioner**

This based on the minimal example, showing the usage of Terraforms provisioner to execute commands and deploy files on the created instances.

An example on how to use the object storage that is included in OTC by utilizing the AWS provider.
**full**

A complete example, showing the full power of terraform. Components can be enabled and disabled via configuration file. This can be used as a template for production grade Terraform scripts.

## Quick Start

1. Install [Terraform](https://www.terraform.io)
2. Clone this repository via `git clone https://github.com/OpenTelekomCloud/terraform-otc.git`
3. Switch to terraform directory `cd terraform-otc/minimal`
4. Initialize Terraform provider via `terraform init`
5. Insert your login information into `parameter.tvars`
6. Check if everything looks good with `terraform plan -var-file=parameter.tvars`
7. Apply the changes via `terraform apply -var-file=parameter.tvars`

## Customization

All variables that can be changed are documented in the file `variables.tf`. There are also some reasonable default values for most of the variables set in this file. Every variable von be overwritten by passing command line arguments to the Terraform invocation, or simply by passing a parameter file via the `-var-file` command line parameter. All the examples provide an file called `parameters.tvars` where you find the parameters that you need to set for the example to work (for example your login information). You cann add more parameters for any variable existing in the `variables.tf` file. For more information on this topic see [Terraform variables documentation](http://www.terraform.io/intro/getting-started/variables.html).

## Authentication

To get the examples to work with you OTC Account, you need three informations:

* username (User Name from "My Credential")
* password (your login password)
* domain\_name (Domain Name from "My Credential")

Please refer the following [OTC Helpcenter](https://docs.otc.t-systems.com/) documentation article to find authentication details: 

[How Do I Modify My Credential Information?](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_topic_0046606214.html)

[How Do I Manage Access Keys?](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_topic_0046606340.html)

![My Credential](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_image_0049334540.jpg )

## Known Issues

### Loadbalancing

There is currently a problem with Terraform and the creation of a health monitor, resulting in a crash of Terraform. For the progress on this bug, the [this Github issue](https://github.com/terraform-providers/terraform-provider-openstack/issues/98)
It is also not possible to set a custom connection limit for the LBaasV2 listener. This parameter has to be either omitted or set to -1 to work with OTC.

### Floating IP Association

Floating IP associaten works, but Terraform is unable to determine if the floating IP is still attached in any subsequent runs. This is due to how the external network is setup in OTC. There is a [corresponding github issue](https://github.com/terraform-providers/terraform-provider-openstack/issues/88) where this is currently being discussed. As a workaround, it is possible to create a port via the `openstack_networking_port_v2` resource, and attach the instance and the floating IP to that port. This will work without issues.

### Network Datasource

The datasource [openstack_networking_network_v2](https://www.terraform.io/docs/providers/openstack/d/networking_network_v2.html) is currently not working. There is a problem with the filtering of networks in the Neutron API that is currently worked on. As soon as this is resolved, this document will be updated.
