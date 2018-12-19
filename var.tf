variable "access_key" {}
variable "secret_key" {}
variable "subnet_id" {}

variable "region" {
  default = "us-east-1"
}

variable "amis" {
  type = "map"
}
