provider "docker" {
    host = "${var.docker_host}"
}

resource "docker_image" "ubuntu" {
    name = "${var.docker_image}"
}

resource "docker_container" "training_container" {
    image = "${docker_image.ubuntu.latest}"
    memory = "${var.memory}"
    cpu_shares = "${var.cpu_shares}"
    name = "cf-training=${var.uuid}"

    ports {
        internal = 22
        external = "${var.external_port}"
    }

    connection {
        user = "${var.jumpbox_user}"
        private_key = "${file("${var.aws_key_path}")}"
    }

    provisioner "local-exec" {
        command = "${path.module}/../scripts/${var.jumpbox_type}-local.sh"
    }

    provisioner "file" {
        source = "${path.module}/../scripts/common.sh"
        destination = "/home/${var.jumpbox_user}/common.sh"
    }

    provisioner "file" {
        source = "${path.module}/../scripts/${var.jumpbox_type}.sh"
        destination = "/home/${var.jumpbox_user}/run.sh"
    }

    provisioner "remote-exec" {
        inline = [ "chmod +x /home/${var.jumpbox_user}/bin/common.sh",
                   "chmod +x /home/${var.jumpbox_user}/bin/run.sh",
                   "sh /home/${var.jumpbox_user}/common.sh",
                   "sh /home/${var.jumpbox_user}/run.sh ${var.cf_domain} ${var.name_tag} ${var.uuid}"]
    }
}
