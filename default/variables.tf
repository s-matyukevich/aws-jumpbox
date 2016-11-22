variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
}

variable "jumpbox_type" {
    description = "jumpbox type (default_ubuntu | single_vm_cf)"
}

variable "default_vpc_id" {
    description = "Default VPC Id"
}

variable "instance_type" {
    description = "Instance type"
}

variable "jumpbox_user" {
    description = "jumpbox user name (default: ubuntu)"
    default = "ubuntu"
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
