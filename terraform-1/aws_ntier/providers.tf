provider "aws" {

  region = "ap-south-1"
}
---------------------
second method
---------------------
provider "aws" {

  region = var.region
}
