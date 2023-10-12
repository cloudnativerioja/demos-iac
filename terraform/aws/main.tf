resource "aws_s3_bucket" "demo_bucket" {
  bucket        = local.vars.bucket.name
  force_destroy = true

  tags = {
    Name        = "Terraform Bucket"
    Environment = "Demo"

  }
}