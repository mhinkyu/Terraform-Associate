variable "aws_region" {
    description = "Region where you want to provision with EC2 Webserver"
    type = string 
    default = "us-west-2"
}

variable "port_list" {
    description = "List of ports to open for out Webserver"
    type = list(any)
    default = ["80", "443"]
}

variable "instance_size" {
    description = "EC2 instace size to provision"
    type = string
    default = "t3.micro"
}

variable "tags" {
    description = "Tags to Apply to Resources"
    type = map(any)
    default = {
      Owner = "Mhinkyu Kim"
      Encironment = "Prod"
      Project = "Phoenix" 
    }
}

variable "key_pair" {
    description = "SSH Key pair name to ingest into EC2"
    type = string
    default = "vockey"
    sensitive = true
}

variable "password" {
    description = "Please eneter password length of 10 characters!"
    type = string
    sensitive = true
    validation {
        condition = length(var.password) == 10
        error_message = "Your password must be 10 characted exactly"
    }
}