resource "aws_s3_bucket" "demo_bucket" {
  bucket        = local.vars.bucket.name
  force_destroy = true

  tags = {
    Name        = "Terraform Bucket"
    Environment = "Demo"

  }
}

resource "aws_dynamodb_table" "terraform-lock" {
    name           = local.vars.dynamodb.name
    read_capacity  = 5
    write_capacity = 5
    hash_key       = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = "DynamoDB Terraform State Lock Table"
    }
}