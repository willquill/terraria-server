# If you set a default value for a variable, you do not need to declare it in the tfvars file.
# The tfvars file is for setting the value of the variable to be used in this Terraform state.
# In some cases, the default value you give a variable may be the same value you give it in tfvars.

variable "project_name" {
  type    = string
  default = "MyProject"
}

variable "repository_name" {
  type    = string
  default = "username/repository"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "host_enable" {
  type    = bool
  default = true
}

variable "host_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "dollar_threshold" {
  type    = string
  default = "1"
}

variable "email_address" {
  type    = string
  default = ""
}
