# S3 bucket for the infra app module
resource "aws_s3_bucket" "remote_s3" {
  bucket = "${var.env}-${var.bucket_name}"
  
  tags = {
    Name        = "${var.env}-${var.bucket_name}"
    Environment = var.env
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "remote_s3_versioning" {
  bucket = aws_s3_bucket.remote_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "remote_s3_encryption" {
  bucket = aws_s3_bucket.remote_s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "remote_s3_pab" {
  bucket = aws_s3_bucket.remote_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}