module "asg" {
  source                 = "PreetChauhan111/asg/pc"
  version                = "1.2.0"
  name                   = local.asg_name
  autoscaling_group_tags = local.asg_tags
  availability_zones     = var.azs
  create_launch_template = true
  desired_capacity       = 2
  desired_capacity_type  = "units"
  health_check_type      = "EC2"
  min_size               = 1
  max_size               = 3
  image_id               = data.ami_ids.ubuntu.id
  instance_type          = var.instance_type
  instance_name          = local.instance_name
  security_groups        = module.asg-sg.security_group_id
}