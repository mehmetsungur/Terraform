variable "vpc_id" {}
variable "subnet_id" {}

variable "subnet_cidr_block" {
  default = "10.0.10.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "env_prefix" {
  default = "dev"
}

variable "protocol" {
  default = "TCP"
}

variable "name" {
  default = "Viennalife"
}

variable "image_name" {
  default = "amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"
}

variable "instance_type" {
  default = "t2.micro"
}