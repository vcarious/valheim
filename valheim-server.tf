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

resource "aws_instance" "valheim" {
  ami           = "ami-03d315ad33b9d49c4"
  instance_type = "t2.large"
  key_name = "valheim_key"
 
}

resource "aws_security_group" "steam_traffic" {
  name        = "steam_traffic"
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
  security_group_id    = aws_security_group.steam_traffic.id
  network_interface_id = aws_instance.valheim.primary_network_interface_id
}
