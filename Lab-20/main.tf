#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Loop Construct: count = x
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

resource "aws_instace" "servers" {
    count = 4
    ami = "ami-0e472933a1395e172"
    instance_type = "t3.micro"
    tags = {
    Name = "Server Number ${count.index + 1}"
    Owner = "Mhinkyu Kim"
    }
}

resource "aws_iam_user" "user" {
    count = length(var.aws_users)
    name = element(var.aws_usersm, count.index)
}

resource "aws_instance" "bastion_server" {
    count = var.create_bastion == "Yes" ? 1 : 0
    ami = "ami-0e472933a1395e172"
    instance_type = "t3.micro"
    tags = {
      Name = "Bastion Server"
      Owner = "Mhinkyu Kim"
    }
}