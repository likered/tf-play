variable "access_key" {}
variable "secret_key" {}
variable "subnet_id" {}
variable "vpc_id" {}

variable "terraform_ssh" {
  default = "/home/likered/.ssh/terraform.pem"
}
variable "region" {
  default = "us-east-1"
}
variable "key_pair_name" {
  default = "terraform"
}
variable "instance_name" {
  default = "ec2-with-users"
}
variable "ssh_port" {
  default = 22
}
variable "ssh_user" {
  default = "ubuntu"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}
