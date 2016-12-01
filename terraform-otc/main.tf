#resource "openstack_compute_keypair_v2" "terraform" {
#  name       = "terraform"
#  public_key = "${file("${var.ssh_key_file}.pub")}"
#}

resource "openstack_networking_network_v2" "terraform" {
  name           = "terraform"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "terraform" {
  name            = "terraform"
  network_id      = "${openstack_networking_network_v2.terraform.id}"
  cidr            = "10.0.0.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "terraform" {
  name             = "terraform"
  admin_state_up   = "true"
  external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "terraform" {
  router_id = "${openstack_networking_router_v2.terraform.id}"
  subnet_id = "${openstack_networking_subnet_v2.terraform.id}"
}

resource "openstack_compute_secgroup_v2" "terraform" {
  name        = "terraform"
  description = "Security group for the Terraform example instances"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}

#resource "openstack_compute_floatingip_v2" "terraform" {
#  pool       = "${var.pool}"
#  depends_on = ["openstack_networking_router_interface_v2.terraform"]
#}


resource "openstack_blockstorage_volume_v2" "terraform" {
  name = "terraexample"
  description = "first test volume"
  size = 100
}

resource "openstack_compute_instance_v2" "terraform" {
  depends_on = ["openstack_networking_router_interface_v2.terraform"]
  name            = "${var.myinstance_name}"
  count            = "${var.instance_count}"
  image_id      = "${var.image_id}"
  flavor_id     = "${var.flavor_id}"
  key_pair        = "${var.mykeypair_name}"
  security_groups = ["${openstack_compute_secgroup_v2.terraform.name}"]

  network {
    uuid = "${openstack_networking_network_v2.terraform.id}"
  }

  volume {
    volume_id = "${openstack_blockstorage_volume_v2.terraform.id}"
  }

  user_data = "${file("/data/cloud-config.yml")}"
}
