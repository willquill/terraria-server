terraform {
  backend "s3" {
    bucket         = "willquill-terraform-state-backend"
    key            = "terraria-server/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
