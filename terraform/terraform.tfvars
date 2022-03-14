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
ec2_public_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8111eHYu4aIb0Zk5sfdPgj6L+KPBVp0db79YYBbPZjcHt13ZXsgodGkGkuLmjvqQuNEb4hj82SVME6QKL59QUd/aALUez7EyHXXepx9p3HvClQGW5SPYEK6k1woztWGwre9/2+LZ1RbhsBbTqog70C9ARkUmWpMluJB9E/Oc6AWGP36clkPqu+iiJbVCQqoyjhE4R0aFKOE6Sfpm5hktChzlKCSkqNyaXonm7dsfn7hNB6krhd6PcBC08Wlq2KHW5fJPDc+0lXLOzJMZ4vebUQb279WvWvQ7p1a+rQaI43XjwJwU85hwP6x1HX86fdJwkD6l+QK55Jn/CZDgHoH4V+O39v6KTN5CiWpKw3TBrkKvAinpvAhHI0tZTPnrJPY6CC/FeoLSjT3dqyh3iWtW6XYZ8OBOxbf927UpNvrvKP2e6L5DGyz/PcVjvABhjqcbnNa+UWtdd5tr/y8gqvMceQ8OQtTyRGE6068P1dcTIeQdtYCz/bmzEycfSyawDNAD1YuqnVz4mlcr5/98jWp3FgIGvACayKtqS6tW7BF2BsBp4BoDeSRA0T0IVkya2hwPitxOtU/+D5EjCAzhsci18KlxczaIfwJNC8IpYs9yXj7yfClakP/ZCye3g0O0Mx6lipbn69MXU61E1CavFmtX3GN0IWqhQtl97tGj8yU+IfQ== will@lizard"