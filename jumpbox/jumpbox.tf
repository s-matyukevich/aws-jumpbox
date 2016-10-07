provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_security_group" "training_sg" {
    vpc_id = "${var.vpc_id}"
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
        to_port = 3306
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

resource "aws_instance" "training_jumpbox" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}"
    security_groups = ["${aws_security_group.training_sg.id}"]
    subnet_id = "${var.subnet_id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "jumpbox_${var.name_tag}"
        Owner = "${var.owner_tag}"
        UUID = "${var.uuid}"
    }

    connection {
        user = "${var.jumpbox_user}"
        private_key = "${file("${var.aws_key_path}")}"
    }

    provisioner "file" {
        source = "${path.module}/scripts/common.sh"
        destination = "/home/${var.jumpbox_user}/bin/common.sh"
    }

    provisioner "file" {
        source = "${path.module}/scripts/${var.jumpbox_type}.sh"
        destination = "/home/${var.jumpbox_user}/bin/run.sh"
    }

    provisioner "remote-exec" {
        inline = [ "chmod +x /home/${var.jumpbox_user}/bin/common.sh",
                   "chmod +x /home/${var.jumpbox_user}/bin/run.sh",
                   "sh /home/${var.jumpbox_user}/bin/common.sh",
                   "sh /home/${var.jumpbox_user}/bin/run.sh"]
    }
}

output "jumpbox_ip" {
  value = "${aws_instance.training_jumpbox.public_ip}"
}
