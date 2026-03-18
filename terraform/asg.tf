module "asg" {
  source                    = "PreetChauhan111/asg/pc"
  version                   = "1.2.2"
  name                      = local.asg_name
  autoscaling_group_tags    = local.asg_tags
  vpc_zone_identifier       = module.vpc.private_subnets
  desired_capacity          = 2
  desired_capacity_type     = "units"
  health_check_type         = "ELB"
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  scaling_policies = {
    cpu = {
      policy_type = "TargetTrackingScaling"
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50
      }
    }
  }
  traffic_source_attachments = {
    alb = {
      traffic_source_identifier = module.alb-nlb.target_groups["app"].arn
      traffic_source_type       = "elbv2"
    }
  }

  ##################### Launch Template #######################

  create_launch_template = true
  launch_template_name   = local.launch_template_name
  launch_template_tags   = local.launch_template_tags
  image_id               = data.aws_ami.ami_id.id
  instance_type          = var.instance_type
  instance_name          = local.instance_name
  security_groups        = [module.ec2-sg.security_group_id]
  user_data              = local.user_data_file
  depends_on             = [module.vpc]
}