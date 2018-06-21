resource "openstack_compute_instance_v2" "webserver" {
  count          = "${var.instance_count}"
  name           = "${var.project}-webserver${format("%02d", count.index+1)}"
  image_name     = "${var.image_name}"
  flavor_name    = "${var.flavor_name}"
  key_pair       = "${openstack_compute_keypair_v2.keypair.name}"
  user_data      = "${data.template_file.webserver.rendered}"
  depends_on     = ["openstack_networking_router_interface_v2.interface"]

  network {
    uuid = "${openstack_networking_network_v2.network.id}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "webserver_fip" {
  floating_ip           = "${openstack_networking_floatingip_v2.fip.address}"
  instance_id           = "${openstack_compute_instance_v2.webserver.id}"
  wait_until_associated = "true"
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
