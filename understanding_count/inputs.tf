variable "vpcs" {
    type = list(object({
      cidr_block = string
      name = string
    }))

    default = [ {
      cidr_block = "192.168.0.0/24"
      name = "vpc-1"
    }, {
      cidr_block = "192.168.1.0/24"
      name = "vpc-2"
    },
        {
      cidr_block = "192.168.2.0/24"
      name = "vpc-3"
    }]
}
