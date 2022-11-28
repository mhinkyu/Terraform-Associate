#---------------------------------
# My Terraform
# Build WebServer during Bootstrap with External TEMPLATE File
#
# Made by Mhinkyu Kim
#---------------------------------

provider "aws" {
    region = "us-west-2"
}
resource "aws_default_vpc" "default" {}

resource "aws_instance" "web-3" {
    ami = "ami-094125af156557ca2"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-09f67b66fd2c5a337"]
    key_name = "vockey"
    user_data = templatefile("user_data.tftpl", {
        f_name = "Mhinkyu"
        l_name = "Kim"
        names = ["John", "Angel", "David", "Victor", "Frank", "Melissa", "Kitana"]
    })

    tags = {
        Name = "Webserver-3"
        Owner = "Mhinkyu Kim"
    }
}

# resource "aws_security_group" "web" {
#     name = "Webserver-SG"
#     description = "Security Group for my webserver"
#     vpc_id = aws_default_vpc.default.id

#     ingress {
#         description = "Allow port HTTP"
#         from_port = 80
#         to_port = 80
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     ingress {
#         description = "Allow port HTTPS"
#         from_port = 443
#         to_port = 443
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     ingress {
#         description = "SSH Connection"
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["77.137.77.35/32"]
#     }
#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     tags = {
#         Name = "Webserver build by Terraform"
#         Owner = "Mhinkyu Kim"
#     }
# }