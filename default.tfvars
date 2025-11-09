vpc_cidr        = "10.0.0.0/16"
web_subnet_az   = "ap-south-1a"
web_subnet_cidr = "10.0.0.0/24"
app_subnet_az   = "ap-south-1a"
app_subnet_cidr = "10.0.1.0/24"
db_subnet_az    = "ap-south-1a"
db_subnet_cidr  = "10.0.2.0/24"
--------------------------
second method
--------------------------
region = "ap-south-1"
vpc_info = {
  cidr = "10.10.0.0/16"
  tags = {
    Name = "from-tf"
    Env  = "Dev"
  }
}

web_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.0.0/24"
  tags = {
    Name = "web"
    Env  = "Dev"
  }
}

app_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.1.0/24"
  tags = {
    Name = "app"
    Env  = "Dev"
  }
}

db_subnet_info = {
  az   = "ap-south-1a"
  cidr = "10.10.2.0/24"
  tags = {
    Name = "db"
    Env  = "Dev"
  }
}
