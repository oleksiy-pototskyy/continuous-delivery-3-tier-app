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

module "domain" {
  source = "./modules/domain"

  app_name = var.app_name
  domain_name = var.domain_name
  mandatory_tags = var.mandatory_tags
}

module "app" {
  source = "./modules/app"
  aws_region = var.aws_region
  vpc_id = module.vpc.vpc_id
  vpc_public_subnets = module.vpc.public_subnets
  vpc_private_subnets = module.vpc.private_subnets
  app_name = var.app_name
  mandatory_tags = var.mandatory_tags
  ssl_certificate_arn = module.domain.ssl_certificate_arn
  db_secret_arn = module.db.db_secret_arn
}

module "db" {
  source = "./modules/db"

  vpc_id = module.vpc.vpc_id
  vpc_db_subnets = module.vpc.database_subnets
  db_name = var.db_name
  mandatory_tags = var.mandatory_tags
  app_name = var.app_name
  sg_api_id = module.app.sg_api_ecs_tasks
}

module "cdn" {
  source = "./modules/cdn"

  app_name = var.app_name
  domain_name = var.domain_name
  mandatory_tags = var.mandatory_tags
  web_alb_dns_name = module.app.web_alb_dns_name
  api_alb_dns_name = module.app.api_alb_dns_name
  domain_zone_id = module.domain.domain_zone_id
  ssl_certificate_arn = module.domain.ssl_certificate_arn
}

