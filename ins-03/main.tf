provider "aws" {
  region = var.aws_access[0].region
}

resource "aws_vpc" "vpc_viennalife" {
  cidr_block = var.vpc_viennalife[0].vpc_cidr_block

  tags = {
      Name : "vpc-${var.vpc_viennalife[0].env_prefix}"
  }
}

resource "aws_subnet" "subnet_viennalife" {
  vpc_id = aws_vpc.vpc_viennalife.id

  cidr_block = var.vpc_viennalife[0].subnet_cidr_block
  availability_zone = var.vpc_viennalife[0].availability_zone

  tags = {
      Name : "subnet-01-${var.vpc_viennalife[0].env_prefix}"
  }
}

# resource "aws_route_table" "route_table_viennalife" {
#   vpc_id = aws_vpc.vpc_viennalife.id

#   route {
#     cidr_block = var.route_table_viennalife[0].cidr_block
#     gateway_id = aws_internet_gateway.igw_viennalife.id
#   }

#   tags = {
#       Name : "rtb-${var.vpc_viennalife[0].env_prefix}"
#   }
# }

resource "aws_internet_gateway" "igw_viennalife" {
  vpc_id = aws_vpc.vpc_viennalife.id
  
  tags = {
      Name : "igw-${var.vpc_viennalife[0].env_prefix}"
  }
}

# resource "aws_route_table_association" "rtb_association_viennalife" {
#   subnet_id = aws_subnet.subnet_viennalife.id
#   route_table_id = aws_route_table.route_table_viennalife.id
# }

resource "aws_default_route_table" "default_route_table_viennalife" {
  default_route_table_id = aws_vpc.vpc_viennalife.default_route_table_id

  route {
    cidr_block = var.default_route_table_viennalife[0].cidr_block
    gateway_id = aws_internet_gateway.igw_viennalife.id
  }

  tags = {
    Name : "drtb-${var.vpc_viennalife[0].env_prefix}"
  }
}

resource "aws_security_group" "sg_viennalife" {
  name = var.sg_viennalife[0].name
  vpc_id = aws_vpc.vpc_viennalife.id

  # INCOMING RULES
  ingress {
    from_port = 22
    to_port = 22
    protocol = var.sg_viennalife[0].protocol
    cidr_blocks = [var.sg_viennalife[0].ip]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = var.sg_viennalife[1].protocol
    cidr_blocks = [var.sg_viennalife[1].ip]
  }

  # OUTGOING RULES
  egress {
    from_port = 0
    to_port = 0
    protocol = var.sg_viennalife[2].protocol
    cidr_blocks = [var.sg_viennalife[2].ip]
  }

  tags = {
    Name : "sg-${var.vpc_viennalife[0].env_prefix}"
  }
}

resource "aws_default_security_group" "default_sg_viennalife" {
  vpc_id = aws_vpc.vpc_viennalife.id

  # INCOMING RULES
  ingress {
    from_port = 22
    to_port = 22
    protocol = var.default_sg_viennalife[0].protocol
    cidr_blocks = [var.default_sg_viennalife[0].ip]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = var.default_sg_viennalife[1].protocol
    cidr_blocks = [var.default_sg_viennalife[1].ip]
  }

  # OUTGOING RULES
  egress {
    from_port = 0
    to_port = 0
    protocol = var.default_sg_viennalife[2].protocol
    cidr_blocks = [var.default_sg_viennalife[2].ip]
  }

  tags = {
    Name : "default-sg-${var.vpc_viennalife[0].env_prefix}"
  }
}

data "aws_ami" "latest" {
  most_recent = true
  owners = [var.latest[0].owners]

  filter {
    name = var.latest[0].name
    values = [var.latest[0].values]
  }
}

resource "aws_instance" "instance_type" {
  ami = data.aws_ami.latest.id
  instance_type = var.instance_type[0].name

  subnet_id = aws_subnet.subnet_viennalife.id
  availability_zone = var.vpc_viennalife[0].availability_zone

  #IP Adreslerine Browserdan Erişmek
  associate_public_ip_address = true

  key_name = var.vpc_viennalife[0].key_name

  user_data = file("entry-script.sh")
  tags = {
    Name : "server-${var.vpc_viennalife[0].env_prefix}"
  }
}

output "ec2_public_ip" {
  value = aws_instance.instance_type.public_ip
}

output "aws_ami_id" {
  value = data.aws_ami.latest.id
}

output "igw_id" {
  value = aws_internet_gateway.igw_viennalife.id
}

# output "rtb-id" {
#   value = aws_route_table.route_table_viennalife.id
# }

output "drtb_id" {
  value = aws_vpc.vpc_viennalife.default_route_table_id
}

output "subnet_id" {
  value = aws_subnet.subnet_viennalife.id
}

output "vpc_id" {
  value = aws_vpc.vpc_viennalife.id
}