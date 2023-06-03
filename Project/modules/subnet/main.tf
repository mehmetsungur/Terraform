resource "aws_subnet" "subnet_viennalife" {
  vpc_id = var.vpc_id

  cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone

  map_public_ip_on_launch = true

  tags = {
      Name : "subnet-01-${var.env_prefix}"
  }
}

resource "aws_internet_gateway" "igw_viennalife" {
  vpc_id = var.vpc_id
  
  tags = {
      Name : "igw-${var.env_prefix}"
  }
}

resource "aws_default_route_table" "default_route_table_viennalife" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_viennalife.id
  }

  tags = {
    Name : "drtb-${var.env_prefix}"
  }
}