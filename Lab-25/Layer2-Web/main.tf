#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Set S3 Backend for Terraform Remote State
# Get Outputs from another Terraform Remote State
# Deploy Web Layer
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

terraform {
    backend "s3" {
        bucket = "Terraform-remote-state-MK"
        key = "dev/webserver/terraform.tfstate"
        region = "us-west-2"
    }
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
      bucket = "Terraform-remote-state-MK"
      key = "dev/network/terraform.tfstate"
      region = "us-west-2"
     }
}


data "aws_ami" "latest_amazon_linux" {
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values  = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_instance" "web_server" {
    ami = data.aws_ami.latest_amazon_linux.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.webserver.id]
    subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
    user_data = file("user_data.sh")
    
    tags = {
      Name = "${var.env}-WebServer"
      Owner = "Mhinyu Kyu"
    }
}

resource "aws_security_group" "webserver" {
    name = "WebServer Security Group"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.env}-web-server-sg"
        Owner = "Mhinkyu Kim"
    }
}