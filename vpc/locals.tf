locals {
  subnet_config = flatten([
    for vpc_key, vpc in var.subnet_details : [
      for subnet_key, subnet in vpc.subnet : {
        network_ip  = vpc.cidr_block
        subnet_ip   = subnet.cidr_block
        subnet_az   = subnet.az
        is_private  = subnet.is_private
        prefix_name = subnet.prefix_name
      }
    ]
  ])
  public_subnet = {
    for idx, val in aws_subnet.sn-learn-easy : idx => val if val.map_public_ip_on_launch == true
  }

  private_subnet = {
    for idx, val in aws_subnet.sn-learn-easy : idx => val if val.map_public_ip_on_launch == false
  }
  nat_gateway_ids = {
    for idx, val in aws_nat_gateway.ng-learn-easy : idx => val
  }
  get_route_tables = {
    for idx, rt in aws_route_table.rt-learn-easy : idx => rt
  }
  subnet_table_mapping = {
      for key, table in local.get_route_tables : "${table.id}" => {
        for id, subnet in local.private_subnet : "${subnet.id}" => {
          sn_id = subnet.id
          rt_id = table.id
        } if split("-", subnet.tags.Name)[4] == split("-", table.tags.Name)[4]
      }
  }
  flat_subnet_association = flatten([
    for rt_key, route_table in local.subnet_table_mapping : [
      for sn_key, subnet in route_table : {
        sn_id = subnet.sn_id
        rt_id = subnet.rt_id
      }
    ]
  ])
}
