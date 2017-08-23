resource "openstack_blockstorage_volume_v2" "volume" {
  count       = "${var.instance_count}"
  name        = "${var.project}-disk${format("%02d", count.index+1)}"
  size        = "${var.disk_size_gb}" 
}
