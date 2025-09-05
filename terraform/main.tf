data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = var.app_name
  azs = slice(data.aws_availability_zones.available.names, 0, var.vpc_azs)

  cidr = var.vpc_cidr
  public_subnets = [
    for index in range(0, var.vpc_azs, 1):
      cidrsubnet(var.vpc_cidr, 8, index)
  ]
  private_subnets = [
    for index in range(10, 10 + var.vpc_azs, 1):
      cidrsubnet(var.vpc_cidr, 8, index)
  ]
  database_subnets = [
    for index in range(20, 20 + var.vpc_azs, 1):
      cidrsubnet(var.vpc_cidr, 8, index)
  ]

  enable_dns_hostnames  = true
  enable_dns_support    = true

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = merge(
    tomap({"Name" = var.app_name}),
    var.mandatory_tags
  )
}

# module "db" {
#   source = "./modules/db"
#
#   aws_vpc_id = module.vpc.vpc_id
#   aws_vpc_db_subnets = module.vpc.database_subnets
#   aws_db_type = var.aws_db_type
#   aws_db_name = var.aws_db_name
#   mandatory_tags = var.mandatory_tags
# }







