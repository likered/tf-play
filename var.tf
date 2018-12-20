variable "access_key" {}
variable "secret_key" {}
variable "subnet_id" {}
variable "vpc_id" {}

variable "region" {
  default = "us-east-1"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  } 
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
