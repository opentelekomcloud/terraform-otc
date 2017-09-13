module "vpc" {
    source = "github.com/OpenTelekomCloud/terraform-otc-modules//vpc"
    name   = "${var.project}-net"
    subnet = "${var.subnet_cidr}"
}

module "ecs" {
    source     = "github.com/OpenTelekomCloud/terraform-otc-modules//ecs"
    ecs_count  = "${var.instance_count}"
    name       = "${var.project}-server"
    image      = "${var.image_name}"
    flavor     = "${var.flavor_name}"
    pubkey     = "${file(var.ssh_pub_key)}"
    network_id = "${module.vpc.network_id}"
    subnet_id  = "${module.vpc.subnet_id}"
}

module "evs" {
    source     = "github.com/OpenTelekomCloud/terraform-otc-modules//evs"
    name       = "${var.project}-volume"
    evs_count  = "${module.ecs.count}"
    size_in_gb = "${var.disk_size_gb}"
    ecs_ids    = ["${module.ecs.ids}"]
}

module "ulb" {
    source        = "github.com/OpenTelekomCloud/terraform-otc-modules//ulb"
    name          = "${var.project}-lbaas"
    subnet_id     = "${module.vpc.subnet_id}"
    members_count = "${module.ecs.count}"
    members       = ["${module.ecs.addresses}"]
    dependencies  = ["${module.vpc.interface_port}"]
}
