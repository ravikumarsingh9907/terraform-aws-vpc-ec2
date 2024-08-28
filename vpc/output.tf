output "vpc_id" {
  description = "created VPC id"
  value       = aws_vpc.learn-easy-vpc.id
}

output "private_subnets" {
  description = "get list of private subnet ids"
  value = {for key, value in local.private_subnet: key => value.id}
}

output "public_subnet" {
  description = "get list of public subnet ids"
  value = {for key, value in local.public_subnet: key => value.id}
}