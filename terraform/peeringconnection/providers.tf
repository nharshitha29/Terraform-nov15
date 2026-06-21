terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }

}

provider "aws" {
  # Configuration options
  alias  = "primary"
  region = "ap-south-1"
}
provider "aws" {
  alias  = "secondary"
  region = "us-east-1"
}