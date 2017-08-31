resource "openstack_lb_loadbalancer_v2" "loadbalancer" {
  name           = "${var.project}-loadbalancer"
  vip_subnet_id  = "${openstack_networking_subnet_v2.subnet.id}"
  admin_state_up = "true"
}

resource "openstack_lb_listener_v2" "listener" {
  name            = "${var.project}-listener"
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.loadbalancer.id}"
  admin_state_up  = "true"
}

resource "openstack_lb_pool_v2" "pool" {
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"
  listener_id = "${openstack_lb_listener_v2.listener.id}"
}

resource "openstack_lb_member_v2" "member" {
  count         = "${var.instance_count}"
  address       = "${element(openstack_compute_instance_v2.webserver.*.access_ip_v4, count.index)}"
  pool_id       = "${openstack_lb_pool_v2.pool.id}"
  subnet_id     = "${openstack_networking_subnet_v2.subnet.id}"
  protocol_port = 80
}

#resource "openstack_lb_monitor_v2" "monitor" {
#  pool_id     = "${openstack_lb_pool_v2.pool.id}"
#  type        = "HTTP"
#  delay       = 20
#  timeout     = 10
#  max_retries = 5
#}
