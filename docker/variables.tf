variable "jumpbox_type" {
    description = "jumpbox type (default_ubuntu | single_vm_cf)"
}

variable "jumpbox_user" {
    default = "ubuntu"
}

variable "root_password" {
    default = "root"
}

variable "docker_image" {
    default = "smatyukevich/training-container"
}

variable  "public_key_path" {
}

variable "ssh_host" {
}

variable  "private_key_path" {
}

variable "docker_host" {
}

variable "docker_port" {
}

variable "external_port" {
}

variable "cpu_shares" {
}

variable "memory" {
}

variable "uuid" {
    description = "Unique prefix for all resources"
}

variable "owner_tag" {
    description = "Value for owner tag"
}

variable "name_tag" {
    description = "Value for name tag"
}

variable "cf_domain" {
}

variable "cf_admin" {
}

variable "cf_admin_password" {
}
