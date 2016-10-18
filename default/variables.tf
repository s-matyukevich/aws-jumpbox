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

variable "amis" {
    description = "AMIs by region"
    default = {
        default_ubuntu_us-east-1      = "ami-2b594f41"
        default_ubuntu_us-west-1      = "ami-12512d72"
        default_ubuntu_us-west-2      = "ami-63ac5803"
        default_ubuntu_eu-west-1      = "ami-6177f712"
        default_ubuntu_eu-central-1   = "ami-821cfded"
        default_ubuntu_ap-northeast-1 = "ami-f5bbab9b"
        default_ubuntu_ap-southeast-1 = "ami-b6c613d5"
        default_ubuntu_ap-southeast-2 = "ami-2a644649"
        default_ubuntu_sa-east-1      = "ami-6008870c"

        hpe_us-east-1      = "ami-2b594f41"
        hpe_us-west-1      = "ami-12512d72"
        hpe_us-west-2      = "ami-63ac5803"
        hpe_eu-west-1      = "ami-6177f712"
        hpe_eu-central-1   = "ami-821cfded"
        hpe_ap-northeast-1 = "ami-f5bbab9b"
        hpe_ap-southeast-1 = "ami-b6c613d5"
        hpe_ap-southeast-2 = "ami-2a644649"
        hpe_sa-east-1      = "ami-6008870c"

        single_vm_cf_us-west-1        =  "ami-5a105e3a"
    }
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
