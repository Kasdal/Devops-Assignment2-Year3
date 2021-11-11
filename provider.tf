# Terraform Block
terraform {
  required_version = "~> 1.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }    
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }            
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

# Create Random Pet Resource just for fun :D this will be used to generate a random pet name of a resource
resource "random_pet" "this" {
  length = 2
}