# Key pair (login)
resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-terra-key-ec2-v2"
  public_key = file("terra-key-ec2-v2.pub")
  tags = {
    Environment = var.env
  }
}

# VPC & Security Group
resource "aws_default_vpc" "default" {
  tags = {
    Name = "${var.env}-default-vpc"
  }
}

# Security Group 
resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-automate-sg"
  description = "This will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id # interpolation

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For learning in production, restrict to specific IPs
    description = "SSH open"
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }
  
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask app"
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
    Name        = "${var.env}-automate-sg"
    Environment = var.env
  }
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  for_each = tomap({
    Arsalan-micro = "t2.micro",
  })
  
  depends_on = [aws_security_group.my_security_group, aws_key_pair.my_key]
  
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  instance_type          = each.value
  ami                    = var.ec2_ami_id
  user_data              = file("install_nginx.sh")
  
  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size
    volume_type = "gp3"
    encrypted   = true # Enable encryption
  }
  
  tags = {
    Name        = each.key
    Environment = var.env
  }
}