#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Deploy in Multiply AWS Regions
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

provider "aws" {
    region = "ap-northeast-1"
    alias = "Asia"
}

provider "aws" {
    region = "eu-south-1"
    alias = "Europe"
}

data "aws_ami" "default_latest_ubuntu20" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

data "aws_ami" "Europe_latest_ubunto20" {
    provider = aws.Europe
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}

data "aws_ami" "Asia_latest_ubunto20" {
    provider = aws.Asia
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}


resource "aws_instance" "my_defualt_server" {
    instance_type = "t3.micro"
    ami = data.aws_ami.default_latest_ubuntu20.id
    tags = {
        Name = "Default Server"
    }
}

resource "aws_instance" "my_europe_server" {
    provider = aws.Europe
    instance_type = "t3.micro"
    ami = data.aws_ami.Europe_latest_ubunto20.id
    tags = {
      Name = "Europe Server"
    }
}

resource "aws_instance" "my_asia_server" {
    provider = aws.Asia
    instance_type = "t3.micro"
    ami = data.aws_ami.Asia_latest_ubunto20.id
    tags = {
      Name = "Asia Server"
    }

}