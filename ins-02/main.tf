provider "aws" {
  region = var.region
  access_key=var.access_key
  secret_key=var.secret_key
}

resource "aws_vpc" "ins_01" {
  #cidr_block = var.vpc-cidr-block
  #cidr_block = var.list_cidr_blocks[0]
  cidr_block = var.obj_cidr_blocks[0].cidr_block
    tags = { 
        #Name : var.vpc_name
        Name : var.obj_cidr_blocks[0].name
    }
}

resource "aws_subnet" "ins_01_01" {
  vpc_id = aws_vpc.ins_01.id
  #cidr_block = var.subnet-cidr-block
  #cidr_block = var.list_cidr_blocks[1]
  cidr_block = var.obj_cidr_blocks[1].cidr_block
  availability_zone = var.availability_zone
  tags = { 
        #Name : var.subnet_name
        Name : var.obj_cidr_blocks[1].name
    }
}

resource "aws_s3_bucket" "ins_01_01_s3_01" {
  bucket = "${var.s3-bucket-name}-${count.index}"
  acl = var.acl
  count = var.var-counts
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}

data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2"{
    vpc_id = data.aws_vpc.existing-vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "us-east-1b"
    tags = { 
        Name : "subnet-2-default"
    }
}

output "uppercase" {
  value = [for user in var.users : upper(user) if length(user) > 5]
}

output "dev-vpc-id" {
  value = aws_vpc.ins_01.id
}

output "dev-subnet-id" {
  value = aws_subnet.ins_01_01.id
}