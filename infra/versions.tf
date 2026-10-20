terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Region comes from AWS_REGION, which configure-aws-credentials sets.
provider "aws" {
  default_tags {
    tags = {
      project    = "secure-delivery-pipeline"
      managed-by = "terraform"
    }
  }
}
