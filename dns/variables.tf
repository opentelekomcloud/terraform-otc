### opentelekomcloud Credentials
variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "tenant_name" {
  default = "eu-de"
}

variable "endpoint" {
  default = "https://iam.eu-de.otc.t-systems.com:443/v3"
}

### OTC Specific Settings
variable "external_network" {
  default = "admin_external_net"
}

### Project Settings
variable "project" {
  default = "terraform"
}

variable "subnet_cidr" {
  default = "192.168.10.0/24"
}

variable "ssh_pub_key" {
  default = "~/.ssh/id_rsa.pub"
}

### DNS Settings
variable "dnszone" {}

variable "dnsname" {
  default = "webserver"
}

### VM (Instance) Settings
variable "instance_count" {
  default = "1"
}

variable "flavor_name" {
  default = "s2.medium.4"
}

variable "image_name" {
  default = "Standard_CentOS_7_latest"
}

variable "disk_size_gb" {
  default = "10"
}
