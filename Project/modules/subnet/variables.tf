variable "env_prefix" {
  default = "dev"
}

variable "subnet_cidr_block" {
  default = "10.0.10.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "vpc_id" {}
variable "default_route_table_id" {}