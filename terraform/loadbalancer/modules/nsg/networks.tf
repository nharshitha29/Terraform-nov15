resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  name = var.aws_security_group.name
  tags = var.aws_security_group.tags


}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  count             = length(var.ingress)
  security_group_id = aws_security_group.sg.id
  cidr_ipv4         = var.ingress[count.index].cidr_ipv4
  from_port         = var.ingress[count.index].from_port
  ip_protocol       = var.ingress[count.index].ip_protocol
  to_port           = var.ingress[count.index].to_port

}
resource "aws_vpc_security_group_egress_rule" "egress" {
  count = length(var.egress)
  security_group_id = aws_security_group.sg.id
  ip_protocol       = var.egress[count.index].ip_protocol
  cidr_ipv4         = var.egress[count.index].cidr_ipv4

}