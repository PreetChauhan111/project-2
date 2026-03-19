module "acm-api" {
  source                 = "PreetChauhan111/acm/pc"
  version                = "1.1.0"
  domain_name            = "api.${var.domain_name}"
  zone_id                = data.aws_route53_zone.hosted_zone.id
  create_certificate     = true
  create_route53_records = true
  validate_certificate   = true
  key_algorithm          = var.key_algorithm
  validation_method      = var.validation_method
  wait_for_validation    = true
  tags                   = local.api_acm_tags
}

module "acm-www" {
  source                 = "PreetChauhan111/acm/pc"
  version                = "1.1.0"
  domain_name            = "www.${var.domain_name}"
  zone_id                = data.aws_route53_zone.hosted_zone.id
  create_certificate     = true
  create_route53_records = true
  validate_certificate   = true
  key_algorithm          = var.key_algorithm
  validation_method      = var.validation_method
  wait_for_validation    = true
  tags                   = local.www_acm_tags
}