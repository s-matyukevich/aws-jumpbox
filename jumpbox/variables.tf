variable "instance_type" {}
variable "ami" {}
variable "aws_key_name" {}
variable "aws_key_path" {}
variable "security_group_id" {}
variable "subnet_id" {
    default: ""
}
variable "name_tag" {}
variable "owner_tag" {}
variable "uuid" {}
variable "jumpbox_user" {}
variable "jumpbox_type" {}
