# Key pair (login)
resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("terra-key-ec2-v2.pub")
  tags = {
    Name        = "${var.env}-infra-app-key"
    Environment = var.env
  }
}

# VPC & Security Group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "${var.env}-default-vpc"
  }
}

resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-infra-app-sg"
  description = "Security group for infra-app module"
  vpc_id      = aws_default_vpc.default.id

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Note: For learning - restrict in production
    description = "SSH access"
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  # Outbound rules 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name        = "${var.env}-infra-app-sg"
    Environment = var.env
  }
}

# EC2 Instances
resource "aws_instance" "my_instance" {
  count      = var.instance_count
  depends_on = [aws_security_group.my_security_group, aws_key_pair.my_key]
  
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  instance_type          = var.instance_type
  ami                    = var.ec2_ami_id
  
  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10
    volume_type = "gp3"
    encrypted   = true # encryption
  }
  
  tags = {
    Name        = "${var.env}-infra-app-instance-${count.index + 1}" 
    Environment = var.env
  }
}