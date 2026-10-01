# aws_vpc = resource_type
# main = internal_reference_name (which is recommended by terraform to use it as main)
# id = attribute that we want to access of that particular resource
# This vpc_id will be used in parent module for the outputs
output "vpc_id" {
    value = aws_vpc.main.id
}

output "vpc_region" {
    value = aws_vpc.main.region
}

output "igw_id" {
    value = aws_internet_gateway.igw.id
}