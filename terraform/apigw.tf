module "apigw-rest" {
  source        = "PreetChauhan111/apigw-rest/pc"
  version       = "1.2.1"
  enabled       = true
  name          = local.apigw_name
  tags          = local.apigw_tags
  # environment   = var.environment
  stage         = var.environment
  # namespace     = "pc"
  logging_level = "OFF"
  openapi_config = {
    openapi = "3.0.1"
    info = {
      title   = "Library API"
      version = "1.0.0"
    }
    paths = {
      "/" = {
        ####### GET #######
        get = {
          responses = {
            "200" = {
              description = "200 response"
              headers = {
                "Access-Control-Allow-Origin" = {
                  schema = { type = "string" }
                }
              }
            }
          }
          x-amazon-apigateway-integration = {
            uri        = local.read_lambda_invoke_uri
            httpMethod = "POST"
            type       = "aws_proxy"
          }
        }
        ####### OPTIONS (CORS) #######
        options = {
          responses = {
            "200" = {
              description = "CORS support"
              headers = {
                "Access-Control-Allow-Origin" = {
                  schema = { type = "string" }
                }
                "Access-Control-Allow-Methods" = {
                  schema = { type = "string" }
                }
                "Access-Control-Allow-Headers" = {
                  schema = { type = "string" }
                }
              }
            }
          }
          x-amazon-apigateway-integration = {
            type = "mock"
            requestTemplates = {
              "application/json" = "{\"statusCode\": 200}"
            }
            response = {
              default = {
                statusCode = "200"
                responseParameters = {
                  "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                  "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
                  "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
                }
              }
            }
          }
        }
      }
      "/add" = {
        ###### POST ######
        post = {
          responses = {
            "200" = {
              description = "200 response"
              headers = {
                "Access-Control-Allow-Origin" = {
                  schema = { type = "string" }
                }
              }
            }
          }
          x-amazon-apigateway-integration = {
            uri        = local.add_lambda_invoke_uri
            httpMethod = "POST"
            type       = "aws_proxy"
          }
        }
        ####### OPTIONS (CORS) #######
        options = {
          responses = {
            "200" = {
              description = "CORS support"
              headers = {
                "Access-Control-Allow-Origin" = {
                  schema = { type = "string" }
                }
                "Access-Control-Allow-Methods" = {
                  schema = { type = "string" }
                }
                "Access-Control-Allow-Headers" = {
                  schema = { type = "string" }
                }
              }
            }
          }
          x-amazon-apigateway-integration = {
            type = "mock"
            requestTemplates = {
              "application/json" = "{\"statusCode\": 200}"
            }
            response = {
              default = {
                statusCode = "200"
                responseParameters = {
                  "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                  "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
                  "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
                }
              }
            }
          }
        }
      }
      "/delete" = {
        ###### DELETE ######
        delete = {
          responses = {
            "200" = {
              description = "200 response"
              headers = {
                "Access-Control-Allow-Origin" = {
                  schema = { type = "string" }
                }
              }
            }
          }
          x-amazon-apigateway-integration = {
            uri        = local.delete_lambda_invoke_uri
            httpMethod = "POST"
            type       = "aws_proxy"
          }
        }
        ####### OPTIONS (CORS) #######
        options = {
          responses = {
            "200" = {
              description = "CORS support"
              headers = {
                "Access-Control-Allow-Origin" = {
                  schema = { type = "string" }
                }
                "Access-Control-Allow-Methods" = {
                  schema = { type = "string" }
                }
                "Access-Control-Allow-Headers" = {
                  schema = { type = "string" }
                }
              }
            }
          }
          x-amazon-apigateway-integration = {
            type = "mock"
            requestTemplates = {
              "application/json" = "{\"statusCode\": 200}"
            }
            response = {
              default = {
                statusCode = "200"
                responseParameters = {
                  "method.response.header.Access-Control-Allow-Origin"  = "'*'"
                  "method.response.header.Access-Control-Allow-Methods" = "'DELETE,OPTIONS'"
                  "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
                }
              }
            }
          }
        }
      }
    }
  }
}

###########################################################
# Lambda Permissions                                      #
###########################################################

resource "aws_lambda_permission" "apigw_read" {
  statement_id  = "AllowExecutionFromAPIGatewayRead"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda-read.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.apigw-rest.execution_arn}/*/GET"
}

resource "aws_lambda_permission" "apigw_add" {
  statement_id  = "AllowExecutionFromAPIGatewayAdd"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda-add.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.apigw-rest.execution_arn}/*/POST/add"
}

resource "aws_lambda_permission" "apigw_delete" {
  statement_id  = "AllowExecutionFromAPIGatewayDelete"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda-delete.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.apigw-rest.execution_arn}/*/DELETE/delete"
}

###########################################################
# Add Domain Name                                         #
###########################################################

resource "aws_api_gateway_domain_name" "apigw_domain" {
  domain_name     = var.domain_name
  regional_certificate_arn = module.acm-api.regional_certificate_arn
  endpoint_configuration { types = ["REGIONAL"] }
}

resource "aws_api_gateway_base_path_mapping" "apigw_mapping" {
  domain_name = aws_api_gateway_domain_name.apigw_domain.domain_name
  api_id      = module.apigw-rest.id
  stage_name  = var.environment
}