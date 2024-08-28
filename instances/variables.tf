variable "security_group" {
  description = "get security group id"
  type        = string
}

variable "public_subnet_ids" {
  description = "get subnet ids"
  type = map(string)
}