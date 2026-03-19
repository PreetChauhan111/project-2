variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

##################################################
# VPC Variables                                  #
##################################################

variable "azs" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

##################################################
# Compute Variables                              #
##################################################

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "lambda_runtime" {
  type    = string
  default = "python3.12"
}

variable "lambda_timeout" {
  type    = number
  default = 10
}

variable "lambda_memory" {
  type    = number
  default = 128
}

##################################################
# ACM Variables                                  #
##################################################

variable "domain_name" {
  type    = string
  default = "preetchauhan211.in"
}