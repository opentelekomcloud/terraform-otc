resource "opentelekomcloud_dns_zone_v2" "dnszone" {
  name  = "${var.dnszone}."
  email = "email@${var.dnszone}"
  ttl   = 6000
}

resource "opentelekomcloud_dns_recordset_v2" "recordset" {
  zone_id = "${opentelekomcloud_dns_zone_v2.dnszone.id}"
  name    = "${var.dnsname}.${var.dnszone}."
  ttl     = 3000
  type    = "A"
  records = ["${opentelekomcloud_networking_floatingip_v2.fip.*.address}"]
}
