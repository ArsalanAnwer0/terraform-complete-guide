# key pair (login)

resource "aws_key_pair" "my_key" {
  key_name = "terra-key-ec2-v2"
  public_key = file("terra-key-ec2-v2.pub")
}

# VPC & Security Group

resource "aws_default_vpc" "default" {

}

resource aws_security_group my_security_group {
    name = "automate-sg-v3"
    description = "this will add a TF generated security group"
    vpc_id = aws_default_vpc.default.id # interpolation

    # in bound rules

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "flask app"
    }
    # out bound rules

    egress {
        from_port = 0
        to_port = 0
        protocol = -1 
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "automate-sg"
    }

}
# EC2

resource "aws_instance" "my_instance" {
    for_each = tomap({
        Arsalan-micro = "t2.micro",
        Arsalan-medium = "t2.medium",
        Arsalan-small = "t2.small"

    })
    depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key ]
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = each.value
    ami = var.ec2_ami_id
    user_data = file("install_nginx.sh")
    root_block_device {
      volume_size = var.env == "prd" ? 20 : var.ec2_default_root_storage_size
      volume_type = "gp3"
    }
    tags = {
      Name = each.key
      Environment = var.env
    }
}



