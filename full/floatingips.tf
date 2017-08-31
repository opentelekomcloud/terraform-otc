#resource "openstack_networking_floatingip_v2" "fip" {
#  count = "${var.instance_count}"
#  pool  = "${var.external_network}"
#}

resource "openstack_networking_floatingip_v2" "fip" {
  count = "${var.instance_count}"
  pool  = "${var.external_network}"
  port_id = "${element(openstack_networking_port_v2.network_port.*.id, count.index)}"
}
