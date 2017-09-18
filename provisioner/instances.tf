resource "openstack_compute_instance_v2" "webserver" {
  count          = "${var.instance_count}"
  name           = "${var.project}-webserver${format("%02d", count.index+1)}"
  image_name     = "${var.image_name}"
  flavor_name    = "${var.flavor_name}"
  key_pair       = "${openstack_compute_keypair_v2.keypair.name}"
  user_data      = "${data.template_file.webserver.rendered}"
  depends_on     = ["openstack_networking_router_interface_v2.interface"]

  network {
    port = "${element(openstack_networking_port_v2.network_port.*.id, count.index)}"
  }
}

resource "null_resource" "provision" {
  depends_on = ["openstack_compute_instance_v2.webserver"]

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    host        = "${openstack_networking_floatingip_v2.fip.address}"
    # private_key = "${file("${var.ssh_priv_key}")}" works only for unencrypted private keys
    agent       = "true"
  }

  provisioner "file" {
    source      = "${template_dir.config.destination_dir}"
    destination = "/tmp/etc"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp -a /tmp/etc/* /etc/.",
    ]
  }
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
