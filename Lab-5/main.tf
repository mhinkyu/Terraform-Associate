#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Use Dynamic Blocks
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}
resource "aws_default_vpc" "default" {}


resource "aws_security_group" "web-2" {
    name = "Dynamic-Blocks-SG"
    description = "Security Group built by Dynamic Blocks"
    vpc_id = aws_default_vpc.default.id

    dynamic "ingress" {
        for_each = ["80", "8080", "443", "1000", "8443"]
        content {
            description = "Allow port HTTP"
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    dynamic "ingress" {
        for_each = ["8000", "9000", "7000"]
        content {
            description = "Allow port UDP"
            from_port = ingress.value
            to_port = ingress.value
            protocol = "udp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    ingress {
        description = "SSH Connection"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["77.137.77.35/32"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Webserver build by Terraform"
        Owner = "Mhinkyu Kim"
    }
}