# VPC
resource "aws_vpc" "main" {             # giving an internal reference name as main
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"        #or dedicated
    enable_dns_hostnames = true

    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = local.common_name_suffix
        }
    )
}

#Internet Gateway
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = local.common_name_suffix
        }
    )
}

#Public Subnet
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true

    tags = merge(
        var.public_subnet_tags,
        local.common_tags,
        {
        Name = "${local.common_name_suffix}-public-${local.az_names[count.index]}"  #roboshop-dev-public-us-east-1a
        }
    )
}

#Private Subnet
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]
    # map_public_ip_on_launch = true

    tags = merge(
        var.public_subnet_tags,
        local.common_tags,
        {
        Name = "${local.common_name_suffix}-private-${local.az_names[count.index]}"  #roboshop-dev-private-us-east-1a
        }
    )
}

#Database Subnet
resource "aws_subnet" "database" {
    count = length(var.database_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    cidr_block = var.database_subnet_cidrs[count.index]
    availability_zone = local.az_names[count.index]
    # map_public_ip_on_launch = true

    tags = merge(
        var.public_subnet_tags,
        local.common_tags,
        {
        Name = "${local.common_name_suffix}-database-${local.az_names[count.index]}"  #roboshop-dev-database-us-east-1a
        }
    )
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-public"
    }
  )
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.private_route_table_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-private"
    }
  )
}

# Database Route Table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.database_route_table_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-database"
    }
  )
}

# Public Route
resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# Elastic IP
resource "aws_eip" "nat" {
  domain   = "vpc"

  tags = merge(
    var.eip_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-nat"
    }
  )
}

# NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.nat_gateway_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}