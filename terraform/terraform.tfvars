# If you set a default value for a variable, you do not need to declare it in the tfvars file.
# The tfvars file is for setting the value of the variable to be used in this Terraform state.
# In some cases, the default value you give a variable may be the same value you give it in tfvars.

project_name           = "terraria-server"
repository_name        = "willquill/terraria-server"
region                 = "us-east-2"
host_enable            = true
host_instance_type     = "t2.micro"
alert_dollar_threshold = "1"
alert_email_address    = "aws2022@will.mx"