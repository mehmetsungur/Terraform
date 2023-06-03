resource "aws_security_group" "sg_viennalife" {
  name = var.name
  vpc_id = var.vpc_id

  # INCOMING RULES
  ingress {
    from_port = 22
    to_port = 22
    protocol = var.protocol
    cidr_blocks = [var.subnet_cidr_block]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = var.protocol
    cidr_blocks = [var.subnet_cidr_block]
  }

  # OUTGOING RULES
  egress {
    from_port = 0
    to_port = 0
    protocol = var.protocol
    cidr_blocks = [var.subnet_cidr_block]
  }

  tags = {
    Name : "sg-${var.env_prefix}"
  }
}

resource "aws_default_security_group" "default_sg_viennalife" {
  vpc_id = var.vpc_id

  # INCOMING RULES
  ingress {
    from_port = 22
    to_port = 22
    protocol = var.protocol
    cidr_blocks = [var.subnet_cidr_block]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = var.protocol
    cidr_blocks = [var.subnet_cidr_block]
  }

  # OUTGOING RULES
  egress {
    from_port = 0
    to_port = 0
    protocol = var.protocol
    cidr_blocks = [var.subnet_cidr_block]
  }

  tags = {
    Name : "default-sg-${var.env_prefix}"
  }
}

data "aws_ami" "latest" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [var.image_name]
  }
}

resource "aws_instance" "instance_type" {
  ami = data.aws_ami.latest.id
  instance_type = var.instance_type

  subnet_id = var.subnet_id
  availability_zone = var.availability_zone

  #IP Adreslerine Browserdan Erişmek
  associate_public_ip_address = true

  key_name = "mehmetsungur"

  user_data = file("entry-script.sh")
  tags = {
    Name : "server-${var.env_prefix}"
  }
}