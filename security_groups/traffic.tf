resource "aws_vpc_security_group_egress_rule" "learn-easy-outbout-all-traffic" {
  security_group_id = aws_security_group.sg-learn-easy.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "learn-easy-inbound-httpv4" {
  security_group_id = aws_security_group.sg-learn-easy.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "learn-easy-inbound-httpv6" {
  security_group_id = aws_security_group.sg-learn-easy.id
  cidr_ipv6 = "::0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}


resource "aws_vpc_security_group_ingress_rule" "learn-easy-inbound-ssh" {
  security_group_id = aws_security_group.sg-learn-easy.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = "22"
  to_port = "22"
}