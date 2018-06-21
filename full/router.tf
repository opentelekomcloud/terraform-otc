resource "openstack_networking_router_v2" "router" {
  name                = "${var.project}-router"
  admin_state_up      = "true"
  external_network_id = "${data.openstack_networking_network_v2.extnet.id}"
}

resource "openstack_networking_router_interface_v2" "interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}

