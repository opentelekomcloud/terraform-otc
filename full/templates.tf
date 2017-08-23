data "template_file" "init" {
  template = "${file("${path.module}/templates/apache.tpl")}"

  vars {
    internal_ip = ""
    external_ip = ""
  }
}
