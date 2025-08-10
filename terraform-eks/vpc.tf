# VPC configuration for EKS cluster
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.name}-vpc"
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  
  # NAT Gateway for private subnet internet access
  enable_nat_gateway = true
  enable_vpn_gateway = true
  
  # DNS settings required for EKS
  enable_dns_hostnames = true
  enable_dns_support   = true

  # EKS-specific tags for subnet discovery
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    Name        = "${local.name}-vpc"
    Terraform   = "true"
    Environment = local.env
    # EKS cluster discovery tag
    "kubernetes.io/cluster/${local.name}" = "shared"
  }
}