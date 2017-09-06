data "template_file" "webserver" {
  template = "${file("${path.module}/templates/cloudinit.tpl")}"

  vars {
    package = "httpd"
  }
}
