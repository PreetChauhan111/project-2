module "alb-sg" {
  source              = "PreetChauhan111/sg/pc"
  version             = "2.2.0"
  vpc_id              = module.vpc.vpc_id
  description         = "Allow HTTP and HTTPS traffic"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http", "https"]
  egress_rules        = ["all-all"]
}

module "ec2-sg" {
  source      = "PreetChauhan111/sg/pc"
  version     = "2.2.0"
  vpc_id      = module.vpc.vpc_id
  description = "Restricted to ALB only"
  ingress_with_source_security_group_id = {
    "restrict" = {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb-sg.security_group_id
    }
  }
  egress_rules = ["all-all"]
}