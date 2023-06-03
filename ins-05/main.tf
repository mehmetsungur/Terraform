provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "tf-ami" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "tf-jenkins-server" {
  ami = data.aws_ami.tf-ami.id
  instance_type = "t2.micro"
  key_name = "ms"
  security_groups = ["jenkins-server-sg"]
  user_data = file("install-jenkins.sh")

  tags = {
    Name : "Jenkins Server"
  }
}

resource "aws_security_group" "tf-jenkins-sec-gr" {
  name = "jenkins-server-sg"

  tags = {
    Name : "jenkins-server-sec-group"
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    protocol = "tcp"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "jenkins" {
  value = "http://${aws_instance.tf-jenkins-server.public_ip}:8080"
}

output "admin" {
  value = "cat /var/lib/jenkins/secrets/initialAdminPassword"
}