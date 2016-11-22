variable "instance_type" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_key_name" {}
variable "aws_key_path" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "name_tag" {}
variable "owner_tag" {}
variable "uuid" {}
variable "jumpbox_user" {}
variable "jumpbox_type" {}
variable "cf_domain" {}
variable "cf_admin" {}
variable "cf_admin_password" {}

variable "amis" {
    description = "AMIs by region"
    default = {
	default_ubuntu_ap-northeast-1	= "ami-483f9429"	
	default_ubuntu_ap-south-1	= "ami-54d2a63b"
	default_ubuntu_ap-southeast-1	= "ami-5b268538"
	default_ubuntu_eu-central-1	= "ami-82cf0aed"
	default_ubuntu_eu-west-1	= "ami-07174474"
	default_ubuntu_sa-east-1	= "ami-0c188760"
	default_ubuntu_us-east-1	= "ami-45b69e52"
	default_ubuntu_us-west-1	= "ami-dab5e0ba"
	default_ubuntu_cn-north-1	= "ami-593feb34"
	default_ubuntu_ap-northeast-2	= "ami-27825549"
	default_ubuntu_ap-southeast-2	= "ami-e199a682	"
	default_ubuntu_us-east-2	= "ami-1b772d7e"
	default_ubuntu_us-west-2	= "ami-9ee24ffe"

	hpe_ap-northeast-1	= "ami-483f9429"	
	hpe_ap-south-1		= "ami-54d2a63b"
	hpe_ap-southeast-1	= "ami-5b268538"
	hpe_eu-central-1	= "ami-82cf0aed"
	hpe_eu-west-1		= "ami-07174474"
	hpe_sa-east-1		= "ami-0c188760"
	hpe_us-east-1		= "ami-45b69e52"
	hpe_us-west-1		= "ami-dab5e0ba"
	hpe_cn-north-1		= "ami-593feb34"
	hpe_ap-northeast-2	= "ami-27825549"
	hpe_ap-southeast-2	= "ami-e199a682"
	hpe_us-east-2		= "ami-1b772d7e"
	hpe_us-west-2		= "ami-9ee24ffe"

        single_vm_cf_us-west-1        =  "ami-5a105e3a"
    }
}
