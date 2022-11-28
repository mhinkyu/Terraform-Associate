#---------------------------------
# My Terraform
# Build WebServer during bootstrap
#
# Made by Mhinkyu Kim
#---------------------------------

provider "aws" {
    region = "us-west-2"
}
resource "aws_default_vpc" "default" {}

resource "aws_instance" "web-2" {
    ami = "ami-094125af156557ca2"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.web-1.id]
    key_name = "vockey"
    user_data = file("user_data.sh")

tags = {
    Name = "Webserver-2"
    Owner = "Mhinkyu Kim"
}
}

resource "aws_security_group" "web-1" {
    name = "Webserver-SG1"
    description = "Security Group for my webserver"
    vpc_id = aws_default_vpc.default.id

    ingress {
        description = "Allow port HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow port HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
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