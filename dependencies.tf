provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = "us-east-2"
}

# Variables used in dependencies.tf
variable "github_name" {
  type = string
  default = "willquill"
}

# Bucket to store Terraform states
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.github_name}-terraform-state-backend"
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
