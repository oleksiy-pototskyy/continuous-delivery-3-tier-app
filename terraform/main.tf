data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "3tier-app"
  azs = slice(data.aws_availability_zones.available.names, 0, var.aws_vpc_azs)

  cidr = var.aws_vpc_cidr
  public_subnets = [
    for index in range(100, 100 + var.aws_vpc_azs, 1):
      cidrsubnet(var.aws_vpc_cidr, 8, index)
  ]
  private_subnets = cidrsubnets(var.aws_vpc_cidr, 8, 8)
  database_subnets = var.aws_vpc_db_subnets

  enable_dns_hostnames  = true
  enable_dns_support    = true

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  tags = merge(
    tomap({"Name" = "VPC 3 Tier App"}),
    var.mandatory_tags
  )
}

module "db" {
  source = "./modules/db"

  aws_vpc_id = module.vpc.vpc_id
  aws_vpc_db_subnets = module.vpc.database_subnets
  aws_db_type = var.aws_db_type
  aws_db_name = var.aws_db_name
  mandatory_tags = var.mandatory_tags
}







