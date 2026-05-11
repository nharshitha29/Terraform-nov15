terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
  backend "s3" {
    bucket               = "learning-qt"
    key                  = "terraform/ntier/state"
    region               = "us-east-1"
    use_lockfile         = true
    workspace_key_prefix = "env"
  }
}

provider "aws" {
  # Configuration options
  region = var.region_vpc.region
}