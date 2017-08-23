resource "openstack_networking_network_v2" "network" {
  name           = "${var.project}-network"
  admin_state_up = "true"
}

#data "openstack_networking_network_v2" "external_network" {
#  name   = "admin_external_net"
#}

resource "openstack_networking_subnet_v2" "subnet" {
  name            = "${var.project}-subnet"
  network_id      = "${openstack_networking_network_v2.network.id}"
  cidr            = "10.6.0.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}
