provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_vpc" "training_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "training_vpc_${var.name_tag}"
        Owner = "${var.owner_tag}"
        UUID = "${var.uuid}"
    }
}

resource "aws_subnet" "vpc_public_subnet" {
    vpc_id = "${aws_vpc.training_vpc.id}"
    map_public_ip_on_launch = true

    cidr_block = "${var.public_subnet_cidr}"

    tags {
        Name = "training_subnet_${var.name_tag}"
        Owner = "${var.owner_tag}"
        UUID = "${var.uuid}"
    }
}

resource "aws_internet_gateway" "vpc_internet_gateway" {
    vpc_id = "${aws_vpc.training_vpc.id}"
    tags {
        Name = "internet_gateway_${var.name_tag}"
        Owner = "${var.owner_tag}"
        UUID = "${var.uuid}"
    }
}

resource "aws_route_table" "vpc_public_subnet_router" {
    vpc_id = "${aws_vpc.training_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.vpc_internet_gateway.id}"
    }

    tags {
        Name = "public_subnet_router_${var.name_tag}"
        Owner = "${var.owner_tag}"
        UUID = "${var.uuid}"
    }
}

resource "aws_route_table_association" "vpc_public_subnet_router_association" {
    subnet_id = "${aws_subnet.vpc_public_subnet.id}"
    route_table_id = "${aws_route_table.vpc_public_subnet_router.id}"
}


module "jumpbox" {
    source = "../jumpbox"
    
    aws_access_key = "${var.aws_access_key}"
    aws_secret_key = "${var.aws_secret_key}"
    aws_region = "${var.aws_region}"
    vpc_id = "${aws_vpc.training_vpc.id}"
    instance_type = "${var.instance_type}"
    ami = "${lookup(var.amis, concat(var.jumpbox_type, var.aws_region))}"
    aws_key_name = "${var.aws_key_name}"
    aws_key_path = "${var.aws_key_path}"
    subnet_id = "${aws_subnet.vpc_public_subnet.id}"
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
