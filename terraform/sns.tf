module "sns" {
  source  = "PreetChauhan111/sns/pc"
  version = "1.3.0"
  name    = local.topic_name

  subscriptions = {
    email = {
      endpoint = var.email
      protocol = "email"
    }
  }
}