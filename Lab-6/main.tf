#---------------------------------
# My Terraform
# Build WebServer during Bootstrap with STATIC IP
#
# Made by Mhinkyu Kim
#---------------------------------

provider "aws" {
    region = "us-west-2"
}
resource "aws_default_vpc" "default" {}

resource "aws_eip" "web" {
    vpc = true
    instance = aws_instance.web-EIP.id
    tags = {
        Name = "EIP for WebServer"
        Owner = "Mhinkyu Kim"
    }
}

resource "aws_instance" "web-EIP" {
    ami = "ami-094125af156557ca2"
    instance_type = "t3.micro"
    vpc_security_group_ids = ["sg-09f67b66fd2c5a337"]
    key_name = "vockey"
    user_data = templatefile("user_data.tftpl", {
        f_name = "Mhinkyu"
        l_name = "Kim"
        names = ["John", "Angel", "David", "Victor", "Frank", "Melissa", "Kitana"]
    })
    user_data_replace_on_change = true

    tags = {
        Name = "Webserver-EIP"
        Owner = "Mhinkyu Kim"
    }
    
    lifecycle {
      create_before_destroy = true 
    }
}
