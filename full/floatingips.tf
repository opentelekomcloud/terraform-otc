resource "openstack_networking_floatingip_v2" "fip" {
  pool    = "${var.external_network}"
  port_id = "${openstack_lb_loadbalancer_v2.loadbalancer.vip_port_id}"
}
