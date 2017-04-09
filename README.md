## Terraform configurations file examples for Open Telekom Cloud ##
Below Open Telekom Cloud services are currently supported by Terraform:
- IAM - Identity and Access Management
- ECS - Elastic Cloud Server
- VPC - Virtual Private Cloud
- EVS - Elastic Volume Service
- OBS - Object Storage Service, through AWS (S3) provider

## provider.tf ##
Authentication configurations file example for OpenStack and AWS (OBS) providers.

Please refer the following [OTC Helpcenter](https://docs.otc.t-systems.com/) documentation article to find authentication details: 

[How Do I Modify My Credential Information?](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_topic_0046606214.html)

[How Do I Manage Access Keys?](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_topic_0046606340.html)

![My Credential](https://docs.otc.t-systems.com/en-us/usermanual/ac/en-us_image_0049334540.jpg )



Step by step setup of important values:
```
provider "openstack" {

    user_name   = "xxxxxx"   <- User Name from My Credential
    password    = "yyyyyy" <- Login password
    domain_id   = "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" <- Domain ID from My Credential

...

provider "aws" {

    access_key = "${var.aws_access_key}" <- Access Key Id of a previously created Access Key
    secret_key = "${var.aws_secret_key}" <- Secret Access Key of a previously created Access Key
```

Default value could be set in variables.tf: 

variable "aws_access_key"

variable "aws_secret_key" 

  
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
