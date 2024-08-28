provider "aws" {
  region = "us-east-1"
}

module "vpc" {
    source = "./vpc"
}

module "instance" {
  source = "./instances"
  security_group = module.security_group.sg-learn-easy-id
  public_subnet_ids = module.vpc.public_subnet
}

module "security_group" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
} 

output "vpc-module-prviate-subnets" {
  value = module.vpc.private_subnets
}

output "vpc-module-public-subnets" {
  value = module.vpc.public_subnet
}

output "vpc-module-vpc-id" {
  value = module.vpc.vpc_id
}