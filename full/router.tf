resource "openstack_networking_router_v2" "router" {
  name             = "${var.project}-router"
  admin_state_up   = "true"
  #external_gateway = "${data.openstack_networking_network_v2.external_network.id}"
  external_gateway = "0a2228f2-7f8a-45f1-8e09-9039e1d09975"
}

resource "openstack_networking_router_interface_v2" "interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}

