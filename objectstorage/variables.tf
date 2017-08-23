
variable "username" {
  default = "Your OTC full Username"
}

variable "password" {
  default = "Your OTC password"
}

variable "domain" {
  default = "Your DOMAIN name (2 part of the username)"
}

variable "mykeypair_name" {
  default = "Your keypair name"
}

variable "endpoint" {
  default = "https://iam.eu-de.otc.t-systems.com:443/v3"
}

variable "image_name" {
  default = "Standard_CentOS_7.3_latest"
}

variable "myinstance_name" {
  default = "terravm"
}

variable "instance_count" {
  default = "1"
}

variable "flavor_id" {
  default = "computev1-1"
}


variable "ssh_user_name" {
  default = "linux"
}

variable "external_gateway" {
  default = "0a2228f2-7f8a-45f1-8e09-9039e1d09975"
}

variable "eip_pool" {
  default = "admin_external_net"
}

variable "ssh_key_file" {
  default = "/data/hadoop.pem"
}

variable "obs_filename" {
  default = "/data/sample.txt"
}

variable "aws_access_key" {
  default = "YOUR ACESS KEY for S3-OBS"
}


variable "aws_secret_key" {
  default = "YOUR SECRET KEY for S3-OBS"
}
