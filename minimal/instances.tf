resource "opentelekomcloud_compute_instance_v2" "webserver" {
  count           = "${var.instance_count}"
  name            = "${var.project}-webserver${format("%02d", count.index+1)}"
  image_name      = "${var.image_name}"
  flavor_name     = "${var.flavor_name}"
  key_pair        = "${opentelekomcloud_compute_keypair_v2.keypair.name}"
  security_groups = [
    "${opentelekomcloud_compute_secgroup_v2.secgrp_web.name}"
  ]

  network {
    uuid = "${opentelekomcloud_networking_network_v2.network.id}"
  }
  depends_on      = ["opentelekomcloud_networking_router_interface_v2.interface"]
}

resource "opentelekomcloud_compute_floatingip_associate_v2" "webserver_fip" {
  floating_ip           = "${opentelekomcloud_networking_floatingip_v2.fip.address}"
  instance_id           = "${opentelekomcloud_compute_instance_v2.webserver.id}"
  wait_until_associated = "true"
}
