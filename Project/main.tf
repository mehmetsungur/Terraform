provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "vpc_viennalife" {
  cidr_block = var.vpc_cidr_block

  tags = {
      Name : "vpc-${var.env_prefix}"
  }
}

module "subnet_viennalife" {
  source = "./modules/subnet"

  # Terraform main.tf den alınıp modules/subnet altında yapılan değişkenler
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  env_prefix = var.env_prefix

  #Yeni oluşturulan değişkenler
  vpc_id = aws_vpc.vpc_viennalife.id
  default_route_table_id = aws_vpc.vpc_viennalife.default_route_table_id
}

module "webserver_viennalife" {
  source = "./modules/webserver"

  # Terraform main.tf den alınıp modules/subnet altında yapılan değişkenler
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  env_prefix = var.env_prefix
  protocol = var.protocol
  name = var.name
  image_name = var.image_name
  instance_type = var.instance_type

  #Yeni oluşturulan değişkenler
  vpc_id = aws_vpc.vpc_viennalife.id
  subnet_id = module.subnet_viennalife.subnet.id
}