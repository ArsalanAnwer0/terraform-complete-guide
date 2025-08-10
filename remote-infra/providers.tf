# AWS Provider for Remote Infrastructure Setup
provider "aws" {
  region = "us-east-2"
  
  # Default tags for all resources in this configuration
  default_tags {
    tags = {
      Project   = "terraform-remote-state-setup"
      ManagedBy = "Terraform"
    }
  }
}