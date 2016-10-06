resource "aws_instance" "training_jumpbox" {
    ami = "${var.ami}"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}"
    security_groups = ["${var.securty_group_id}"]
    subnet_id = "${var.subnet.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "jumpbox_${var.name_tag}"
        Owner = "${var.owner_tag}"
        UUID = "${var.uuid}"
    }

    connection {
        user = "${var.jumpbox_user}"
        private_key = "${file(var.aws_key_path})}"
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
        inline = [
                   "chmod +x /home/${var.jumpbox_user}/bin/common.sh",
                   "chmod +x /home/${var.jumpbox_user}/bin/run.sh",
                   "sh /home/${var.jumpbox_user}/bin/common.sh",
                   "sh /home/${var.jumpbox_user}/bin/run.sh"
                 ]
    }
}

output "jumpbox_ip" {
  value = "${aws_instance.training_jumpbox.public_ip}"
}
