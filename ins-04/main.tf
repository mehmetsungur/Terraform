provider "aws" {
  region = "us-east-1"
  access_key = "AKIAXGY2MYY3JV4FAOHE"
  secret_key = "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"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name : "viennalife-vpc"
  } 
}

resource "aws_internet_gateway" "igw_viennalife" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name : "viennalife-igw"
  } 
}

resource "aws_subnet" "public_subnet_viennalife" {
  for_each = var.az_public_subnet
  vpc_id = aws_vpc.main.id
  availability_zone = each.key
  cidr_block = each.value

  tags = {
    Name : "viennalife-public-subnet-${each.key}"
  } 
}

resource "aws_subnet" "private_subnet_viennalife" {
  for_each = var.az_private_subnet
  vpc_id = aws_vpc.main.id
  availability_zone = each.key
  cidr_block = each.value

  tags = {
    Name : "viennalife-private-subnet-${each.key}"
  } 
}

resource "aws_subnet" "database_subnet_viennalife" {
  for_each = var.az_database_subnet
  vpc_id = aws_vpc.main.id
  availability_zone = each.key
  cidr_block = each.value

  tags = {
    Name : "viennalife-database-subnet-${each.key}"
  } 
}

resource "aws_route_table" "rtb_public_subnet_viennalife" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_viennalife.id
  }

  tags = {
    Name : "public-subnet-route-table"
  }
}

resource "aws_route_table_association" "rtb_asc_public_subnet_viennalife" {
  for_each = var.az_public_subnet
  subnet_id = aws_subnet.public_subnet_viennalife[each.key].id
  route_table_id = aws_route_table.rtb_public_subnet_viennalife.id
}