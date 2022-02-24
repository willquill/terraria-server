# If you set a default value for a variable, you do not need to declare it in the tfvars file.
# The tfvars file is for setting the value of the variable to be used in this Terraform state.
# In some cases, the default value you give a variable may be the same value you give it in tfvars.

project     = "terraria-server"
repository  = "willquill/terraria-server"
region      = "us-east-2"
host_enable = true
# t2.micro is the only free tier eligible instance type in us-east-2
host_instance_type = "t2.micro"