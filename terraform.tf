terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.7.0"
    }
  }
   backend "s3" {
    bucket = "arsalan-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "arsalan-state-table"
  
}
}

