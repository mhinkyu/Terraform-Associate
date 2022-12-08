#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Execute Commands on Remote Server
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

resource "aws_default_vpc" "default" {}

resource "aws_instance" "myserver" {
    ami = "ami-094125af156557ca2"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.web.id]
    key_name = "vockey"
    tags = {
      Name = "My EC2 with remote-exec"
      Owner = "Mhinyu Kim"
    }   


    provisioner "remote-exec" {
        inline = [
            "mkdir /home/ec2-user/terraform",
            "cd /home/ec2-user/terraform",
            "touch hello.txt",
            "echo 'Terraform was here...' > terraform.txt"
        ]
        connection {
            type = "ssh"
            user = "ec2-user"
            host = self.public_ip
            private_key = file("labsuser.pem")
        }
    }
}

resource "aws_security_group" "web" {
  name   = "My-SecurityGroup"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "SG by Terraform"
    Owner = "Mhinkyu Kim"
  }
}