variable "aws_vpc_id" {
  description = "AWS VPC ID which was created for the project"
}

variable "aws_vpc_private_subnets" {
  description = "List of AWS VPC Database Subnets to deploy Application Load Balancer"
  type = list(string)
}

variable "aws_vpc_public_subnets" {
  description = "List of AWS VPC Database Subnets to deploy Application Load Balancer"
  type = list(string)
}
