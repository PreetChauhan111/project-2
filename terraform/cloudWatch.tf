module "cloudwatch_metric-alarm" {
  source              = "PreetChauhan111/cloudwatch/pc//modules/metric-alarm"
  version             = "1.3.1"
  alarm_name          = local.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 30
  statistic           = "Average"
  period              = 60

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"

  dimensions = {
    AutoScalingGroupName = module.asg.autoscaling_group_name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  tags              = local.alarm_tags
}