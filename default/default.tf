provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

module "jumpbox" {
    source = "../jumpbox"
    
    aws_access_key = "${var.aws_access_key}"
    aws_secret_key = "${var.aws_secret_key}"
    aws_region = "${var.aws_region}"
    vpc_id = "${var.default_vpc_id}"
    instance_type = "${var.instance_type}"
    ami = "${lookup(var.amis, format("%s_%s",var.jumpbox_type, var.aws_region))}"
    aws_key_name = "${var.aws_key_name}"
    aws_key_path = "${var.aws_key_path}"
    name_tag = "${var.name_tag}"
    owner_tag = "${var.owner_tag}"
    uuid = "${var.uuid}"
    jumpbox_user = "${var.jumpbox_user}"
    jumpbox_type = "${var.jumpbox_type}"
}

output "jumpbox_ip" {
  value = "${module.jumpbox.jumpbox_ip}"
}

output "jumpbox_user" {
  value = "${var.jumpbox_user}"
}

output "aws_key_path" {
  value = "${var.aws_key_path}"
}
