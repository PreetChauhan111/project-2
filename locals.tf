locals {
  common_tags = {
    Owner       = "pc"
    Environment = var.environment
    Project     = "library-app"
  }
  common_name = "${local.common_tags.Owner}-${var.environment}"

  ####################### VPC Locals #######################

  vpc_name         = "${local.common_name}-vpc"
  vpc_tags         = merge(local.common_tags, { Name = local.vpc_name })
  igw_tags         = merge(local.common_tags, { Name = "${local.common_name}-igw" })
  nat_gateway_tags = merge(local.common_tags, { Name = "${local.common_name}-natgw" })

  ####################### ALB Locals #######################

  alb_name          = "${local.common_name}-alb"
  alb_tags          = merge(local.common_tags, { Name = local.alb_name })
  target_group_name = "${local.common_name}-tg"

  ####################### ASG Locals #######################

  asg_name      = "${local.common_name}-asg"
  asg_tags      = merge(local.common_tags, { Name = local.asg_name })
  instance_name = "${local.common_name}-ec2"
}