provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "my_ubuntu" {
    ami = "ami-017fecd1353bcc96e"
    instance_type = "t3.micro"
    key_name = "vockey"

    tags = {
    Name = "My-Ubuntu-Server"
    Owner = "Mhinkyu Kim"
    }
}

# resource "aws_instance" "my_amazon" {
#     ami = "ami-094125af156557ca2"
#     instance_type = "t3.micro"

#     tags = {
#         Name = "My-Amazon-Server"
#         Owner = "Mhinkyu Kim"
#     }
# }