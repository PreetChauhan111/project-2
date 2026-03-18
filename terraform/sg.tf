module "alb-sg" {
  source              = "PreetChauhan111/sg/pc"
  version             = "2.2.0"
  name                = local.alb_sg
  vpc_id              = module.vpc.vpc_id
  description         = "Allow HTTP and HTTPS traffic"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
  tags                = local.alb_sg_tags
}

module "ec2-sg" {
  source      = "PreetChauhan111/sg/pc"
  version     = "2.2.0"
  name        = local.ec2_sg
  vpc_id      = module.vpc.vpc_id
  description = "Allow HTTP from ALB security group only"
  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb-sg.security_group_id
    }
  ]
  egress_rules = ["all-all"]
  tags         = local.ec2_sg_tags
}