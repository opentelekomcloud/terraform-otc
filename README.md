## Terraform configurations file examples for Open Telekom Cloud ##
Below Open Telekom Cloud services are currently supported by Terraform:
- IAM - Identity and Access Management
- ECS - Elastic Cloud Server
- VPC - Virtual Private Cloud
- EVS - Elastic Volume Service
- OBS - Object Storage Service, through AWS (S3) provider

## provider.tf ##
Authentication configurations file example for OpenStack and AWS (OBS) providers.

## main.tf ##
Infrastructure-as-Code file example describing below infrastructure:

*	VPC network
    * Subnet 
    * Router
*	Security group
*	2 instances of ECS
    *	Based on specified image
    *	additional EVS volumes
    *	Specified server resources
    *	Dynamically assigned EIPs
* OBS bucket
    * A file uploaded to the bucket

## variables.ft ##
Supporting variables

## output.ft ##
Prints EIPs of ECS instances that have been created.
