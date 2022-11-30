provider "aws" {
    region = "us-west-2"
}

data "aws_ami" "latest_ubuntu22" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

data "aws_ami" "latest_amazon_linux" {
    owners = ["137112412989"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }
}

data "aws_ami" "latest_windowserver2019" {
    owners = ["801119661308"]
    most_recent = true
    filter {
      name = "name"
      values = ["Windows_Server-2019-English-Full-Base-*"]
    }
}

output "latest_ubuntu_ami_id" {
    value = data.aws_ami.latest_ubuntu22.id
}

output "latest_linux_ami_id" {
    value = data.aws_ami.latest_amazon_linux.id
}

output "latest_windows_ami_id" {
    value = data.aws_ami.latest_windowserver2019.id
}