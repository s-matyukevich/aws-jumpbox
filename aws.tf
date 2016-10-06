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

resource "aws_security_group" "training_sg" {
    vpc_id = "${coalesce(var.default_vpc_id, aws_vpc.training_vpc.id)}"
    description = "Training security group"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80 
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443 
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 2222
        to_port = 2222
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3306
        to_port = 3006
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }

    tags {
        Name = "training_sg_${var.name_tag}"
        Owner = "${var.owner_tag}"
        UUID = "${var.uuid}"
    }
}

module "jumpbox_full" {
    source = "./jumpbox"
    
    instance_type = "${var.instance_type}"
    ami = "${lookup(var.amis, concat(var.jumpbox_type, '_', var.aws_region))}"
    aws_key_name = "${var.aws_key_name}"
    aws_key_path = "${var.aws_key_path}"
    security_group_id = "${aws_security_group.training_sg.id}"
    subnet_id = "${aws_subnet.vpc_public_subnet.id}"
    name_tag = "${var.name_tag}"
    owner_tag = "${var.owner_tag}"
    uuid = "${var.uuid}"
    jumpbox_user = "${var.jumpbox_user}"
    jumpbox_type = "${var.jumpbox_type}"
}

module "jumpbox_default" {
    source = "./jumpbox"
    
    instance_type = "${var.instance_type}"
    ami = "${lookup(var.amis, concat(var.jumpbox_type, '_', var.aws_region))}"
    aws_key_name = "${var.aws_key_name}"
    aws_key_path = "${var.aws_key_path}"
    security_group_id = "${aws_security_group.training_sg.id}"
    name_tag = "${var.name_tag}"
    owner_tag = "${var.owner_tag}"
    uuid = "${var.uuid}"
    jumpbox_user = "${var.jumpbox_user}"
    jumpbox_type = "${var.jumpbox_type}"
}

output "jumpbox_ip" {
  value = "${coalesce(module.jumpbox_full.jumpbox_ip, module,jumpbox_default.jumbox_ip)}"
}

output "jumpbox_user" {
  value = "${var.jumpbox_user}"
}

output "aws_key_path" {
  value = "${var.aws_key_path}"
}
