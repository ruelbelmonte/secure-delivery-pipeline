# Run once, locally, with admin credentials. State stays local: it holds no secrets,
# but keep it if you want Terraform to manage (or destroy) these resources later.
terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      project    = "secure-delivery-pipeline"
      managed-by = "terraform"
    }
  }
}
