####################################################
# Read Function                                    #
####################################################

module "lambda-read" {
  source        = "PreetChauhan111/lambda/pc"
  version       = "1.1.0"
  function_name = local.read_function
  source_path   = local.read_function_path
  handler       = local.read_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory

  environment_variables = {
    TABLE_NAME = module.ddb.dynamodb_table_id
  }

  tags = local.read_function_tags

  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = module.ddb.dynamodb_table_arn
      }
    ]
  })
}

####################################################
# Add Function                                     #
####################################################

module "lambda-add" {
  source        = "PreetChauhan111/lambda/pc"
  version       = "1.1.0"
  function_name = local.add_function
  source_path   = local.add_function_path
  handler       = local.add_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory

  environment_variables = {
    TABLE_NAME = module.ddb.dynamodb_table_id
  }

  tags = local.add_function_tags

  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ]
        Resource = module.ddb.dynamodb_table_arn
      }
    ]
  })
}

####################################################
# Delete Function                                  #
####################################################

module "lambda-delete" {
  source        = "PreetChauhan111/lambda/pc"
  version       = "1.1.0"
  function_name = local.delete_function
  source_path   = local.delete_function_path
  handler       = local.delete_handler
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory

  environment_variables = {
    TABLE_NAME = module.ddb.dynamodb_table_id
  }

  tags = local.delete_function_tags

  policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:DeleteItem"
        ]
        Resource = module.ddb.dynamodb_table_arn
      }
    ]
  })
}