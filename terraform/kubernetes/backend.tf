terraform {
  backend "s3" {
    bucket         	   = "demo-bucket-1234567890"
    key              	   = "state/terraform.tfstate"
    region         	   = "us-east-1"
    encrypt        	   = true
    dynamodb_table = "terraform-state-lock"
  }
}