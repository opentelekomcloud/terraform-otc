# Terraform examples for Open Telekom Cloud

Terraform is a provider agnostic framework to create and maintain infrastructure on public clouds. To interface with actual providers, Terraform comes with a modular architecture. To access the Open Telekom Cloud (OTC) the OpenStack provider can be used as the OTC implements a lot of OpenStack APIs. This project includes example projects for different use cases users can adopt as a starting point for their own installations.

## Compatibility List

The examples in this repository are testet with:
* Terraform: **v0.10.5**
* OpenStack Provider: **0.2.2**

| Terraform Resource | Status      |
| ------------------ | ----------- |
| Data Sources       | Working     |
| Block Storage      | Working     |
| Compute            | Working     |
| DNS                | Working     |
| Images             | Working     |
| Networking         | Working     |
| Load Balancer      | Working     |
| Firewall           | Not working |

## Description

There are different examples of Terraform scripts, each with a different purpose:

**minimal** 

A minimal Terraform example with just the components to get a virtual machine running and connect to it with a public ip. If you are new to Terraform, this is the recommended example to start with.

**dns**

A bit more complex example, inlcuding handling of DNS and additional storage volumes. If you already worked with Terraform or you got the minimal example running and want to explore more, try this example.

**objectstorage**

An example on how to use the object storage that is included in OTC by utilizing the AWS provider.

**provisioner**

This based on the minimal example, showing the usage of Terraform's provisioner to execute commands and deploy files on the created instances.

An example on how to use the object storage included in OTC by utilizing the AWS provider.

**full**

A complete example, showing the full power of terraform. Components can be enabled and disabled via configuration file. This can be used as a template for production grade Terraform scripts.

**modules**

One strong argument for Terraform is the option to create reusable modules. This example shows how easy it is to create a full infrastructure deployment on the OTC by utilizing the Terraform modules provided in the [terraform-otc-module](https://github.com/OpenTelekomCloud/terraform-otc-modules) repository.

## Quick Start

1. Install [Terraform](https://www.terraform.io/intro/getting-started/install.html).
2. Clone this repository via `git clone https://github.com/OpenTelekomCloud/terraform-otc.git`.
3. Switch to terraform directory `cd terraform-otc/minimal`.
4. Initialize Terraform provider via `terraform init`.
5. Insert your login information into `parameter.tvars` (see next section).
6. Check if everything looks fine with `terraform plan -var-file=parameter.tvars`.
7. Apply the changes via `terraform apply -var-file=parameter.tvars`.

## Customization

All variables that can be changed are documented in `variables.tf`. There are reasonable default values for most of the variables in this file. Every variable may be overwritten by passing command line arguments to the Terraform invocation, or simply by passing a parameter file via the `-var-file` command line parameter. All the examples provide a file `parameters.tvars` containing all necessary parameters for the example to work (for example your login information). You can add more parameters for any variable existing in the `variables.tf` file. For more information see [Terraform variables documentation](http://www.terraform.io/intro/getting-started/variables.html).

## Authentication

To get the examples to work with you OTC account, you need three information bits:

* username (user name from `My Credential`)
* password (your login password)
* domain\_name (Domain Name from `My Credential`)

Refer to the [OTC Helpcenter](https://docs.otc.t-systems.com/) documentation article to find authentication details: 

[How Do I Modify My Credential Information?](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_topic_0046606214.html)

[How Do I Manage Access Keys?](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_topic_0046606340.html)

![My Credential](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_image_0049334540.jpg )

## Known Issues

### Floating IP Association

Floating IP associaten works, but Terraform is unable to determine if the floating IP is still attached in any subsequent runs. This is due to how the external network is setup in OTC. There is a [corresponding github issue](https://github.com/terraform-providers/terraform-provider-openstack/issues/88) where this is currently being discussed. As a workaround, it is possible to create a port via the `openstack_networking_port_v2` resource, and attach the instance and the floating IP to that port. This will work without issues.
