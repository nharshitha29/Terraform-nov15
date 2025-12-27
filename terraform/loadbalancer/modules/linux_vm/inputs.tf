variable "ami" {
    type = string
  
}
variable "subnet_id" {
    type = string
  
}
variable "security_group_id" {
    type = string
  
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "key_name" {
  type = string

}
variable "key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"

}
variable "build_id" {
  type    = string
  default = "1"

}