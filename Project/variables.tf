variable "vpc_id" {}
variable "subnet_id" {}
variable "default_route_table_id" {}

variable "region" {
  default = "us-east-1"
}

variable "access_key" {
  default = "AKIAXGY2MYY3JV4FAOHE"
}

variable "secret_key" {
  default = "9jrszSFkT0S3d5hxkrREr/wywY23Yum5zvvuUIsw"
} 

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "env_prefix" {
  default = "dev"
}

variable "subnet_cidr_block" {
  default = "10.0.10.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
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