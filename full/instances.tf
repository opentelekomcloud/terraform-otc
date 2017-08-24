resource "openstack_compute_instance_v2" "webserver" {
  count           = "${var.instance_count}"
  name            = "${var.project}-webserver${format("%02d", count.index+1)}"
  image_name      = "${var.image_name}"
  flavor_name     = "${var.flavor_name}"
  key_pair        = "${openstack_compute_keypair_v2.keypair.name}"
  user_data       = "${data.template_file.webserver.rendered}"
  security_groups = [
    "${openstack_compute_secgroup_v2.secgrp_web.name}"
  ]

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    private_key = "${file("${var.ssh_priv_key}")}"
  }

  provisioner "file" {
    source      = "${template_dir.config.destination_dir}"
    destination = "/etc"
  }

  network {
    uuid           = "${openstack_networking_network_v2.network.id}"
    access_network = true
  }
}

resource "openstack_compute_volume_attach_v2" "volume_attach" {
  count       = "${var.disk_size_gb > 0 ? var.instance_count : 0}"
  instance_id = "${element(openstack_compute_instance_v2.webserver.*.id, count.index)}"
  volume_id   = "${element(openstack_blockstorage_volume_v2.volume.*.id, count.index)}"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  count       = "${var.instance_count}"
  floating_ip = "${element(openstack_compute_floatingip_v2.fip.*.address, count.index)}"
  instance_id = "${element(openstack_compute_instance_v2.webserver.*.id, count.index)}"
}
