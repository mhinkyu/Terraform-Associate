#------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Generate, Store and Retrieve Password Using AWS Secrets Manager
#
# Made by Mhinkyu Kim
#------------------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

resource "aws_db_instance" "prod_MK" {
    identifier = "prod-mysql-rds"
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t3.micro"
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
    apply_immediately = true
    username = "administrator"
    password = random_password.main.result    
}

resource "random_password" "main" {
    length = 20
    special = true
    override_special = "#!()@"
}

#--------
output "rds_address" {
    value = aws_db_instance.prod_MK.address
}

output "rds_port" {
    value = aws_db_instance.prod_MK.port
}

output "rds_username" {
    value = aws_db_instance.prod_MK.username
}

output "rds_password" {
    value = random_password.main.result
    sensitive = true
}