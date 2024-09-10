terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "class-schedule-tf-state"
    key    = "state"
    region = "eu-central-1"
  }
}