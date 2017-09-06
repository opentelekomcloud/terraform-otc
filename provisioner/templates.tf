data "template_file" "webserver" {
  template = "${file("${path.module}/templates/cloudinit.tpl")}"

  vars {
    package = "httpd"
  }
}

resource "template_dir" "config" {
  source_dir = "${path.module}/templates/etc"
  destination_dir = "${path.module}/templates/etc_rendered"

  vars {
    project = "${var.project}"
    domain  = "${var.domain_name}"
    dnsname = "${var.dnsname}.${var.dnszone}"
  }
}
