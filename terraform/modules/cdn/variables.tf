variable "app_name" {
  description = "Name of the Project"
}

variable "domain_name" {
  description = "Domain name which will be used for AWS resources, e.g. youdomain.com"
}

variable "web_alb_dns_name" {
  description = "DNS name of the web application load balancer"
  type        = string
}

variable "api_alb_dns_name" {
  description = "DNS name of the API application load balancer"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "ARN of the SSL certificate for the domains"
  type        = string
}

variable "mandatory_tags" {
  type = map(string)
  description = "Mandatory TAGs for all AWS resources"
}

variable "domain_zone_id" {
  description = "Zone ID"
}

