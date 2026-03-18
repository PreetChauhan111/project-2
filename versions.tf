terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-s3-bucket-as-backend"
    key     = "project2/dev/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
provider "aws" {
  region = var.region
} 