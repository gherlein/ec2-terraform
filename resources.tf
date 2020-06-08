provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical

}


resource "aws_security_group" "sg" {
  name = "ssh-allow"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "type" = "ssh-allow-security-group"
  }

}

resource "aws_key_pair" "ssh-gw-key" {
  key_name   = "ssh-gw-key"
  public_key = file("./ssh-gw.pub")
}

resource "aws_instance" "ssh-gw" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg.name]
  key_name        = "ssh-gw-key"
  user_data       = file("./boot.sh")
  tags = {
    Name = "HelloWorld"
  }
}

output "ip_address" {
  value = aws_instance.ssh-gw.public_ip
}

