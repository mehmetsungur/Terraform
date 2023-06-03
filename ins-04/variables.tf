variable "aws_region" {}

variable "vpc_cidr_block" {}

variable "availability_zones" {
    type = list(string)
}

variable "az_public_subnet" {
    type = map(string)
}

variable "az_private_subnet" {
    type = map(string)
}

variable "az_database_subnet" {
    type = map(string)
}