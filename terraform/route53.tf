module "route53" {
  source      = "PreetChauhan111/route53/pc"
  version     = "1.1.0"
  create_zone = false
  records = {
    alb = {
      name = "www"
      type = "A"
      alias = {
        name    = module.alb-nlb.dns_name
        zone_id = module.alb-nlb.zone_id
      }
    }
  }
}