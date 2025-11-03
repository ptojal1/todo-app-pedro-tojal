terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

# Data source para obter informações da conta AWS
data "aws_caller_identity" "current" {}

# Data source para obter informações da região
data "aws_region" "current" {}

