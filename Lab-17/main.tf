#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Execute Commands on Local Terraform Server
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

resource "null_resource" "command1" {
    provisioner "local-exec" {
        command = "echo Terraform START: $(date) >> log.txt"   
    }
}

resource "null_resource" "command2" {
    provisioner "local-exec" {
        command = "ping -c 5 google.com"
    }
}

resource "null_resource" "command3" {
    provisioner "local-exec" {
        interpreter = ["python", "-c"]
        command = "print('Hello Wrold from Python')"
    }
}

resource "null_resource" "command4" {
    provisioner "local-exec" {
        command = "echo $NAME1 $NAME2 $NAME3 $NAME4"
        environment = {
          NAME1 = "Mhinkyu"
          NAME2 = "Yossi"
          NAME3 = "MJ"
          NAME4 = "Peter"
         }
    }
}

resource "aws_instance" "myserver" {
  ami           = "ami-0c9bfc21ac5bf10eb"
  instance_type = "t3.nano"

  provisioner "local-exec" {
    command = "echo ${aws_instance.myserver.private_ip} >> log.txt"
  }
}

resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo Terraform FINISH: $(date) >> log.txt"
  }
  depends_on = [
    null_resource.command1,
    null_resource.command2,
    null_resource.command3,
    null_resource.command4,
    aws_instance.myserver
  ]
}
