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
    api = {
      name = "api"
      type = "A"
      alias = {
        name                   = aws_api_gateway_domain_name.apigw_domain.regional_domain_name
        zone_id                = aws_api_gateway_domain_name.apigw_domain.regional_zone_id
        evaluate_target_health = false
      }
    }
  }
}