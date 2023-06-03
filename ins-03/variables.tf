variable "aws_access" {
  description = "object tfvars"

  type = list(object({
    region = string
  }))
}

variable "vpc_viennalife" {
  description = "object tfvars"

  type = list(object({
    subnet_cidr_block = string
    availability_zone = string
    env_prefix = string
    vpc_cidr_block = string
    key_name = string
  }))
}

variable "route_table_viennalife" {
  description = "object tfvars"

  type = list(object({
    cidr_block = string
  }))
}

variable "rtb_association_viennalife" {
  description = "object tfvars"

  type = list(object({

  }))
}

variable "default_route_table_viennalife" {
  description = "object tfvars"

  type = list(object({
    cidr_block = string
  }))
}

variable "sg_viennalife" {
  description = "object tfvars"

  type = list(object({
    name = string
    ip = string
    protocol = string
  }))
}

variable "default_sg_viennalife" {
  description = "object tfvars"

  type = list(object({
    name = string
    ip = string
    protocol = string
  }))
}

variable "latest" {
  description = "object tfvars"

  type = list(object({
    owners = string
    name = string
    values = string
  }))
}

variable "instance_type" {
  description = "object tfvars"

  type = list(object({
    name = string
  }))
}