module "vpc" {
  source                        = "PreetChauhan111/vpc/pc"
  version                       = "1.3.0"
  name                          = local.vpc_name
  azs                           = var.azs
  cidr                          = var.vpc_cidr
  private_subnets               = var.private_subnets
  private_subnet_names          = ["${local.private_subnet_names}-1", "${local.private_subnet_names}-2"]
  public_subnets                = var.public_subnets
  public_subnet_names           = ["${local.public_subnet_names}-1", "${local.public_subnet_names}-2"]
  manage_default_route_table    = false
  manage_default_security_group = false
  manage_default_network_acl    = true
  map_public_ip_on_launch       = true
  enable_dns_hostnames          = true
  enable_dns_support            = true
  create_igw                    = true
  igw_tags                      = local.igw_tags
  enable_nat_gateway            = true
  single_nat_gateway            = true
  one_nat_gateway_per_az        = false
  nat_gateway_tags              = local.nat_gateway_tags
  tags                          = local.vpc_tags
}