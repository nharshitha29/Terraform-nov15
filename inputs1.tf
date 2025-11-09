variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "region information"

}

variable "vpc_info" {
  type = object({
    cidr = string
    tags = map(string)
  })

  default = {
    cidr = "192.168.0.0/16"
    tags = {
      Name = "from-tf"
      Env  = "Dev"
    }
  }
  description = "vpc information"
}
variable "web_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1a"
    cidr = "192.168.0.0/24"
    tags = {
      Name = "web"
      Env  = "Dev"

    }

  }
  description = "web subnet information"
}
variable "app_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1a"
    cidr = "192.168.1.0/24"
    tags = {
      Name = "app"
      Env  = "Dev"

    }

  }
  description = "app subnet information"
}
variable "db_subnet_info" {
  type = object({
    cidr = string
    az   = string
    tags = map(string)
  })
  default = {
    az   = "ap-south-1a"
    cidr = "192.168.2.0/24"
    tags = {
      Name = "db"
      Env  = "Dev"

    }

  }
  description = "db subnet information"
}
