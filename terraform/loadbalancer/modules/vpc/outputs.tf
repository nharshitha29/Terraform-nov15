output "vpc_id" {
    value = aws_vpc.base.id
  
}
output "public_ids" {
    value = aws_subnet.public[*].id
  
}