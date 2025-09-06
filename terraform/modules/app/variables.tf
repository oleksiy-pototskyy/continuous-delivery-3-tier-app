variable "aws_region" {
  description = "Default region to deploy infrastructure"
}

variable "vpc_id" {
  description = "AWS VPC ID which was created for the project"
}

variable "vpc_public_subnets" {
  description = "List of AWS VPC Database Subnets to deploy Application Load Balancer"
  type = list(string)
}

variable "vpc_private_subnets" {
  description = "List of AWS VPC Database Subnets to deploy Application Load Balancer"
  type = list(string)
}

variable "app_name" {
  description = "Name of the Project"
}

variable "mandatory_tags" {
  type = map(string)
  description = "Mandatory TAGs for all AWS resources"
}

variable "ssl_certificate_arn" {
  description = "SSL certificate ARN to be used for ALB"
}

variable "db_secret_arn" {
  description = "ARN of the database secret in AWS Secrets Manager"
  type        = string
}
