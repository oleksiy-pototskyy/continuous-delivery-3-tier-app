variable "aws_region" {
  description = "Default region to deploy infrastructure"
}

variable "vpc_cidr" {
  description = "AWS VPC CIDR block"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_azs" {
  type = number
  description = "Count of AWS Availability Zones to deploy infrastructure"
}

variable "app_name" {
  description = "Name of the Project"
}

variable "rds_type" {
  description = "Default type of AWS RDS"
}

variable "domain_name" {
  description = "Domain name which will be used for AWS resources, e.g. youdomain.com"
}

variable "mandatory_tags" {
  type = map(string)
  description = "Mandatory TAGs for all AWS resources"
}
