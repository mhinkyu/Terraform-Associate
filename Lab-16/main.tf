#----------------------------------------------------------
#  Terraform - From Zero to Certified Professional
#
# Local Variables
#
# Made by Mhinkyu Kim
#----------------------------------------------------------
provider "aws" {
    region = "us-west-2"
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}


locals {
  Region_fullname   = data.aws_region.current.description
  Number_of_AZs     = length(data.aws_availability_zones.available.names)
  Names_of_AZs      = join(",", data.aws_availability_zones.available.names)
  Full_project_name = "${var.project_name} running in ${local.Region_fullname}"
}

locals {
  Region_Info    = "This Resource is in ${data.aws_region.current.description} consist of ${length(data.aws_availability_zones.available.names)} AZs"
  Region_Info_v2 = "This Resource is in ${local.Region_fullname} consist of ${local.Number_of_AZs} AZs"
}

locals {
  tags_for_eip = {
    Environment  = var.environment
    Region_full  = local.Region_Info_v2
    Project_name = local.Full_project_name
  }
}

#------------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name           = "My VPC"
    Region_Info_v1 = local.Region_Info
    Region_Info_v2 = local.Region_Info_v2
    AZ_names       = local.Names_of_AZs
  }
}

resource "aws_eip" "my_static_ip" {
    vpc = ture
    tags = merge(var.tags, local.tags_for_eip, {
        Name = "My IP"
        Region_Info = local.Region_Info
    })   
}
