terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.70"
    }
  }
}

provider "aws" {
  region     = "eu-north-1"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

provider "aws" {
  region = "eu-west-3"  # Region for DocumentDB
  alias  = "docdb_region"  # Alias for this provider
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}