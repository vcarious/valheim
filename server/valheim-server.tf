terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.22.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "valheim-restore" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.large"
  key_name      = "valheim_key_restore"
  #TODO: add init.sh to user_data for automated install
  #user_data     = templatefile("init.tpl", {})

}

resource "aws_security_group" "steam_traffic_restore" {
  name        = "steam_traffic_restore"
  description = "Allows steam and ssh access"

  ingress {
    from_port   = 2456
    to_port     = 2458
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2456
    to_port     = 2458
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.steam_traffic_restore.id
  network_interface_id = aws_instance.valheim-restore.primary_network_interface_id
}
