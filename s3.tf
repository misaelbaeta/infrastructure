resource "aws_s3_bucket" "terraform_state" {
  bucket = "sre-us-east-1"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Production"
  }
}