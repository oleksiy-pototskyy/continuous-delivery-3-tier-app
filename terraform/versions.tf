terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.12"
    }
  }

  required_version = "1.13.1"
  backend "s3" {
    dynamodb_table = "3tier-app-state-lock"
  }
}

provider "aws" {
  region = var.aws_region
}
