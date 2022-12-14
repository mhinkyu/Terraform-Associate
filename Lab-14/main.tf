#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Use Variables and Multiply files
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = var.aws_region
}

data "aws_ami" "latest_amazon_linux" {
    owners = ["137112412989"]
    most_recent = true 
    filter {
      name = "name"
      values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }
}

resource "aws_default_vpc" "default" {}

resource "aws_eip" "web" {
    vpc = true
    instance = aws_instance.web.id
    tags = merge(var.tags, { Name = "${var.tags["Environment"]}-EIP for WebServer built by Terraform"})
}

resource "aws_instance" "web" {
    ami = data.aws_ami.latest_amazon_linux.id
    instance_type = var.instance_size
    vpc_security_group_ids = [aws_security_group.web.id]
    key_name = var.key_pair
    tags = merge(var.tags, { Name = "${var.tags["Environment"]}-Webserver built by Terraform"})

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_security_group" "web" {
    name = "${var.tags["Environment"]} Webserver"
    description = "Security Group for my ${var.tags["Environment"]} Webserver"
    vpc_id = aws_default_vpc.default.id

    dynamic "ingress" {
        for_each = var.port_list
        content {
          from_port = ingress.value
          to_port = ingress.value
          protocol = "tcp"
          cidr_block = ["0.0.0.0/0"]
        }
    }

    egress {
        description = "allow all ports"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(var.tags, { Name = "${var.tags["Environment"]}-Webserver SG by Terraform"})
}