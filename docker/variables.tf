variable "jumpbox_type" {
    description = "jumpbox type (default_ubuntu | single_vm_cf)"
}

variable "jumpbox_user" {
    description = "jumpbox user name (default: ubuntu)"
    default = "root"
}

variable "jumpbox_password" {
}

variable  "key_path" {
}


variable "docker_image" {
    default = "rastasheep/ubuntu-sshd:16.04"
}

variable "docker_host" {
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
    default = ""
}

variable "cf_admin" {
    default = ""
}

variable "cf_admin_password" {
    default = ""
}
