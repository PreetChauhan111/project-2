locals {
  common_tags = {
    Owner       = "pc"
    Environment = var.environment
    Project     = "library-app"
  }
  common_name = "${local.common_tags.Owner}-${var.environment}"

  ####################### VPC Locals #######################

  vpc_name             = "${local.common_name}-vpc"
  vpc_tags             = merge(local.common_tags, { Name = local.vpc_name })
  igw_tags             = merge(local.common_tags, { Name = "${local.common_name}-igw" })
  nat_gateway_tags     = merge(local.common_tags, { Name = "${local.common_name}-natgw" })
  private_subnet_names = "${local.common_name}-private-subnet"
  public_subnet_names  = "${local.common_name}-public-subnet"

  ####################### SG Locals #######################

  alb_sg      = "${local.common_name}-alb-sg"
  ec2_sg      = "${local.common_name}-ec2-sg"
  alb_sg_tags = merge(local.common_tags, { Name = local.alb_sg })
  ec2_sg_tags = merge(local.common_tags, { Name = local.ec2_sg })

  ####################### ALB Locals #######################

  alb_name          = "${local.common_name}-alb"
  alb_tags          = merge(local.common_tags, { Name = local.alb_name })
  target_group_name = "${local.common_name}-tg"

  ####################### ASG Locals #######################

  asg_name             = "${local.common_name}-asg"
  asg_tags             = merge(local.common_tags, { Name = local.asg_name })
  launch_template_name = "${local.common_name}-lt"
  launch_template_tags = merge(local.common_tags, { Name = local.launch_template_name })
  instance_name        = "${local.common_name}-ec2"
  user_data_file       = base64encode(file("${path.module}/user_data/frontend.sh"))

  ####################### Lambda Locals #######################

  read_function      = "${local.common_name}-read-function"
  read_function_path = "${path.module}/lambda_code/read.py"
  read_handler       = "read.lambda_handler"
  read_function_tags = merge(local.common_tags, { Name = local.read_function })

  add_function      = "${local.common_name}-add-function"
  add_function_path = "${path.module}/lambda_code/add.py"
  add_handler       = "add.lambda_handler"
  add_function_tags = merge(local.common_tags, { Name = local.add_function })

  delete_function      = "${local.common_name}-delete-function"
  delete_function_path = "${path.module}/lambda_code/delete.py"
  delete_handler       = "delete.lambda_handler"
  delete_function_tags = merge(local.common_tags, { Name = local.delete_function })

  ####################### DDB Locals #######################

  table_name = "${local.common_name}-table"
  table_tags = merge(local.common_tags, { Name = local.table_name })

  ####################### APIGW Locals #######################

  apigw_name               = "${local.common_name}-apigw"
  apigw_tags               = merge(local.common_tags, { Name = local.apigw_name })
  read_lambda_invoke_uri   = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${module.lambda-read.lambda_function_arn}/invocations"
  add_lambda_invoke_uri    = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${module.lambda-add.lambda_function_arn}/invocations"
  delete_lambda_invoke_uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${module.lambda-delete.lambda_function_arn}/invocations"

  ####################### ACM Locals #######################

  api_acm_name = "${local.common_name}-api-acm"
  api_acm_tags = merge(local.common_tags, { Name = local.api_acm_name })
  www_acm_name = "${local.common_name}-www-acm"
  www_acm_tags = merge(local.common_tags, { Name = local.www_acm_name })

  ####################### CloudWatch Locals #######################

  alarm_name = "${local.common_name}-alarm"
  alarm_tags = merge(local.common_tags, { Name = local.alarm_name })

  ####################### SNS Locals #######################

  topic_name = "${local.common_name}-sns"
  topic_tags = merge(local.common_tags, { Name = local.topic_name })
}