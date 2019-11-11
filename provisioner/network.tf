data "opentelekomcloud_networking_network_v2" "extnet" {
  name = "${var.external_network}"
}

resource "opentelekomcloud_networking_network_v2" "network" {
  name           = "${var.project}-network"
  admin_state_up = "true"
}

resource "opentelekomcloud_networking_subnet_v2" "subnet" {
  name            = "${var.project}-subnet"
  network_id      = "${opentelekomcloud_networking_network_v2.network.id}"
  cidr            = "${var.subnet_cidr}"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}
