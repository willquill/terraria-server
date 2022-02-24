module "sg_host_inbound_ssh" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  name        = "${var.project_name}-SSH-Inbound"
  description = "Security group to allow inbound SSH"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Allow inbound SSH"
      cidr_blocks = data.aws_ssm_parameter.ssh_cidrs.value
    }
  ]

  egress_rules = ["all-all"]

  tags = {
    Usage = "Inbound SSH"
  }
}

module "sg_host_inbound_terraria" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  name        = "${var.project_name}-Terraria-Inbound"
  description = "Security group to allow inbound Terraria traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 7777
      to_port     = 7777
      protocol    = "tcp"
      description = "Allow inbound 7777"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = ["all-all"]

  tags = {
    Usage = "Inbound Terraria traffic"
  }
}