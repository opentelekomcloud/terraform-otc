resource "openstack_compute_keypair_v2" "terraform_key" {
  name       = "terraform_key"
  public_key = "${file("${var.ssh_key_file}.pub")}"
  }

resource "openstack_networking_network_v2" "terra_net1" {
  name           = "terra_net1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "terra_sub1" {
  name            = "terra_sub1"
  network_id      = "${openstack_networking_network_v2.terra_net1.id}"
  cidr            = "192.168.199.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "terra_router1" {
  name             = "terra_router1"
  admin_state_up   = "true"
  external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "router_int1" {
  router_id = "${openstack_networking_router_v2.terra_router1.id}"
  subnet_id = "${openstack_networking_subnet_v2.terra_sub1.id}"
}

resource "openstack_compute_secgroup_v2" "terra_sec1" {
  name        = "terra_sec1"
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

resource "openstack_compute_floatingip_v2" "eip" {
  depends_on = ["openstack_networking_router_interface_v2.router_int1"]
  count      = "${var.instance_count}"
  pool       = "${var.eip_pool}"
}


resource "openstack_blockstorage_volume_v2" "terraform" {
  count       =  "${var.instance_count}"
  name        = "terravmdisk-${format("%04d", count.index+1)}"
  description = "additional disk"
  size        = 50
}

resource "openstack_compute_instance_v2" "terraform" {
 depends_on       = ["openstack_networking_router_interface_v2.router_int1"]
  count           = "${var.instance_count}"
  name            = "${var.myinstance_name}-${format("%04d", count.index+1)}"
  image_id        = "${var.image_id}"
  flavor_id       = "${var.flavor_id}"
  key_pair        = "terraform_key"
  security_groups = ["${openstack_compute_secgroup_v2.terra_sec1.name}"]
  floating_ip     = "${element(openstack_compute_floatingip_v2.eip.*.address, count.index)}"


  network {
    uuid = "${openstack_networking_network_v2.terra_net1.id}"
    access_network = true
  }

  volume {
    volume_id = "${element(openstack_blockstorage_volume_v2.terraform.*.id, count.index)}"
  }

  user_data = "${file("/data/cloud-config.yml")}"
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "terra-test"
  acl    = "public-read"
  versioning {
    enabled = true
  }
  force_destroy = true
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.mybucket.bucket}"
  key    = "testfile"
  source = "${var.obs_filename}"
  acl    = "public-read"
}
