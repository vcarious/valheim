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
  provisioner "file" {
    source = "start_server.sh"
    destination = "/home/steam/valheim/start_server.sh"
  }
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
