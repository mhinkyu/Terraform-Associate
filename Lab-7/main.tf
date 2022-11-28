#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Implicit dependency - by reference another resource attribute
# Explicit dependency - by specify depend_on = []
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

resource "aws_default_vpc" "deafult" {}

resource "aws_instance" "web_server" {
    ami = "ami-094125af156557ca2"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-09f67b66fd2c5a337"]
    tags = { Name = "Web-Server"}

    depends_on = [
        aws_instance.db_server,
        aws_instance.app_server
    ]   
}
resource "aws_instance" "app_server" {
    ami = "ami-094125af156557ca2"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-09f67b66fd2c5a337"]
    tags = { Name = "App-Server"}

    depends_on = [
        aws_instance.db_server
    ]   
}

resource "aws_instance" "db_server" {
    ami = "ami-094125af156557ca2"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-09f67b66fd2c5a337"]
    tags = { Name = "DB-Server"}
}

# resource "aws_security_group" "Application" {
#   name   = "My Security Group"
#   vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id

#   dynamic "ingress" {
#     for_each = ["80", "443", "22", "3389"]
#     content {
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "My SecurityGroup"
#   }
# }