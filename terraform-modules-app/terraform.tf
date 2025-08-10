# Terraform configuration for modular application infrastructure
terraform {
  # Specify minimum Terraform version for consistency
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.7.0"
    }
  }
  
  # Note: This root module orchestrates multiple environments (dev, stg, prd)
  # using the ./infra-app child module
}