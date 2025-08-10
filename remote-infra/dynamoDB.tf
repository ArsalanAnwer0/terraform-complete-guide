# DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "arsalan-state-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "arsalan-state-table"
    Environment = "shared"
    Purpose     = "terraform-state-locking"
  }
}