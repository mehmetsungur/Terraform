terraform {
  
  ## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND) YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  

#   backend "s3" {
#     bucket         = "b107-tf-state" # REPLACE WITH YOUR BUCKET NAME
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "tf-state-locking"
#     encrypt        = true
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "b107"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "b107-tf-state" # REPLACE WITH YOUR BUCKET NAME
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket        = aws_s3_bucket.terraform_state.bucket 
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "tf-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}