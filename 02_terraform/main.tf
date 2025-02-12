
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.1"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  filename = "./keypair/${var.key_name}.pem"
  key_name = var.key_name

}

module "keypair" {
  source   = "./modules/keypair"
  filename = local.filename
  key_name = local.key_name
}

module "security_group" {
  source              = "./modules/sg"
  security_group_name = var.security_group_name
  sg_ports            = var.sg_ports
}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["*ubuntu-noble-24.04-amd64-server-*"]
  }
}

module "ec2" {
  source              = "./modules/ec2"
  ami                 = data.aws_ami.ubuntu.id
  instance_type       = var.instance_type
  username            = var.username
  private_key_path    = local.filename
  security_group_name = module.security_group.sg_name
  key_name            = local.key_name
}