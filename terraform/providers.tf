terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.72"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = region

  default_tags {
    tags = {
      Environment = "Terraria"
      Repository  = var.repository_name
      Terraform   = "True"
      Project     = var.project_name
    }
  }
}