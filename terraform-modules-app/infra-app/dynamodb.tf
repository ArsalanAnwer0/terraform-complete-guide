# DynamoDB table for application data storage
resource "aws_dynamodb_table" "basic-dynamodb-table" {
 name           = "${var.env}-infra-app-table"  # Table name with environment prefix
 billing_mode   = "PAY_PER_REQUEST"             # On demand billing (no capacity planning needed)
 hash_key       = var.hash_key                  # Primary key for the table

 # Define the primary key attribute
 attribute {
   name = var.hash_key  # Attribute name from variable
   type = "S"           # String data type
 }

 # Resource tags for organization and cost tracking
 tags = {
   Name        = "${var.env}-infra-app-table"
   Environment = var.env
 }
}