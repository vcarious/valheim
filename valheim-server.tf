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
  provisioner "remote-exec" {
      inline = [
        "sudo useradd -m steam"
        "cd /home/steam"

        "sudo apt update && sudo apt upgrade -y"
        "sudo dpkg --add-architecture i386"
        "sudo apt update -y"
        "sudo apt install lib32gcc1 steamcmd -y"

        "su steam"
        "steamcmd +login anonymous +force_install_dir /home/steam/valheim +app_update 896660 +quit -y"

        "export templdpath=$LD_LIBRARY_PATH"
        "export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH"
        "export SteamAppId=892970"
        "echo "Starting server PRESS CTRL-C to exit""
        "./valheim_server.x86_64 -name "BucBucGo" -port 2456 -world "bbg1" -password "thecan123""
        "export LD_LIBRARY_PATH=$templdpath"
        ]
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
