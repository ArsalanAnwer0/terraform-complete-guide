# Basic public IP output
output "ec2_public_ip" {
  description = "Public IP addresses of all EC2 instances"
  value = [
    for instance in aws_instance.my_instance : instance.public_ip
  ]
}

# Additional outputs for learning purposes
output "ec2_instance_details" {
  description = "Detailed information about EC2 instances"
  value = {
    for key, instance in aws_instance.my_instance : key => {
      instance_id = instance.id
      public_ip   = instance.public_ip
      private_ip  = instance.private_ip
      instance_type = instance.instance_type
    }
  }
}

output "security_group_id" {
  description = "ID of the created security group"
  value = aws_security_group.my_security_group.id
}

output "key_pair_name" {
  description = "Name of the created key pair"
  value = aws_key_pair.my_key.key_name
}

output "nginx_urls" {
  description = "URLs to access the nginx servers"
  value = [
    for instance in aws_instance.my_instance : "http://${instance.public_ip}"
  ]
}