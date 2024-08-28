resource "aws_vpc" "learn-easy-vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"
}

resource "aws_internet_gateway" "ig-learn-easy" {
  vpc_id = aws_vpc.learn-easy-vpc.id
}

resource "aws_subnet" "sn-learn-easy" {
  for_each = { for network_idx, network in local.subnet_config : "${network.prefix_name}" => network }

  vpc_id                  = aws_vpc.learn-easy-vpc.id
  cidr_block              = each.value.subnet_ip
  availability_zone       = each.value.subnet_az
  map_public_ip_on_launch = each.value.is_private ? false : true

  tags = {
    Name = format("sn-learn-easy-%s", each.value.prefix_name)
  }
}

resource "aws_eip" "eip-learn-easy" {   
    for_each = local.public_subnet
    domain = "vpc"
}

resource "aws_nat_gateway" "ng-learn-easy" {
    for_each = local.public_subnet

    allocation_id = aws_eip.eip-learn-easy[each.key].id
    subnet_id = each.value.id

    tags = {
        Name = format("ng-learn-easy-%s", each.key)
    }
}

resource "aws_default_route_table" "rt-learn-easy-default" {
    default_route_table_id = aws_vpc.learn-easy-vpc.default_route_table_id

    route {
        cidr_block = "10.10.0.0/16"
        gateway_id = "local"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig-learn-easy.id
    }

    tags = {
        Name = "rt-learn-easy-main"
    }
}

resource "aws_route_table_association" "rt-association-public" {
    for_each = local.public_subnet
    route_table_id = aws_vpc.learn-easy-vpc.default_route_table_id
    subnet_id = each.value.id
}

resource "aws_route_table_association" "rt-association-private" {
    for_each = {for id, association in local.flat_subnet_association : id => association}
    route_table_id = each.value.rt_id
    subnet_id = each.value.sn_id
}

resource "aws_route_table" "rt-learn-easy" {
    for_each = local.nat_gateway_ids    
    vpc_id = aws_vpc.learn-easy-vpc.id
    route {
        cidr_block = "10.10.0.0/16"
        gateway_id = "local"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.ng-learn-easy[each.key].id
    }

    tags = {
        Name = format("rt-learn-easy-%s", each.key)
    }
}