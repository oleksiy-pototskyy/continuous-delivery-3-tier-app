variable "vpc_id" {
  description = "AWS VPC ID which was created for the project"
}

variable "vpc_db_subnets" {
  description = "List of AWS VPC Database Subnets to deploy Application Load Balancer"
  type = list(string)
}

variable "db_name" {
  description = "Default name of AWS RDS Postgresql"
}

variable "mandatory_tags" {
  type = map(string)
  description = "Mandatory TAGs for all AWS resources"
}

variable "app_name" {
  description = "Name of the Project"
}

variable "sg_api_id" {
  description = "ID of Application Security Group"
}
