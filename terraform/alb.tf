module "alb-nlb" {
  source                = "PreetChauhan111/alb-nlb/pc"
  version               = "1.1.0"
  name                  = local.alb_name
  tags                  = local.alb_tags
  vpc_id                = module.vpc.vpc_id
  subnets               = module.vpc.public_subnets
  create_security_group = false
  security_groups       = [module.alb-sg.security_group_id]
  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "app"
      }
    }
  }
  target_groups = {
    app = {
      name        = local.target_group_name
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"
      create_attachment = false

      health_check = {
        path                = "/health"
        matcher             = "200-299"
        healthy_threshold   = 2
        unhealthy_threshold = 3
      }
    }
  }
}