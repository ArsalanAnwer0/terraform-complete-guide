# Terraform Complete Guide

A comprehensive learning resource for Terraform infrastructure as code, covering core concepts, workflows, state management, modules, and advanced Kubernetes deployments. This repository provides hands-on examples progressing from basic infrastructure to complex cloud-native architectures.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Repository Structure](#repository-structure)
- [Learning Path](#learning-path)
- [Folder Details](#folder-details)
  - [terraform-for-devops](#terraform-for-devops)
  - [remote-infra](#remote-infra)
  - [terraform-modules-app](#terraform-modules-app)
  - [terraform-eks](#terraform-eks)
- [Getting Started](#getting-started)
- [Usage Instructions](#usage-instructions)
- [Best Practices](#best-practices)
- [Common Issues and Solutions](#common-issues-and-solutions)
- [Contributing](#contributing)
- [License](#license)

## Overview

This repository serves as a complete learning guide for Terraform, demonstrating real-world infrastructure patterns and best practices. Each folder represents a progressive step in learning Terraform, from basic resource creation to advanced modular architectures and Kubernetes cluster management.

### What You Will Learn

- Terraform fundamentals and syntax
- AWS resource management with Terraform
- Remote state management and collaboration
- Modular infrastructure design patterns
- Kubernetes cluster provisioning with EKS
- Security best practices and resource tagging
- Infrastructure as Code (IaC) workflows

## Prerequisites

Before using this repository, ensure you have the following installed and configured:

### Required Software

- **Terraform**: Version 1.0 or higher
- **AWS CLI**: Version 2.0 or higher
- **Git**: For version control
- **Text Editor**: VS Code, Vim, or your preferred editor

### AWS Account Setup

1. Create an AWS account if you don't have one
2. Configure AWS CLI with your credentials:
   ```bash
   aws configure
   ```
3. Ensure your AWS user has appropriate permissions for:
   - EC2 instances and security groups
   - VPC and networking resources
   - S3 bucket creation and management
   - DynamoDB table operations
   - EKS cluster creation and management

### Knowledge Prerequisites

- Basic understanding of cloud computing concepts
- Familiarity with AWS services (EC2, VPC, S3)
- Command line interface experience
- Basic networking knowledge

## Repository Structure

```
terraform-complete-guide/
├── terraform-for-devops/     # Basic infrastructure fundamentals
├── remote-infra/             # Remote state backend setup
├── terraform-modules-app/    # Modular architecture patterns
├── terraform-eks/           # Advanced EKS cluster deployment
└── README.md                # This comprehensive guide
```

## Learning Path

This repository is designed as a progressive learning experience. Follow this recommended order:

1. **Start with terraform-for-devops**: Learn basic Terraform syntax and AWS resource creation
2. **Proceed to remote-infra**: Understand state management and team collaboration
3. **Explore terraform-modules-app**: Master modular design and reusable infrastructure
4. **Advance to terraform-eks**: Deploy complex Kubernetes infrastructure

Each folder builds upon concepts from the previous ones, creating a comprehensive learning journey.

## Folder Details

### terraform-for-devops

**Purpose**: Introduction to Terraform fundamentals and basic AWS infrastructure

**What's Included**:
- EC2 instance creation with user data scripts
- VPC configuration using community modules
- Security group management with ingress/egress rules
- SSH key pair generation and management
- Variable-driven configuration
- Output value extraction
- Basic resource tagging strategies

**Key Files**:
- `ec2.tf`: EC2 instance configuration with nginx installation
- `vpc.tf`: VPC setup using terraform-aws-modules
- `variables.tf`: Input variable definitions
- `outputs.tf`: Output value specifications
- `provider.tf`: AWS provider configuration
- `terraform.tf`: Terraform and provider version constraints
- `install_nginx.sh`: Bash script for web server setup

**Learning Objectives**:
- Understand Terraform basic syntax and structure
- Learn resource dependencies and interpolation
- Practice variable usage and output extraction
- Implement basic security configurations
- Deploy functional web infrastructure

### remote-infra

**Purpose**: Remote state management and team collaboration setup

**What's Included**:
- S3 bucket creation for state file storage
- DynamoDB table setup for state locking
- Bucket versioning and encryption configuration
- Public access blocking for security
- Resource tagging for organization

**Key Files**:
- `s3.tf`: S3 bucket with security configurations
- `dynamodb.tf`: DynamoDB table for state locking
- `providers.tf`: AWS provider setup
- `terraform.tf`: Terraform configuration without backend

**Learning Objectives**:
- Understand the importance of remote state
- Learn state locking mechanisms
- Implement secure state storage
- Prepare infrastructure for team collaboration
- Configure backend resources for other projects

**Important Note**: This folder creates the infrastructure that other folders will use for remote state storage. Deploy this first when setting up team environments.

### terraform-modules-app

**Purpose**: Modular infrastructure design and environment management

**What's Included**:
- Root module orchestrating multiple environments
- Child module (infra-app) for reusable infrastructure components
- Environment-specific configurations (dev, staging, production)
- DRY (Don't Repeat Yourself) principle demonstration
- Module input/output variable patterns

**Structure**:
```
terraform-modules-app/
├── main.tf              # Root module calling child modules
├── providers.tf         # Provider configuration
├── terraform.tf        # Terraform requirements
└── infra-app/          # Child module directory
    ├── variables.tf     # Module input variables
    ├── dynamodb.tf     # DynamoDB table resource
    ├── ec2.tf          # EC2 instance resource
    └── s3.tf           # S3 bucket resource
```

**Key Files**:
- `main.tf`: Demonstrates module reuse across environments
- `infra-app/variables.tf`: Module interface definition
- `infra-app/*.tf`: Reusable infrastructure components

**Learning Objectives**:
- Master modular infrastructure design
- Understand module input/output patterns
- Learn environment-specific deployments
- Implement code reusability principles
- Practice advanced Terraform organization

### terraform-eks

**Purpose**: Advanced Kubernetes cluster deployment and management

**What's Included**:
- Complete EKS cluster setup with managed node groups
- VPC configuration optimized for Kubernetes
- Security group management for cluster communication
- Essential Kubernetes addons (vpc-cni, kube-proxy, coredns)
- Multi-availability zone deployment
- SPOT instance configuration for cost optimization

**Key Files**:
- `eks.tf`: EKS cluster and managed node group configuration
- `vpc.tf`: Kubernetes-optimized VPC setup
- `locals.tf`: Centralized configuration values
- `provider.tf`: AWS provider setup
- `terraform.tf`: Terraform requirements

**Learning Objectives**:
- Deploy production-grade Kubernetes clusters
- Understand container orchestration infrastructure
- Learn advanced networking for Kubernetes
- Implement high-availability cluster design
- Master complex resource dependencies

## Getting Started

### Quick Start Guide

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ArsalanAnwer0/terraform-complete-guide.git
   cd terraform-complete-guide
   ```

2. **Start with the first folder**:
   ```bash
   cd terraform-for-devops
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Review the execution plan**:
   ```bash
   terraform plan
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply
   ```

6. **Clean up resources when done**:
   ```bash
   terraform destroy
   ```

### Detailed Setup Process

#### For terraform-for-devops:

1. Navigate to the folder and initialize:
   ```bash
   cd terraform-for-devops
   terraform init
   ```

2. Generate SSH key pair:
   ```bash
   ssh-keygen -t rsa -b 2048 -f terra-key-ec2-v2
   ```

3. Plan and apply:
   ```bash
   terraform plan
   terraform apply
   ```

4. Access your instance using the public IP from outputs

#### For remote-infra:

1. Navigate and initialize:
   ```bash
   cd ../remote-infra
   terraform init
   ```

2. Deploy state backend infrastructure:
   ```bash
   terraform plan
   terraform apply
   ```

3. Note the S3 bucket and DynamoDB table names for use in other projects

#### For terraform-modules-app:

1. Navigate and initialize:
   ```bash
   cd ../terraform-modules-app
   terraform init
   ```

2. Review module structure:
   ```bash
   terraform plan
   ```

3. Deploy all environments:
   ```bash
   terraform apply
   ```

#### For terraform-eks:

1. Navigate and initialize:
   ```bash
   cd ../terraform-eks
   terraform init
   ```

2. Plan the EKS deployment:
   ```bash
   terraform plan
   ```

3. Deploy the cluster (this takes 10-15 minutes):
   ```bash
   terraform apply
   ```

4. Configure kubectl access:
   ```bash
   aws eks update-kubeconfig --region us-east-2 --name arsalan-eks-cluster
   ```

## Usage Instructions

### Working with Variables

Most configurations use variables for flexibility. You can:

1. **Use default values** (already set in variables.tf)
2. **Override via command line**:
   ```bash
   terraform apply -var="instance_type=t2.small"
   ```
3. **Create terraform.tfvars file**:
   ```hcl
   instance_type = "t2.small"
   env = "production"
   ```

### State Management

- **Local state**: Used in terraform-for-devops for simplicity
- **Remote state**: Configured in other folders using S3 backend
- **State locking**: Implemented via DynamoDB for team collaboration

### Environment Management

The terraform-modules-app folder demonstrates managing multiple environments:
- **Development**: Single small instance
- **Staging**: Single medium instance  
- **Production**: Multiple medium instances

### Security Considerations

1. **Never commit sensitive files**:
   - Private keys (terra-key-ec2-v2)
   - State files (*.tfstate)
   - Variable files with secrets (*.tfvars)

2. **Use appropriate CIDR blocks**:
   - Restrict SSH access to your IP
   - Limit security group rules to necessary ports

3. **Enable encryption**:
   - S3 bucket encryption for state files
   - EBS volume encryption for instances

## Best Practices

### Code Organization

1. **Use consistent naming conventions**
2. **Implement proper resource tagging**
3. **Organize files by resource type**
4. **Use modules for reusable components**
5. **Document complex configurations**

### Security Best Practices

1. **Enable remote state encryption**
2. **Use IAM roles instead of access keys when possible**
3. **Implement least privilege access**
4. **Regularly rotate access credentials**
5. **Monitor resource usage and costs**

### Development Workflow

1. **Always run terraform plan before apply**
2. **Use version control for all configurations**
3. **Test configurations in development first**
4. **Implement proper backup strategies**
5. **Document infrastructure decisions**

## Common Issues and Solutions

### Issue: Access Denied Errors
**Solution**: Verify AWS credentials and IAM permissions

### Issue: State Lock Errors
**Solution**: Check DynamoDB table exists and is accessible

### Issue: Resource Already Exists
**Solution**: Import existing resources or use different names

### Issue: Version Conflicts
**Solution**: Update Terraform and provider versions

### Issue: Network Connectivity Problems
**Solution**: Verify VPC and security group configurations

### Issue: EKS Cluster Creation Fails
**Solution**: Ensure proper IAM roles and subnet configurations

## Contributing

We welcome contributions to improve this learning resource. Here's how you can help:

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**:
   ```bash
   git checkout -b feature/improvement-name
   ```
3. **Make your changes**
4. **Test thoroughly**
5. **Commit with clear messages**:
   ```bash
   git commit -m "Add improvement to EKS configuration"
   ```
6. **Push to your fork**:
   ```bash
   git push origin feature/improvement-name
   ```
7. **Create a Pull Request**

### Contribution Guidelines

- Follow existing code style and naming conventions
- Add comments for complex configurations
- Update documentation for new features
- Test all changes before submitting
- Ensure security best practices are maintained

### Areas for Contribution

- Additional AWS services examples
- Multi-cloud configurations
- Advanced security patterns
- CI/CD integration examples
- Additional testing scenarios
- Documentation improvements
- Bug fixes and optimizations

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

**Happy Learning!** This repository is designed to take you from Terraform beginner to advanced practitioner. Work through each folder systematically, experiment with configurations, and don't hesitate to modify examples for your specific use cases.

For questions, issues, or suggestions, please open an issue in this repository.