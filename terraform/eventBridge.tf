module "eventbridge" {
  source     = "PreetChauhan111/eventbridge/pc"
  version    = "1.1.0"
  create_bus = false
  rules = {
    sns_email_on_alarm = {
      description = "Send SNS email on alarm"
      event_pattern = jsonencode({
        source        = ["aws.cloudwatch"]
        "detail-type" = ["CloudWatch Alarm State Change"]
        detail = {
          state = {
            value = ["ALARM"]
          }
          alarmName = [module.cloudwatch_metric-alarm.cloudwatch_metric_alarm_id]
        }
      })
    }
  }
  targets = {
    sns_email_on_alarm = [
      {
        name = "send-email"
        arn  = module.sns.topic_arn
      }
    ]
  }
}