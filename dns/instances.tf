resource "openstack_compute_instance_v2" "webserver" {
  count           = "${var.instance_count}"
  name            = "${var.project}-webserver${format("%02d", count.index+1)}"
  image_name      = "${var.image_name}"
  flavor_name     = "${var.flavor_name}"
  key_pair        = "${openstack_compute_keypair_v2.keypair.name}"
  network {
    port = "${element(openstack_networking_port_v2.network_port.*.id, count.index)}"
    access_network = true
  }
  depends_on       = ["openstack_networking_router_interface_v2.interface"]
}

resource "openstack_networking_port_v2" "network_port" {
  count              = "${var.instance_count}"
  network_id         = "${openstack_networking_network_v2.network.id}"
  security_group_ids = [
    "${openstack_compute_secgroup_v2.secgrp_web.id}"
  ]
  admin_state_up     = "true"
  fixed_ip           = {
    subnet_id        = "${openstack_networking_subnet_v2.subnet.id}"
  }
}

resource "openstack_compute_volume_attach_v2" "volume_attach" {
  count       = "${var.instance_count}"
  instance_id = "${element(openstack_compute_instance_v2.webserver.*.id, count.index)}"
  volume_id   = "${element(openstack_blockstorage_volume_v2.volume.*.id, count.index)}"
}
