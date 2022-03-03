# I'm using Parameter Store to obfuscate
# certain values for my own privacy.
# This section assumes that the parameters have
# already been setup in AWS Parameter Store
# and are using appropriate values.

data "aws_ssm_parameter" "ssh_cidrs" {
  name = "/${lower(var.project_name)}/terraform/ssh-cidrs"
}

data "aws_ssm_parameter" "key_pair_name" {
  name = "/${lower(var.project_name)}/terraform/key-pair-name"
}

data "aws_ssm_parameter" "mr_db_backup_bucket_name" {
  name = "/${lower(var.project_name)}/media-requests/s3-db-backup-bucket-name"
}

data "aws_ssm_parameter" "aws_account_id" {
  name = "/${lower(var.project_name)}/terraform/aws-account-id"
}

data "aws_key_pair" "main" {
  key_name = data.aws_ssm_parameter.key_pair_name.value
}