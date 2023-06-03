provider "aws" {
  region = "us-east-1"
  access_key="AKIAXGY2MYY3NMNGOFHI"
  secret_key="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"
}

resource "aws_vpc" "ins_01" {
  cidr_block = "10.0.0.0/16"
    tags = { 
        Name:"development"
        vpc = "dev"
    }
}

resource "aws_subnet" "ins_01_01" {
  vpc_id = aws_vpc.ins_01.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = { 
        Name = "dev-subnet-1"
    }
}

resource "aws_s3_bucket" "ins_01_01_s3_01" {
  bucket = "${var.s3-bucket-name}-${count.index}"
  acl="private"
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
        Name:"subnet-2-default"
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