module "vpc" {
  source                        = "PreetChauhan111/vpc/pc"
  version                       = "1.3.0"
  name                          = local.vpc_name
  azs                           = var.azs
  cidr                          = var.vpc_cidr
  private_subnets               = var.private_subnets
  public_subnets                = var.public_subnets
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false
  map_public_ip_on_launch       = true
  enable_dns_hostnames          = true
  enable_dns_support            = true
  create_igw                    = true
  igw_tags                      = local.igw_tags
  enable_nat_gateway            = true
  single_nat_gateway            = true
  nat_gateway_tags              = local.nat_gateway_tags
  tags                          = local.vpc_tags
  private_dedicated_network_acl = true
  public_dedicated_network_acl  = true
  public_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  ]
  public_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  ]
  private_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = var.vpc_cidr
    }
  ]
  private_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  ]
}