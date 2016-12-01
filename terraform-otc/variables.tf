variable "image_id" {
  default = "d9aa99ba-9876-498b-949f-b6c237ba2c04"
}

variable "myinstance_name" {
  default = "terraformcern"
}

variable "instance_count" {
  default = "1"
}

variable "flavor_id" {
  default = "computev1-1"
}

variable "mykeypair_name" {
  default = "terraform"
}


variable "ssh_user_name" {
  default = "linux"
}

variable "external_gateway" {
  default = "0a2228f2-7f8a-45f1-8e09-9039e1d09975"
}

variable "pool" {
  default = "public"
}
