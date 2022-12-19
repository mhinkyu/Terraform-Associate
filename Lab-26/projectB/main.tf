#-------------------------------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Provision VPC and Web Servers in Public Subnets using Modules
#
# Made by Mhinkyu Kim
#-------------------------------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

module "vpc_prod" {
    source = "../modules/network"
    # source = ""
    env = "prod"
    vpc_cidr = "10.200.0.0/16"
    public_subnet_cidrs = ["10.200.1.0/24", "10.200.2.0/24", "10.200.3.0/24"]
    private_subnet_cidrs = ["10.200.11.0/24", "10.200.22.0/24", "10.200.33.0/24"]
    tags = {
      Owner = "Mhinkyu Kim"
      Code  = "23455563"
      Project = "TerraformProject"
    } 
}

module "server_standalone" {
    source = "../modules/testserver"
    # source = 
    name = "MKV-IT"
    message = "Stand Alone Server"
    subnet_id = module.vpc_prod.public_subnet_ids[2]
}

module "servers_loop_count" {
    source = "../modules/testserver"
    # source
    count = length(module.vpc_prod.public_subnet_ids)
    name = "MKV-IT"
    message = "Hello From sever in Subnet ${module.vpc_prod.public_subnet_ids[count.index]} created by count loop"
    subnet_id = module.vpc_prod.public_subnet_ids[count.index]
}

module "servers_loops_for_each" {
    source = "../modules/testserver"
    # source
    for_each = toset(module.vpc_prod.public_subnet_ids)
    name = "MKV-IT"
    message = "Hello From server in subnet ${each.value} created by FOR_EACH loop"
    subnet_id = each.value
    depends_on = [module.servers_loop_count]
}