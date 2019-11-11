resource "opentelekomcloud_compute_instance_v2" "webserver" {
  count          = "${var.instance_count}"
  name           = "${var.project}-webserver${format("%02d", count.index+1)}"
  image_name     = "${var.image_name}"
  flavor_name    = "${var.flavor_name}"
  key_pair       = "${opentelekomcloud_compute_keypair_v2.keypair.name}"
  user_data      = "${data.template_file.webserver.rendered}"
  depends_on     = ["opentelekomcloud_networking_router_interface_v2.interface"]
  security_groups = [
    "${opentelekomcloud_compute_secgroup_v2.secgrp_web.name}"
  ]

  network {
    uuid = "${opentelekomcloud_networking_network_v2.network.id}"
  }
}

resource "opentelekomcloud_compute_floatingip_associate_v2" "webserver_fip" {
  floating_ip           = "${opentelekomcloud_networking_floatingip_v2.fip.address}"
  instance_id           = "${opentelekomcloud_compute_instance_v2.webserver.id}"
  wait_until_associated = "true"
}

resource "null_resource" "provision" {
  depends_on = ["opentelekomcloud_compute_instance_v2.webserver"]

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    host        = "${opentelekomcloud_networking_floatingip_v2.fip.address}"
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
