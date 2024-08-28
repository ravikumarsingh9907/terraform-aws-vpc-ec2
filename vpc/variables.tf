variable "subnet_details" {
    description = "subnet ip cidr_block and availability zones config"
    type = map(object({
        cidr_block = string
        subnet = map(object({
            cidr_block = string
            az = string
            is_private = bool
            prefix_name = string
        }))
    }))
    default = {
        "public" = {
            cidr_block = "10.10.0.0/16"
            subnet = {
                "us-east-1a" = {
                    cidr_block = "10.10.0.0/20"
                    az = "us-east-1a"
                    is_private = false
                    prefix_name = "web-A"
                }
                "us-east-1b" = {
                    cidr_block = "10.10.16.0/20"
                    az = "us-east-1b"
                    is_private = false
                    prefix_name = "web-B"
                }
                "us-east-1c" = {
                    cidr_block = "10.10.32.0/20"
                    az = "us-east-1c"
                    is_private = false
                    prefix_name = "web-C"
                }
            }
        }
        "private" = {
            cidr_block = "10.10.0.0/16"
            subnet = {
                "us-east-1a-server" = {
                    cidr_block = "10.10.48.0/20"
                    az = "us-east-1a"
                    is_private = true
                    prefix_name = "server-A"
                }
                "us-east-1b-server" = {
                    cidr_block = "10.10.64.0/20"
                    az = "us-east-1b"
                    is_private = true
                    prefix_name = "server-B"
                }
                "us-east-1c-server" = {
                    cidr_block = "10.10.80.0/20"
                    az = "us-east-1c"
                    is_private = true
                    prefix_name = "server-C"
                }
                "us-east-1a-db" = {
                    cidr_block = "10.10.96.0/20"
                    az = "us-east-1a"
                    is_private = true
                    prefix_name = "db-A"
                }
                "us-east-1b-db" = {
                    cidr_block = "10.10.112.0/20"
                    az = "us-east-1b"
                    is_private = true
                    prefix_name = "db-B"
                }
                "us-east-1c-db" = {
                    cidr_block = "10.10.128.0/20"
                    az = "us-east-1c"
                    is_private = true
                    prefix_name = "db-C"
                }
            }
        }
    }
}