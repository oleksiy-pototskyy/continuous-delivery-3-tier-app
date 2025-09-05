terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.12"
    }
  }

  required_version = "1.13.1"
  backend "s3" { }
}

provider "aws" {
  region = var.aws_region
}
