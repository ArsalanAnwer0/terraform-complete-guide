# Root module that calls the infra app child module for different environments

# Dev Infrastructure
module "dev-infra" {
  source = "./infra-app"
  
  env            = "dev"
  bucket_name    = "arsalan-infra-app-dev-bucket"    
  instance_count = 1
  instance_type  = "t2.micro"
  ec2_ami_id     = "ami-0d1b5a8c13042c939" # Ubuntu 
  hash_key       = "studentID"
}

# Production Infrastructure
module "prd-infra" {
  source = "./infra-app"
  
  env            = "prd"
  bucket_name    = "arsalan-infra-app-prd-bucket"    
  instance_count = 2
  instance_type  = "t2.medium"
  ec2_ami_id     = "ami-0d1b5a8c13042c939" # Ubuntu
  hash_key       = "studentID"
}

# Staging Infrastructure
module "stg-infra" {
  source = "./infra-app"
  
  env            = "stg"
  bucket_name    = "arsalan-infra-app-stg-bucket"    
  instance_count = 1
  instance_type  = "t2.small"
  ec2_ami_id     = "ami-0d1b5a8c13042c939" # Ubuntu 20.04 LTS
  hash_key       = "studentID"
}