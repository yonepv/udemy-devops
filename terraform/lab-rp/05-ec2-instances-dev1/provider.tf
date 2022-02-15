terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.1"
    }
  }
  required_version = ">= 0.14.9"
}

#-------------------------------------------------------------------------------
# Configure the aws provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      system      = var.aws_application
      environment = var.aws_environment
    }
  }
}