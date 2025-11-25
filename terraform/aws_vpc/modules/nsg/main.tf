
resource "aws_security_group" "base" {
  
  vpc_id = var.vpc_id
  name = var.security_group.name
  tags = var.security_group.tags
}
resource "aws_vpc_security_group_ingress_rule" "web_rules" {
    count = length(var.ingress_rules)
    security_group_id =aws_security_group.base.id
    cidr_ipv4         =   var.ingress_rules[count.index].cidr_ipv4      
    from_port         =var.ingress_rules[count.index].from_port
    ip_protocol       = var.ingress_rules[count.index].ip_protocol
    to_port           = var.ingress_rules[count.index].to_port
}

resource "aws_vpc_security_group_egress_rule" "web_rules" {
  count = length(var.egress_rules)
  security_group_id = aws_security_group.base.id
  cidr_ipv4         = var.egress_rules[count.index].cidr_ipv4
  ip_protocol       = var.egress_rules[count.index].ip_protocol
}